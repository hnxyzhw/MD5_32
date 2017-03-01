//
//  ViewController.m
//  MD5_32
//
//  Created by andson-zhw on 17/3/1.
//  Copyright © 2017年 andson. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *mdStr = @"key笑话needContent1page3showapi_appid32921typeId2cc5b4721bb394890b2cd75128b1189f4";
    
    
    NSArray *arr = @[@"key",@"showapi_timestamp",@"page",@"needContent",@"showapi_appid",@"typeId"];
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        
        NSRange range = NSMakeRange(0,obj1.length);
        
        return [obj1 compare:obj2 options:comparisonOptions range:range];
        
    };
    
    NSArray *resultArray = [arr sortedArrayUsingComparator:sort];
    
    NSLog(@"字符串数组排序结果%@",resultArray);
    
    NSString *newMdStr = [NSString MD5ForUpper32Bate:mdStr];//[self md532BitUpper:mdStr];
    
    NSLog(@"=====================:\n%@",newMdStr);
    
    [self loadData];
}

-(void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    //返回错误Code=-1016 "Request failed: unacceptable content-type: application/json"
    
    //设置如下数据类型接收
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *urlStr = @"https://route.showapi.com/582-2?key=%E7%AC%91%E8%AF%9D&needContent=1&page=3&showapi_appid=32921&typeId=2&showapi_sign=CB79823A43613197DE48169E32DDE366";
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回结果成功==================:\n%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"返回结果错误:%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
