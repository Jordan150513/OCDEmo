//
//  JSONModel.m
//  JSONModel
//

#if !__has_feature(objc_arc)
#error The JSONMOdel framework is ARC only, you can enable ARC on per file basis.
#endif


#import <objc/runtime.h>
#import <objc/message.h>


#import "JSONModel.h"
#import "JSONModelClassProperty.h"

#pragma mark - associated objects names
static const char * kMapperObjectKey;
static const char * kClassPropertiesKey;
static const char * kClassRequiredPropertyNamesKey;
static const char * kIndexPropertyNameKey;

#pragma mark - class static variables
static NSArray* allowedJSONTypes = nil;
static NSArray* allowedPrimitiveTypes = nil;
static JSONValueTransformer* valueTransformer = nil;
static Class JSONModelClass = NULL;

#pragma mark - model cache
static JSONKeyMapper* globalKeyMapper = nil;

#pragma mark - JSONModel implementation
@implementation JSONModel
{
    NSString* _description;
}

#pragma mark - initialization methods

+(void)load
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        // initialize all class static objects,
        // which are common for ALL JSONModel subclasses

        @autoreleasepool {
            allowedJSONTypes = @[
                [NSString class], [NSNumber class], [NSDecimalNumber class], [NSArray class], [NSDictionary class], [NSNull class], //immutable JSON classes
                [NSMutableString class], [NSMutableArray class], [NSMutableDictionary class] //mutable JSON classes
            ];

            allowedPrimitiveTypes = @[
                @"BOOL", @"float", @"int", @"long", @"double", @"short",
                //and some famous aliases（别名）
                @"NSInteger", @"NSUInteger",
                @"Block"
            ];

            valueTransformer = [[JSONValueTransformer alloc] init];

            // This is quite strange, but I found the test isSubclassOfClass: (line ~291) to fail if using [JSONModel class].
            // somewhat related: https://stackoverflow.com/questions/6524165/nsclassfromstring-vs-classnamednsstring
            // //; seems to break the unit tests

            // Using NSClassFromString instead of [JSONModel class], as this was breaking unit tests, see below
            //http://stackoverflow.com/questions/21394919/xcode-5-unit-test-seeing-wrong-class
            JSONModelClass = NSClassFromString(NSStringFromClass(self));
        }
    });
}
// JSON model 重要的初始化操作
-(void)__setup__
{
    //if first instance of this model, generate the property list
    // 如果是这个model实例的类 没有关联任何的属性 那就 产生出 property list 就是我们model里面声明的属性
    if (!objc_getAssociatedObject(self.class, &kClassPropertiesKey)) {
        // 如果没有给这个类关联 属性 那么就需要获取 这个model类的属性列表 ？？？
        [self __inspectProperties];
    }

    //if there's a custom key mapper, store it in the associated object
    id mapper = [[self class] keyMapper];
    if ( mapper && !objc_getAssociatedObject(self.class, &kMapperObjectKey) ) {
        objc_setAssociatedObject(
                                 self.class,
                                 &kMapperObjectKey,
                                 mapper,
                                 OBJC_ASSOCIATION_RETAIN // This is atomic
                                 );
    }
}

// JSON model 最初的初始化
// 重要的实现方法
-(id)init
{
    self = [super init];
    if (self) {
        //do initial class setup
        [self __setup__];
    }
    return self;
}
// 将NSString 转换成NSData之后 进行解析 model 的解析
-(instancetype)initWithData:(NSData *)data error:(NSError *__autoreleasing *)err
{
    //check for nil input
    // 如果是nil 还转啥model
    if (!data) {
        if (err) *err = [JSONModelError errorInputIsNil];
        return nil;
    }
    //read the json 读JSON串 序列化 转换成 字典
    JSONModelError* initError = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:kNilOptions
                                               error:&initError];

    if (initError) {
        if (err) *err = [JSONModelError errorBadJSON];
        return nil;
    }

    //init with dictionary
    // 根据序列化的JSON串的字典 初始化model
    id objModel = [self initWithDictionary:obj error:&initError];
    if (initError && err) *err = initError;
    return objModel;
}

-(id)initWithString:(NSString*)string error:(JSONModelError**)err
{
    JSONModelError* initError = nil;
    id objModel = [self initWithString:string usingEncoding:NSUTF8StringEncoding error:&initError];
    if (initError && err) *err = initError;
    return objModel;
}

-(id)initWithString:(NSString *)string usingEncoding:(NSStringEncoding)encoding error:(JSONModelError**)err
{
    //check for nil input
    // 如果是nil 还搞啥对象 直接返回nil
    if (!string) {
        if (err) *err = [JSONModelError errorInputIsNil];
        return nil;
    }

    JSONModelError* initError = nil;
    id objModel = [self initWithData:[string dataUsingEncoding:encoding] error:&initError];
    if (initError && err) *err = initError;
    return objModel;

}
// 传过来字典 进行转model
-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err
{
    //check for nil input
    //如果字典是空的 还搞毛线对象
    if (!dict) {
        if (err) *err = [JSONModelError errorInputIsNil];
        return nil;
    }

    //invalid input, just create empty instance
    // 如果是无效的输入 就创建一个空的实例model对象就可以了
    if (![dict isKindOfClass:[NSDictionary class]]) {
        if (err) *err = [JSONModelError errorInvalidDataWithMessage:@"Attempt to initialize JSONModel object using initWithDictionary:error: but the dictionary parameter was not an 'NSDictionary'."];
        return nil;
    }

    //create a class instance
    // 有效的字典对象 就需要转换成model了
    
    self = [self init]; // 这个里面做了很多事情 需要好好看看
    // 在这句话之前 self 就已经是这个样子了 这是在哪里做的？  需要确定
    /*
     * (lldb) po self
     
     <CountryModel>
     [id]: 0
     [country]: <nil>
     [isInEurope]: 0
     [dialCode]: <nil>
     </CountryModel>
     
     */
    
    if (!self) {

        //super init didn't succeed
        if (err) *err = [JSONModelError errorModelIsInvalid];
        return nil;
    }

    //check incoming data structure
    // 检查下一个 传过来的数据结构 的属性名称 跟 需要的属性名称 全不全 一样不一样
    if (![self __doesDictionary:dict matchModelWithKeyMapper:self.__keyMapper error:err]) {
        return nil;
    }

    //import the data from a dictionary
    // 传过来的属性keys 和 model里面需要的属性都是一致的了 下面就要 从 字典里 导入 数据 给model 也就是self 啦
    if (![self __importDictionary:dict withKeyMapper:self.__keyMapper validation:YES error:err]) {
        return nil;
    }

    //run any custom model validation
    // 自定义 model 的认可
    if (![self validate:err]) {
        return nil;
    }

    //model is valid! yay!
    // model 就生成了
    return self;
    // 这个时候self 就变成了这个样子
    /*
     * <CountryModel>
     [id]: 10
     [country]: Germany
     [isInEurope]: 1
     [dialCode]: 49
     </CountryModel>

     */
}

