//
//  CHNetWorking.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "KKNetWorking.h"
#import <AdSupport/AdSupport.h>

@implementation KKNetWorking
//单列属性
static KKNetWorking * shard;

//单列类的创建
+ (KKNetWorking *)getShard
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shard = [[KKNetWorking alloc]init];
        shard.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"charset=utf-8",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/plain", nil];
        shard.requestSerializer.timeoutInterval = 20.f;
    });
    
    return shard;
    
}

//添加请求头
- (void)addRequestSerializerHead:(NSString *)urlStr
{
    
    shard.requestSerializer = [AFJSONRequestSerializer serializer];

    
    User *user   = [UserHelper shareInstance].user;
    NSString *userId    = [NSString stringWithFormat:@"%@",user.user_id ? user.user_id : @""];
    NSString *random    = [NSString stringWithFormat:@"%d",arc4random_uniform(100000)];
    NSString *token     = [NSString stringWithFormat:@"%@",user.token ? user.token : @""];
    NSString *platform  = @"ios";
    NSString *version   = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *total     = [CP_AES cpStringToAes256_encrypt:[NSString stringWithFormat:@"%@%@%@%@%@",KKString(userId),random,token,platform,version]];
    
    KKLog(@"url:%@      token:%@    userId:%@",urlStr,token,userId)
    
    [self.requestSerializer setValue:KKString(userId) forHTTPHeaderField:@"HTTP_USERID"];
    [self.requestSerializer setValue:KKString(random) forHTTPHeaderField:@"HTTP_RANDOM"];
    [self.requestSerializer setValue:KKString(token) forHTTPHeaderField:@"HTTP_TOKEN"];
    [self.requestSerializer setValue:KKString(platform) forHTTPHeaderField:@"HTTP_PLATFORM"];
    [self.requestSerializer setValue:KKString(version) forHTTPHeaderField:@"HTTP_VERSION"];
    [self.requestSerializer setValue:KKString(total) forHTTPHeaderField:@"HTTP_TOTAL"];
    
    [shard.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    shard.requestSerializer.timeoutInterval = 30.f;
    [shard.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
}

/**
 网络请求
 */
- (void)request:(HTTPMothd)Mothd url:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(Completion)resultConpletion
{
    [self addRequestSerializerHead:urlString];
    
    if ([urlString rangeOfString:@"getSuggestedShopList"].location != NSNotFound) {
       
    }
    KKLog(@"HTTPRequestHeaders>>>>>>>>%@,\nurlString>>>>>>>>%@,\nparameters>>>>>>>>>>>>%@",shard.requestSerializer.HTTPRequestHeaders,urlString,parameters);
    
    //成功回调
    void(^successBolck)(NSURLSessionDataTask * task,id json) = ^(NSURLSessionDataTask * task,id json){
                 resultConpletion(YES,json,[json[@"code"] integerValue]);
    };
    
    //失败回调
    void(^failureBolck)(NSURLSessionDataTask * task,NSError * error) = ^(NSURLSessionDataTask * task,NSError * error){
        KKLog(@"%@",error);
        resultConpletion(NO,@{@"code":@"0",@"message" : kServerErrMsg},0);
        //        shard.isUse==YES ? NSLog(@""):LFLog(@"请求失败%@",error);
    };
    
    ///判断是GET还是POST
    if (Mothd == GET)
    {
        [shard GET:urlString parameters:parameters progress:nil success:successBolck failure:failureBolck];
        
    }else {
        [shard POST:urlString parameters:parameters progress:nil success:successBolck failure:failureBolck];
    }
}

//上传图片(限制2M大小)
- (void)uploadImageWithUrl:(NSString *)urlString imageName:(NSString *)imageName image:(UIImage *)image completion:(Completion)resultConpletion
{
     [self addRequestSerializerHead:urlString];
//    KKLog(@"HTTPRequestHeaders>>>>>>>>%@,urlString>>>>>>>>%@",shard.requestSerializer.HTTPRequestHeaders,urlString);

    [shard POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩图片，限制大小为2M
        NSData *imageData = [image compressQualityWithMaxLength:2*1024*1024];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg", str, [UserHelper shareInstance].user.user_id];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:imageName
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传成功
            resultConpletion(YES, responseObject,[responseObject[@"code"] integerValue]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        resultConpletion(NO, @{@"code" : @"0",
                               @"message" : kServerErrMsg},0);
    }];
}


//网络监听
- (void)networkReachability
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status==AFNetworkReachabilityStatusNotReachable) {
            
            [shard tipNetworkReachability];
            
            //网络不可用，发送通知
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"internetConnet"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"internetConnet"];
        }
    }];
    //开始监听
    [manager startMonitoring];
}

//网络是否可用的状态
- (void)tipNetworkReachability
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您的网络好像不大给力，请检查网络状态" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [getWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
//    [getWindow.rootViewController.view kk_showCenterHUDWithTitle:@"您的网络好像不大给力，请稍后再试 "];
}

- (NSString *)getRandomNumber:(int)from to:(int)to
{
    return [NSString stringWithFormat:@"%u",(from + (arc4random() % (to - from + 1)))];
}

@end

