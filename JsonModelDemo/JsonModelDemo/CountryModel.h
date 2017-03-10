//
//  CountryModel.h
//  JsonModelDemo
//
//  Created by 乔丹丹 on 2017/1/25.
//  Copyright © 2017年 Fang. All rights reserved.
//

#import "JSONModel.h"

@interface CountryModel : JSONModel
@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *dialCode;
@property (nonatomic) BOOL isInEurope;

@property (nonatomic,weak) id delegate;
@property (nonatomic,copy)NSString * string;
@property (nonatomic,strong)NSMutableArray * arr;
@property (nonatomic,assign)NSInteger num;

@end