-(JSONKeyMapper*)__keyMapper
{
    //get the model key mapper
    return objc_getAssociatedObject(self.class, &kMapperObjectKey);
}

-(BOOL)__doesDictionary:(NSDictionary*)dict matchModelWithKeyMapper:(JSONKeyMapper*)keyMapper error:(NSError**)err
{
    //check if all required properties are present
    //  dict 里面是需要转换成model的数据
    NSArray* incomingKeysArray = [dict allKeys];
    NSMutableSet* requiredProperties = [self __requiredPropertyNames].mutableCopy;
    NSSet* incomingKeys = [NSSet setWithArray: incomingKeysArray];

    //transform the key names, if necessary
    if (keyMapper || globalKeyMapper) {

        NSMutableSet* transformedIncomingKeys = [NSMutableSet setWithCapacity: requiredProperties.count];
        NSString* transformedName = nil;

        //loop over the required properties list
        for (JSONModelClassProperty* property in [self __properties__]) {

            transformedName = (keyMapper||globalKeyMapper) ? [self __mapString:property.name withKeyMapper:keyMapper] : property.name;

            //check if exists and if so, add to incoming keys
            id value;
            @try {
                value = [dict valueForKeyPath:transformedName];
            }
            @catch (NSException *exception) {
                value = dict[transformedName];
            }

            if (value) {
                [transformedIncomingKeys addObject: property.name];
            }
        }

        //overwrite the raw incoming list with the mapped key names
        incomingKeys = transformedIncomingKeys;
    }

    //check for missing input keys
    // 确认 传入的数据 属性是否有缺少的
    if (![requiredProperties isSubsetOfSet:incomingKeys]) {

        //get a list of the missing properties
        // 返回缺少的属性 名称
        [requiredProperties minusSet:incomingKeys];

        //not all required properties are in - invalid input
        JMLog(@"Incoming data was invalid [%@ initWithDictionary:]. Keys missing: %@", self.class, requiredProperties);

        if (err) *err = [JSONModelError errorInvalidDataWithMissingKeys:requiredProperties];
        return NO;
    }

    //not needed anymore
    incomingKeys= nil;
    requiredProperties= nil;

    return YES;
}

