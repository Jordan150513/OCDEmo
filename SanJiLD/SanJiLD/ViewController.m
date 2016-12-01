//
//  ViewController.m
//  SanJiLD
//
//  Created by 乔丹丹 on 2016/11/30.
//  Copyright © 2016年 Fang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSArray * proviceArr;
@property(nonatomic,strong)NSArray * cityArr;
@property(nonatomic,strong)NSArray * xianArr;
@property(nonatomic,strong)NSArray * currentCityArr;
@property(nonatomic,strong)NSArray * currentXianArr;
@property(nonatomic,strong)UIPickerView * pickView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIPickerView * pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 400)];
//    NSString * dataSource = @"{"Identity":0,"SanJiDatas":[{"ProvinceId":0,"ProvinceName":"北京","ProvinceCode":"BJ","CityDatas":[{"CityId":"0","CityName":"北京","CityCode":"BJ","XianDatas":[{"XianId":"0","XianName":"丰台","XianCode":"FT"},{"XianId":"0","XianName":"朝阳","XianCode":"FT"},{"XianId":"0","XianName":"西城","XianCode":"FT"},{"XianId":"0","XianName":"海淀","XianCode":"FT"}]}]},{"ProvinceId":0,"ProvinceName":"河南","ProvinceCode":"BJ","CityDatas":[{"CityId":"0","CityName":"焦作","CityCode":"BJ","XianDatas":[{"XianId":"0","XianName":"武陟","XianCode":"FT"}]}]},{"ProvinceId":0,"ProvinceName":"湖南","ProvinceCode":"BJ","CityDatas":[{"CityId":"0","CityName":"长沙","CityCode":"BJ","XianDatas":[{"XianId":"0","XianName":"洪山区","XianCode":"FT"}]}]},{"ProvinceId":0,"ProvinceName":"安徽","ProvinceCode":"BJ","CityDatas":[{"CityId":"0","CityName":"合肥","CityCode":"BJ","XianDatas":[{"XianId":"0","XianName":"宣武区","XianCode":"FT"}]}]}],"IsSuccess":1,"ErrorMessage":""}";

    NSArray * proviceArr = @[@"河北",@"河南"];
    NSArray * cityArr = @[@[@"石家庄",@"唐山"],@[@"郑州",@"焦作"]];
    NSArray * xianArr = @[@[@[@"石家庄1",@"石家庄2",@"石家庄3",@"石家庄4"],@[@"唐山1",@"唐山2",@"唐山3",@"唐山4"]],@[@[@"郑州1",@"郑州2",@"郑州3"],@[@"焦作1",@"焦作2",@"焦作3"]]];;
    /*
     @[
     @[
     @[@"石家庄1",@"石家庄2",@"石家庄3",@"石家庄4"],
     @[@"唐山1",@"唐山2",@"唐山3",@"唐山4"],
     ],
     @[
     @[@"郑州1",@"郑州2",@"郑州3",@"郑州4"],
     @[@"焦作1",@"焦作2",@"焦作3",@"焦作4"],
     ]
     ]
     */
    self.proviceArr = proviceArr;
    self.cityArr = cityArr;
    self.xianArr = xianArr;
    //设置Default情况
    self.currentCityArr = cityArr[0];
    self.currentXianArr = xianArr[0][0];
    
    pickView.dataSource = self;
    pickView.delegate = self;
    [self.view addSubview:pickView];
    self.pickView = pickView;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component == 0) {
        return self.proviceArr.count;
    }else if (component == 1){
    
        return self.currentCityArr.count;
    }else{
        return self.currentXianArr.count;
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return ([UIScreen mainScreen].bounds.size.width-20)/3;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.proviceArr[row];
    }else if(component == 1){
        return self.currentCityArr[row];
    }else{
        return self.currentXianArr[row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        //滚动省是row，设置市，县全部为默认的第一个，目前最佳的方法
//        NSInteger aleadyChooseCityIndex = [pickerView selectedRowInComponent:1];//
        self.currentCityArr = self.cityArr[row];
        self.currentXianArr = self.xianArr[row][0];
        [self.pickView reloadComponent:component+1];
        [self.pickView reloadComponent:component+2];
        //这样会存在一种情况，两个范围不一样，越界会崩溃
        //更加好的一种方法，只要滚动省，市县，全部滚动到第一个
        [self.pickView selectRow:0 inComponent:1 animated:YES];
    }else if(component == 1){
    //滚动选择市是row,设置县
        NSInteger aleadyChooseProvinceIndex = [pickerView selectedRowInComponent:0];
        self.currentXianArr = self.xianArr[aleadyChooseProvinceIndex][row];
        [self.pickView reloadComponent:component+1];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadJSon:(UIButton *)sender {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:@"http://192.168.0.104:8888"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