-(NSString*)__mapString:(NSString*)string withKeyMapper:(JSONKeyMapper*)keyMapper
{
    if (keyMapper) {
        //custom mapper
        NSString* mappedName = [keyMapper convertValue:string];
        if (globalKeyMapper && [mappedName isEqualToString: string]) {
            mappedName = [globalKeyMapper convertValue:string];
        }
        string = mappedName;
    } else if (globalKeyMapper) {
        //global keymapper
        string = [globalKeyMapper convertValue:string];
    }

    return string;
}
// // 从 字典里 导入 数据 给 self model 赋值
-(BOOL)__importDictionary:(NSDictionary*)dict withKeyMapper:(JSONKeyMapper*)keyMapper validation:(BOOL)validation error:(NSError**)err
{
    //loop over the incoming keys and set self's properties
    // 循环遍历 即将到来的 key 然后设置 self 的属性 就是给逐一赋值
    /*  po [self __properties__]
     * <__NSArrayI 0x174058810>(
         @property primitive id (Setters = []),
         @property NSString* country (Standard JSON type, Setters = []),
         @property primitive isInEurope (Setters = []),
         @property NSString* dialCode (Standard JSON type, Setters = [])
       )
     */
    // 对数组 [self __properties__] 逐一进行操作
    for (JSONModelClassProperty* property in [self __properties__]) {

        //convert key name to model keys, if a mapper is provided
        // 如果 mapper 是存在的 就 转换 key name 到model 的属性
        NSString* jsonKeyPath = (keyMapper||globalKeyMapper) ? [self __mapString:property.name withKeyMapper:keyMapper] : property.name;
        //JMLog(@"keyPath: %@", jsonKeyPath);

        //general check for data type compliance
        id jsonValue;
        @try {
            // 根据 self 的property 名称 从字典里获取相应的值
            jsonValue = [dict valueForKeyPath: jsonKeyPath];
        }
        @catch (NSException *exception) {
            jsonValue = dict[jsonKeyPath];
        }

        //check for Optional properties
        // 获取到的属性的值 是空的
        if (isNull(jsonValue)) {
            //skip this property, continue with next property
            if (property.isOptional || !validation) continue;

            if (err) {
                //null value for required property
                NSString* msg = [NSString stringWithFormat:@"Value of required model key %@ is null", property.name];
                JSONModelError* dataErr = [JSONModelError errorInvalidDataWithMessage:msg];
                *err = [dataErr errorByPrependingKeyPathComponent:property.name];
            }
            return NO;
        }
        // 获取到相应的属性的值
        Class jsonValueClass = [jsonValue class];
        BOOL isValueOfAllowedType = NO;

        for (Class allowedType in allowedJSONTypes) {
            if ( [jsonValueClass isSubclassOfClass: allowedType] ) {
                isValueOfAllowedType = YES;
                break;
            }
        }

        if (isValueOfAllowedType==NO) {
            //type not allowed
            JMLog(@"Type %@ is not allowed in JSON.", NSStringFromClass(jsonValueClass));

            if (err) {
                NSString* msg = [NSString stringWithFormat:@"Type %@ is not allowed in JSON.", NSStringFromClass(jsonValueClass)];
                JSONModelError* dataErr = [JSONModelError errorInvalidDataWithMessage:msg];
                *err = [dataErr errorByPrependingKeyPathComponent:property.name];
            }
            return NO;
        }

        //check if there's matching property in the model
        if (property) {

            // check for custom setter, than the model doesn't need to do any guessing
            // how to read the property's value from JSON
            // 给 model 相应的属性赋值了
            if ([self __customSetValue:jsonValue forProperty:property]) {
                //skip to next JSON key
                //赋值 成功 接着进行 下一个 属性的赋值
                continue;
            };

            // 0) handle primitives（原始的） 赋值没有成功 就要进行原始的初始化 赋值了
            if (property.type == nil && property.structName==nil) {

                //generic setter
                if (jsonValue != [self valueForKey:property.name]) {
                    [self setValue:jsonValue forKey: property.name];
                }

                //skip directly to the next key
                continue;
            }

            // 0.5) handle nils
            // 属性存在 但是属性的值 不存在 就赋值为nil
            if (isNull(jsonValue)) {
                if ([self valueForKey:property.name] != nil) {
                    [self setValue:nil forKey: property.name];
                }
                continue;
            }


            // 1) check if property is itself a JSONModel
            // 处理嵌套 看这一层的 property.type  是不是另外一个 JSONModel
            if ([self __isJSONModelSubClass:property.type]) {

                //initialize the property's model, store it
//                初始化 内存的JSON Model
                JSONModelError* initErr = nil;
                id value = [[property.type alloc] initWithDictionary: jsonValue error:&initErr];

                if (!value) {
                    //skip this property, continue with next property
                    if (property.isOptional || !validation) continue;

                    // Propagate the error, including the property name as the key-path component
                    if((err != nil) && (initErr != nil))
                    {
                        *err = [initErr errorByPrependingKeyPathComponent:property.name];
                    }
                    return NO;
                }
                if (![value isEqual:[self valueForKey:property.name]]) {
                    [self setValue:value forKey: property.name];
                }

                //for clarity, does the same without continue
                continue;

            } else {

                // 2) check if there's a protocol to the property
                //  ) might or not be the case there's a built in transform for it
                if (property.protocol) {

                    //JMLog(@"proto: %@", p.protocol);
                    jsonValue = [self __transform:jsonValue forProperty:property error:err];
                    if (!jsonValue) {
                        if ((err != nil) && (*err == nil)) {
                            NSString* msg = [NSString stringWithFormat:@"Failed to transform value, but no error was set during transformation. (%@)", property];
                            JSONModelError* dataErr = [JSONModelError errorInvalidDataWithMessage:msg];
                            *err = [dataErr errorByPrependingKeyPathComponent:property.name];
                        }
                        return NO;
                    }
                }

                // 3.1) handle matching standard JSON types
                if (property.isStandardJSONType && [jsonValue isKindOfClass: property.type]) {

                    //mutable properties
                    if (property.isMutable) {
                        jsonValue = [jsonValue mutableCopy];
                    }

                    //set the property value
                    if (![jsonValue isEqual:[self valueForKey:property.name]]) {
                        [self setValue:jsonValue forKey: property.name];
                    }
                    continue;
                }

                // 3.3) handle values to transform
                if (
                    (![jsonValue isKindOfClass:property.type] && !isNull(jsonValue))
                    ||
                    //the property is mutable
                    property.isMutable
                    ||
                    //custom struct property
                    property.structName
                    ) {

                    // searched around the web how to do this better
                    // but did not find any solution, maybe that's the best idea? (hardly)
                    Class sourceClass = [JSONValueTransformer classByResolvingClusterClasses:[jsonValue class]];

                    //JMLog(@"to type: [%@] from type: [%@] transformer: [%@]", p.type, sourceClass, selectorName);

                    //build a method selector for the property and json object classes
                    NSString* selectorName = [NSString stringWithFormat:@"%@From%@:",
                                              (property.structName? property.structName : property.type), //target name
                                              sourceClass]; //source name
                    SEL selector = NSSelectorFromString(selectorName);

                    //check for custom transformer
                    BOOL foundCustomTransformer = NO;
                    if ([valueTransformer respondsToSelector:selector]) {
                        foundCustomTransformer = YES;
                    } else {
                        //try for hidden custom transformer
                        selectorName = [NSString stringWithFormat:@"__%@",selectorName];
                        selector = NSSelectorFromString(selectorName);
                        if ([valueTransformer respondsToSelector:selector]) {
                            foundCustomTransformer = YES;
                        }
                    }

                    //check if there's a transformer with that name
                    if (foundCustomTransformer) {
                        IMP imp = [valueTransformer methodForSelector:selector];
                        id (*func)(id, SEL, id) = (void *)imp;
                        jsonValue = func(valueTransformer, selector, jsonValue);

                        if (![jsonValue isEqual:[self valueForKey:property.name]])
                            [self setValue:jsonValue forKey:property.name];
                    } else {
                        NSString* msg = [NSString stringWithFormat:@"%@ type not supported for %@.%@", property.type, [self class], property.name];
                        JSONModelError* dataErr = [JSONModelError errorInvalidDataWithTypeMismatch:msg];
                        *err = [dataErr errorByPrependingKeyPathComponent:property.name];
                        return NO;
                    }
                } else {
                    // 3.4) handle "all other" cases (if any)
                    if (![jsonValue isEqual:[self valueForKey:property.name]])
                        [self setValue:jsonValue forKey:property.name];
                }
            }
        }
    }// for - in 遍历结束

    return YES;
}

#pragma mark - property inspection methods

-(BOOL)__isJSONModelSubClass:(Class)class
{
// http://stackoverflow.com/questions/19883472/objc-nsobject-issubclassofclass-gives-incorrect-failure
#ifdef UNIT_TESTING
    return [@"JSONModel" isEqualToString: NSStringFromClass([class superclass])];
#else
    return [class isSubclassOfClass:JSONModelClass];
#endif
}

//returns a set of the required keys for the model
//  返回本 model 需要的属性的名称的集合
-(NSMutableSet*)__requiredPropertyNames
{
    //fetch the associated property names
    // 都是用的 关联属性 实现 的
    NSMutableSet* classRequiredPropertyNames = objc_getAssociatedObject(self.class, &kClassRequiredPropertyNamesKey);

    if (!classRequiredPropertyNames) {
        classRequiredPropertyNames = [NSMutableSet set];
        [[self __properties__] enumerateObjectsUsingBlock:^(JSONModelClassProperty* p, NSUInteger idx, BOOL *stop) {
            if (!p.isOptional) [classRequiredPropertyNames addObject:p.name];
        }];

        //persist the list
        objc_setAssociatedObject(
                                 self.class,
                                 &kClassRequiredPropertyNamesKey,
                                 classRequiredPropertyNames,
                                 OBJC_ASSOCIATION_RETAIN // This is atomic
                                 );
    }
    return classRequiredPropertyNames;
}

//returns a list of the model's properties
-(NSArray*)__properties__
{
    //fetch the associated object
    NSDictionary* classProperties = objc_getAssociatedObject(self.class, &kClassPropertiesKey);
    if (classProperties) return [classProperties allValues];

    //if here, the class needs to inspect itself
    [self __setup__];

    //return the property list
    classProperties = objc_getAssociatedObject(self.class, &kClassPropertiesKey);
    return [classProperties allValues];
}

// 关键的实现方法
//inspects the class, get's a list of the class properties
// 获取类的属性列表 并且
-(void)__inspectProperties
{
    //JMLog(@"Inspect class: %@", [self class]);

    NSMutableDictionary* propertyIndex = [NSMutableDictionary dictionary];

    //temp variables for the loops
    // 循环的临时变量
    Class class = [self class];
    NSScanner* scanner = nil;
    NSString* propertyType = nil;

    // inspect inherited properties up to the JSONModel class
    // 审查 继承的 属性
    while (class != [JSONModel class]) {
        //JMLog(@"inspecting: %@", NSStringFromClass(class));

        unsigned int propertyCount;
        // objc_property_t *  runtime 源码中定义的类型 就是property的属性表的类型
        //  获得类的属性列表的copy值
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);

        //loop over the class properties
        // 循环每一个 propertie 做什么操作呢：转换成JSONModelClassProperty类型的 并且存储对应的类型 名字 属性
        for (unsigned int i = 0; i < propertyCount; i++) {

            JSONModelClassProperty* p = [[JSONModelClassProperty alloc] init];

            //get property name
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            p.name = @(propertyName);

            //JMLog(@"property: %@", p.name);

            //get property attributes 获取成员属性变量的属性
            const char *attrs = property_getAttributes(property);
            NSString* propertyAttributes = @(attrs);
            NSArray* attributeItems = [propertyAttributes componentsSeparatedByString:@","];

            //ignore read-only properties
            if ([attributeItems containsObject:@"R"]) {
                continue; //to next property
            }

            //check for 64b BOOLs 64位的bool值 将bool值当做 结构体 方便一起转换
            if ([propertyAttributes hasPrefix:@"Tc,"]) {
                //mask BOOLs as structs so they can have custom converters
                p.structName = @"BOOL";
            }

            scanner = [NSScanner scannerWithString: propertyAttributes];

            //JMLog(@"attr: %@", [NSString stringWithCString:attrs encoding:NSUTF8StringEncoding]);
            [scanner scanUpToString:@"T" intoString: nil];
            [scanner scanString:@"T" intoString:nil];

            //check if the property is an instance of a class 看属性类型是不是一个类 就是嵌套的一个JSONModel类的实例
            if ([scanner scanString:@"@\"" intoString: &propertyType]) {

                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                        intoString:&propertyType];

                //JMLog(@"type: %@", propertyClassName);
                p.type = NSClassFromString(propertyType);  // 是另外一个嵌套的model
                p.isMutable = ([propertyType rangeOfString:@"Mutable"].location != NSNotFound);
                p.isStandardJSONType = [allowedJSONTypes containsObject:p.type];

                //read through the property protocols 看属性有没有遵守什么协议 就是有么有明确标明“<>”
                while ([scanner scanString:@"<" intoString:NULL]) {

                    NSString* protocolName = nil;

                    [scanner scanUpToString:@">" intoString: &protocolName];

                    if ([protocolName isEqualToString:@"Optional"]) {
                        p.isOptional = YES;
                    } else if([protocolName isEqualToString:@"Index"]) {
                        // 咋这么直接 忽略警告
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
                        p.isIndex = YES;
#pragma GCC diagnostic pop

                        // 设置关联属性
                        objc_setAssociatedObject(
                                                 self.class,
                                                 &kIndexPropertyNameKey,    // 这里有一点疑问 这个key值 不太明白
                                                 p.name,
                                                 OBJC_ASSOCIATION_RETAIN // This is atomic
                                                 );
                    } else if([protocolName isEqualToString:@"Ignore"]) {
                        p = nil;
                    } else {
                        p.protocol = protocolName;
                    }

                    [scanner scanString:@">" intoString:NULL];
                }

            }
            //check if the property is a structure
            else if ([scanner scanString:@"{" intoString: &propertyType]) {
                [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                    intoString:&propertyType];

                p.isStandardJSONType = NO;
                p.structName = propertyType;

            }
            //the property must be a primitive
            else {

                //the property contains a primitive data type
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","]
                                        intoString:&propertyType];

                //get the full name of the primitive type
                propertyType = valueTransformer.primitivesNames[propertyType];

                if (![allowedPrimitiveTypes containsObject:propertyType]) {

                    //type not allowed - programmer mistaken -> exception
                    @throw [NSException exceptionWithName:@"JSONModelProperty type not allowed"
                                                   reason:[NSString stringWithFormat:@"Property type of %@.%@ is not supported by JSONModel.", self.class, p.name]
                                                 userInfo:nil];
                }

            }

            NSString *nsPropertyName = @(propertyName);
            if([[self class] propertyIsOptional:nsPropertyName]){
                p.isOptional = YES;
            }

            if([[self class] propertyIsIgnored:nsPropertyName]){
                p = nil;
            }

            Class customClass = [[self class] classForCollectionProperty:nsPropertyName];
            if (customClass) {
                p.protocol = NSStringFromClass(customClass);
            }

            //few cases where JSONModel will ignore properties automatically
            if ([propertyType isEqualToString:@"Block"]) {
                p = nil;
            }

            //add the property object to the temp index
            if (p && ![propertyIndex objectForKey:p.name]) {
                [propertyIndex setValue:p forKey:p.name];
            }

            // generate custom setters and getter  创建 set get 方法
            if (p)
            {
                NSString *name = [p.name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[p.name substringToIndex:1].uppercaseString];

                // getter
                SEL getter = NSSelectorFromString([NSString stringWithFormat:@"JSONObjectFor%@", name]);

                if ([self respondsToSelector:getter])
                    p.customGetter = getter;

                // setters
                p.customSetters = [NSMutableDictionary new];

                SEL genericSetter = NSSelectorFromString([NSString stringWithFormat:@"set%@WithJSONObject:", name]);

                if ([self respondsToSelector:genericSetter])
                    p.customSetters[@"generic"] = [NSValue valueWithBytes:&genericSetter objCType:@encode(SEL)];

                for (Class type in allowedJSONTypes)
                {
                    NSString *class = NSStringFromClass([JSONValueTransformer classByResolvingClusterClasses:type]);

                    if (p.customSetters[class])
                        continue;

                    SEL setter = NSSelectorFromString([NSString stringWithFormat:@"set%@With%@:", name, class]);

                    if ([self respondsToSelector:setter])
                        p.customSetters[class] = [NSValue valueWithBytes:&setter objCType:@encode(SEL)];
                }
            }
        }
// for 循环结束
        free(properties);

        //ascend to the super of the class
        //(will do that until it reaches the root class - JSONModel)
        class = [class superclass];
    }
// while 循环结束
    // 最后  把属性的索引通过关联属性 各类增加一个关联属性 存储到 静态的 &kClassPropertiesKey 属性索引里？？
    //finally store the property index in the static property index
    objc_setAssociatedObject(
                             self.class,
                             &kClassPropertiesKey,
                             [propertyIndex copy], // 将 暂时变量给关联了
                             OBJC_ASSOCIATION_RETAIN // This is atomic
                             );
}

#pragma mark - built-in transformer methods
//few built-in transformations
-(id)__transform:(id)value forProperty:(JSONModelClassProperty*)property error:(NSError**)err
{
    Class protocolClass = NSClassFromString(property.protocol);
    if (!protocolClass) {

        //no other protocols on arrays and dictionaries
        //except JSONModel classes
        if ([value isKindOfClass:[NSArray class]]) {
            @throw [NSException exceptionWithName:@"Bad property protocol declaration"
                                           reason:[NSString stringWithFormat:@"<%@> is not allowed JSONModel property protocol, and not a JSONModel class.", property.protocol]
                                         userInfo:nil];
        }
        return value;
    }

    //if the protocol is actually a JSONModel class
    if ([self __isJSONModelSubClass:protocolClass]) {

        //check if it's a list of models
        if ([property.type isSubclassOfClass:[NSArray class]]) {

            // Expecting an array, make sure 'value' is an array
            if(![[value class] isSubclassOfClass:[NSArray class]])
            {
                if(err != nil)
                {
                    NSString* mismatch = [NSString stringWithFormat:@"Property '%@' is declared as NSArray<%@>* but the corresponding JSON value is not a JSON Array.", property.name, property.protocol];
                    JSONModelError* typeErr = [JSONModelError errorInvalidDataWithTypeMismatch:mismatch];
                    *err = [typeErr errorByPrependingKeyPathComponent:property.name];
                }
                return nil;
            }

            //one shot conversion
            JSONModelError* arrayErr = nil;
            value = [[protocolClass class] arrayOfModelsFromDictionaries:value error:&arrayErr];
            if((err != nil) && (arrayErr != nil))
            {
                *err = [arrayErr errorByPrependingKeyPathComponent:property.name];
                return nil;
            }
        }

        //check if it's a dictionary of models
        if ([property.type isSubclassOfClass:[NSDictionary class]]) {

            // Expecting a dictionary, make sure 'value' is a dictionary
            if(![[value class] isSubclassOfClass:[NSDictionary class]])
            {
                if(err != nil)
                {
                    NSString* mismatch = [NSString stringWithFormat:@"Property '%@' is declared as NSDictionary<%@>* but the corresponding JSON value is not a JSON Object.", property.name, property.protocol];
                    JSONModelError* typeErr = [JSONModelError errorInvalidDataWithTypeMismatch:mismatch];
                    *err = [typeErr errorByPrependingKeyPathComponent:property.name];
                }
                return nil;
            }

            NSMutableDictionary* res = [NSMutableDictionary dictionary];

            for (NSString* key in [value allKeys]) {
                JSONModelError* initErr = nil;
                id obj = [[[protocolClass class] alloc] initWithDictionary:value[key] error:&initErr];
                if (obj == nil)
                {
                    // Propagate the error, including the property name as the key-path component
                    if((err != nil) && (initErr != nil))
                    {
                        initErr = [initErr errorByPrependingKeyPathComponent:key];
                        *err = [initErr errorByPrependingKeyPathComponent:property.name];
                    }
                    return nil;
                }
                [res setValue:obj forKey:key];
            }
            value = [NSDictionary dictionaryWithDictionary:res];
        }
    }

    return value;
}

//built-in reverse transformations (export to JSON compliant objects)
-(id)__reverseTransform:(id)value forProperty:(JSONModelClassProperty*)property
{
    Class protocolClass = NSClassFromString(property.protocol);
    if (!protocolClass) return value;

    //if the protocol is actually a JSONModel class
    if ([self __isJSONModelSubClass:protocolClass]) {

        //check if should export list of dictionaries
        if (property.type == [NSArray class] || property.type == [NSMutableArray class]) {
            NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity: [(NSArray*)value count] ];
            for (NSObject<AbstractJSONModelProtocol>* model in (NSArray*)value) {
                if ([model respondsToSelector:@selector(toDictionary)]) {
                    [tempArray addObject: [model toDictionary]];
                } else
                    [tempArray addObject: model];
            }
            return [tempArray copy];
        }

        //check if should export dictionary of dictionaries
        if (property.type == [NSDictionary class] || property.type == [NSMutableDictionary class]) {
            NSMutableDictionary* res = [NSMutableDictionary dictionary];
            for (NSString* key in [(NSDictionary*)value allKeys]) {
                id<AbstractJSONModelProtocol> model = value[key];
                [res setValue: [model toDictionary] forKey: key];
            }
            return [NSDictionary dictionaryWithDictionary:res];
        }
    }

    return value;
}

#pragma mark - custom transformations
// 给相应的属性 赋值了
- (BOOL)__customSetValue:(id <NSObject>)value forProperty:(JSONModelClassProperty *)property
{
    NSString *class = NSStringFromClass([JSONValueTransformer classByResolvingClusterClasses:[value class]]);

    SEL setter = nil;
    [property.customSetters[class] getValue:&setter];

    if (!setter)
        [property.customSetters[@"generic"] getValue:&setter];

    if (!setter)
        return NO;

    IMP imp = [self methodForSelector:setter];
    void (*func)(id, SEL, id <NSObject>) = (void *)imp;
    func(self, setter, value);

    return YES;
}

- (BOOL)__customGetValue:(id *)value forProperty:(JSONModelClassProperty *)property
{
    SEL getter = property.customGetter;

    if (!getter)
        return NO;

    IMP imp = [self methodForSelector:getter];
    id (*func)(id, SEL) = (void *)imp;
    *value = func(self, getter);

    return YES;
}

#pragma mark - persistance
-(void)__createDictionariesForKeyPath:(NSString*)keyPath inDictionary:(NSMutableDictionary**)dict
{
    //find if there's a dot left in the keyPath
    NSUInteger dotLocation = [keyPath rangeOfString:@"."].location;
    if (dotLocation==NSNotFound) return;

    //inspect next level
    NSString* nextHierarchyLevelKeyName = [keyPath substringToIndex: dotLocation];
    NSDictionary* nextLevelDictionary = (*dict)[nextHierarchyLevelKeyName];

    if (nextLevelDictionary==nil) {
        //create non-existing next level here
        nextLevelDictionary = [NSMutableDictionary dictionary];
    }

    //recurse levels
    [self __createDictionariesForKeyPath:[keyPath substringFromIndex: dotLocation+1]
                            inDictionary:&nextLevelDictionary ];

    //create the hierarchy level
    [*dict setValue:nextLevelDictionary  forKeyPath: nextHierarchyLevelKeyName];
}

-(NSDictionary*)toDictionary
{
    return [self toDictionaryWithKeys:nil];
}

-(NSString*)toJSONString
{
    return [self toJSONStringWithKeys:nil];
}

-(NSData*)toJSONData
{
    return [self toJSONDataWithKeys:nil];
}

//exports the model as a dictionary of JSON compliant objects
-(NSDictionary*)toDictionaryWithKeys:(NSArray*)propertyNames
{
    NSArray* properties = [self __properties__];
    NSMutableDictionary* tempDictionary = [NSMutableDictionary dictionaryWithCapacity:properties.count];

    id value;

    //loop over all properties
    for (JSONModelClassProperty* p in properties) {

        //skip if unwanted
        if (propertyNames != nil && ![propertyNames containsObject:p.name])
            continue;

        //fetch key and value
        NSString* keyPath = (self.__keyMapper||globalKeyMapper) ? [self __mapString:p.name withKeyMapper:self.__keyMapper] : p.name;
        value = [self valueForKey: p.name];

        //JMLog(@"toDictionary[%@]->[%@] = '%@'", p.name, keyPath, value);

        if ([keyPath rangeOfString:@"."].location != NSNotFound) {
            //there are sub-keys, introduce dictionaries for them
            [self __createDictionariesForKeyPath:keyPath inDictionary:&tempDictionary];
        }

        //check for custom getter
        if ([self __customGetValue:&value forProperty:p]) {
            //custom getter, all done
            [tempDictionary setValue:value forKeyPath:keyPath];
            continue;
        }

        //export nil when they are not optional values as JSON null, so that the structure of the exported data
        //is still valid if it's to be imported as a model again
        if (isNull(value)) {

            if (value == nil)
            {
                [tempDictionary removeObjectForKey:keyPath];
            }
            else
            {
                [tempDictionary setValue:[NSNull null] forKeyPath:keyPath];
            }
            continue;
        }

        //check if the property is another model
        if ([value isKindOfClass:JSONModelClass]) {

            //recurse models
            value = [(JSONModel*)value toDictionary];
            [tempDictionary setValue:value forKeyPath: keyPath];

            //for clarity
            continue;

        } else {

            // 1) check for built-in transformation
            if (p.protocol) {
                value = [self __reverseTransform:value forProperty:p];
            }

            // 2) check for standard types OR 2.1) primitives
            if (p.structName==nil && (p.isStandardJSONType || p.type==nil)) {

                //generic get value
                [tempDictionary setValue:value forKeyPath: keyPath];

                continue;
            }

            // 3) try to apply a value transformer
            if (YES) {

                //create selector from the property's class name
                NSString* selectorName = [NSString stringWithFormat:@"%@From%@:", @"JSONObject", p.type?p.type:p.structName];
                SEL selector = NSSelectorFromString(selectorName);

                BOOL foundCustomTransformer = NO;
                if ([valueTransformer respondsToSelector:selector]) {
                    foundCustomTransformer = YES;
                } else {
                    //try for hidden transformer
                    selectorName = [NSString stringWithFormat:@"__%@",selectorName];
                    selector = NSSelectorFromString(selectorName);
                    if ([valueTransformer respondsToSelector:selector]) {
                        foundCustomTransformer = YES;
                    }
                }

                //check if there's a transformer declared
                if (foundCustomTransformer) {
                    IMP imp = [valueTransformer methodForSelector:selector];
                    id (*func)(id, SEL, id) = (void *)imp;
                    value = func(valueTransformer, selector, value);

                    [tempDictionary setValue:value forKeyPath:keyPath];
                } else {
                    //in this case most probably a custom property was defined in a model
                    //but no default reverse transformer for it
                    @throw [NSException exceptionWithName:@"Value transformer not found"
                                                   reason:[NSString stringWithFormat:@"[JSONValueTransformer %@] not found", selectorName]
                                                 userInfo:nil];
                    return nil;
                }
            }
        }
    }

    return [tempDictionary copy];
}

//exports model to a dictionary and then to a JSON string
-(NSData*)toJSONDataWithKeys:(NSArray*)propertyNames
{
    NSData* jsonData = nil;
    NSError* jsonError = nil;

    @try {
        NSDictionary* dict = [self toDictionaryWithKeys:propertyNames];
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&jsonError];
    }
    @catch (NSException *exception) {
        //this should not happen in properly design JSONModel
        //usually means there was no reverse transformer for a custom property
        JMLog(@"EXCEPTION: %@", exception.description);
        return nil;
    }

    return jsonData;
}

-(NSString*)toJSONStringWithKeys:(NSArray*)propertyNames
{
    return [[NSString alloc] initWithData: [self toJSONDataWithKeys: propertyNames]
                                 encoding: NSUTF8StringEncoding];
}

#pragma mark - import/export of lists
//loop over an NSArray of JSON objects and turn them into models
+(NSMutableArray*)arrayOfModelsFromDictionaries:(NSArray*)array
{
    return [self arrayOfModelsFromDictionaries:array error:nil];
}

+ (NSMutableArray *)arrayOfModelsFromData:(NSData *)data error:(NSError **)err
{
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:err];
    if (!json || ![json isKindOfClass:[NSArray class]]) return nil;

    return [self arrayOfModelsFromDictionaries:json error:err];
}

+ (NSMutableArray *)arrayOfModelsFromString:(NSString *)string error:(NSError **)err
{
    return [self arrayOfModelsFromData:[string dataUsingEncoding:NSUTF8StringEncoding] error:err];
}

// Same as above, but with error reporting
+(NSMutableArray*)arrayOfModelsFromDictionaries:(NSArray*)array error:(NSError**)err
{
    //bail early
    if (isNull(array)) return nil;

    //parse dictionaries to objects
    NSMutableArray* list = [NSMutableArray arrayWithCapacity: [array count]];

    for (id d in array)
    {
        if ([d isKindOfClass:NSDictionary.class])
        {
            JSONModelError* initErr = nil;
            id obj = [[self alloc] initWithDictionary:d error:&initErr];
            if (obj == nil)
            {
                // Propagate the error, including the array index as the key-path component
                if((err != nil) && (initErr != nil))
                {
                    NSString* path = [NSString stringWithFormat:@"[%lu]", (unsigned long)list.count];
                    *err = [initErr errorByPrependingKeyPathComponent:path];
                }
                return nil;
            }

            [list addObject: obj];
        } else if ([d isKindOfClass:NSArray.class])
        {
            [list addObjectsFromArray:[self arrayOfModelsFromDictionaries:d error:err]];
        } else
        {
            // This is very bad
        }

    }

    return list;
}

+ (NSMutableDictionary *)dictionaryOfModelsFromString:(NSString *)string error:(NSError **)err
{
    return [self dictionaryOfModelsFromData:[string dataUsingEncoding:NSUTF8StringEncoding] error:err];
}

+ (NSMutableDictionary *)dictionaryOfModelsFromData:(NSData *)data error:(NSError **)err
{
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:err];
    if (!json || ![json isKindOfClass:[NSDictionary class]]) return nil;

    return [self dictionaryOfModelsFromDictionary:json error:err];
}

+ (NSMutableDictionary *)dictionaryOfModelsFromDictionary:(NSDictionary *)dictionary error:(NSError **)err
{
    NSMutableDictionary *output = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];

    for (NSString *key in dictionary.allKeys)
    {
        id object = dictionary[key];

        if ([object isKindOfClass:NSDictionary.class])
        {
            id obj = [[self alloc] initWithDictionary:object error:err];
            if (obj == nil) return nil;
            output[key] = obj;
        }
        else if ([object isKindOfClass:NSArray.class])
        {
            id obj = [self arrayOfModelsFromDictionaries:object error:err];
            if (obj == nil) return nil;
            output[key] = obj;
        }
        else
        {
            *err = [JSONModelError errorInvalidDataWithTypeMismatch:@"Only dictionaries and arrays are supported"];
            return nil;
        }
    }

    return output;
}

//loop over NSArray of models and export them to JSON objects
+(NSMutableArray*)arrayOfDictionariesFromModels:(NSArray*)array
{
    //bail early
    if (isNull(array)) return nil;

    //convert to dictionaries
    NSMutableArray* list = [NSMutableArray arrayWithCapacity: [array count]];

    for (id<AbstractJSONModelProtocol> object in array) {

        id obj = [object toDictionary];
        if (!obj) return nil;

        [list addObject: obj];
    }
    return list;
}

//loop over NSArray of models and export them to JSON objects with specific properties
+(NSMutableArray*)arrayOfDictionariesFromModels:(NSArray*)array propertyNamesToExport:(NSArray*)propertyNamesToExport;
{
    //bail early
    if (isNull(array)) return nil;

    //convert to dictionaries
    NSMutableArray* list = [NSMutableArray arrayWithCapacity: [array count]];

    for (id<AbstractJSONModelProtocol> object in array) {

        id obj = [object toDictionaryWithKeys:propertyNamesToExport];
        if (!obj) return nil;

        [list addObject: obj];
    }
    return list;
}

+(NSMutableDictionary *)dictionaryOfDictionariesFromModels:(NSDictionary *)dictionary
{
    //bail early
    if (isNull(dictionary)) return nil;

    NSMutableDictionary *output = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];

    for (NSString *key in dictionary.allKeys) {
        id <AbstractJSONModelProtocol> object = dictionary[key];
        id obj = [object toDictionary];
        if (!obj) return nil;
        output[key] = obj;
    }

    return output;
}

#pragma mark - custom comparison methods

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-(NSString*)indexPropertyName
{
    //custom getter for an associated object
    return objc_getAssociatedObject(self.class, &kIndexPropertyNameKey);
}

-(BOOL)isEqual:(id)object
{
    //bail early if different classes
    if (![object isMemberOfClass:[self class]]) return NO;

    if (self.indexPropertyName) {
        //there's a defined ID property
        id objectId = [object valueForKey: self.indexPropertyName];
        return [[self valueForKey: self.indexPropertyName] isEqual:objectId];
    }

    //default isEqual implementation
    return [super isEqual:object];
}

-(NSComparisonResult)compare:(id)object
{
    if (self.indexPropertyName) {
        id objectId = [object valueForKey: self.indexPropertyName];
        if ([objectId respondsToSelector:@selector(compare:)]) {
            return [[self valueForKey:self.indexPropertyName] compare:objectId];
        }
    }

    //on purpose postponing the asserts for speed optimization
    //these should not happen anyway in production conditions
    NSAssert(self.indexPropertyName, @"Can't compare models with no <Index> property");
    NSAssert1(NO, @"The <Index> property of %@ is not comparable class.", [self class]);
    return kNilOptions;
}

- (NSUInteger)hash
{
    if (self.indexPropertyName) {
        id val = [self valueForKey:self.indexPropertyName];

        if (val) {
            return [val hash];
        }
    }

    return [super hash];
}

#pragma GCC diagnostic pop

#pragma mark - custom data validation
-(BOOL)validate:(NSError**)error
{
    return YES;
}

#pragma mark - custom recursive description
//custom description method for debugging purposes
-(NSString*)description
{
    NSMutableString* text = [NSMutableString stringWithFormat:@"<%@> \n", [self class]];

    for (JSONModelClassProperty *p in [self __properties__]) {

        id value = ([p.name isEqualToString:@"description"])?self->_description:[self valueForKey:p.name];
        NSString* valueDescription = (value)?[value description]:@"<nil>";

        if (p.isStandardJSONType && ![value respondsToSelector:@selector(count)] && [valueDescription length]>60) {

            //cap description for longer values
            valueDescription = [NSString stringWithFormat:@"%@...", [valueDescription substringToIndex:59]];
        }
        valueDescription = [valueDescription stringByReplacingOccurrencesOfString:@"\n" withString:@"\n   "];
        [text appendFormat:@"   [%@]: %@\n", p.name, valueDescription];
    }

    [text appendFormat:@"</%@>", [self class]];
    return text;
}

#pragma mark - key mapping
+(JSONKeyMapper*)keyMapper
{
    return nil;
}

+(void)setGlobalKeyMapper:(JSONKeyMapper*)globalKeyMapperParam
{
    globalKeyMapper = globalKeyMapperParam;
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return NO;
}

+(BOOL)propertyIsIgnored:(NSString *)propertyName
{
    return NO;
}

+(NSString*)protocolForArrayProperty:(NSString *)propertyName
{
    return nil;
}

+(Class)classForCollectionProperty:(NSString *)propertyName
{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSString *protocolName = [self protocolForArrayProperty:propertyName];
#pragma GCC diagnostic pop

    if (!protocolName)
        return nil;

    return NSClassFromString(protocolName);
}

#pragma mark - working with incomplete models
- (void)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping
{
    [self mergeFromDictionary:dict useKeyMapping:useKeyMapping error:nil];
}

- (BOOL)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping error:(NSError **)error
{
    return [self __importDictionary:dict withKeyMapper:(useKeyMapping)? self.__keyMapper:nil validation:NO error:error];
}

#pragma mark - NSCopying, NSCoding
-(instancetype)copyWithZone:(NSZone *)zone
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:
        [NSKeyedArchiver archivedDataWithRootObject:self]
     ];
}

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    NSString* json;

    if ([decoder respondsToSelector:@selector(decodeObjectOfClass:forKey:)]) {
        json = [decoder decodeObjectOfClass:[NSString class] forKey:@"json"];
    } else {
        json = [decoder decodeObjectForKey:@"json"];
    }

    JSONModelError *error = nil;
    self = [self initWithString:json error:&error];
    if (error) {
        JMLog(@"%@",[error localizedDescription]);
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.toJSONString forKey:@"json"];
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

@end
