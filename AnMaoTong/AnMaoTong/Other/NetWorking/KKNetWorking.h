//
//  CHNetWorking.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKNetWorking : AFHTTPSessionManager
//定义枚举类型
typedef enum {
    GET = 0,//GET
    POST = 1,//POST
}HTTPMothd;

//方法内Bolck回调
typedef void(^Completion)(BOOL isSuccess,id json,NSInteger code);
//方法内Bolck回调
typedef void(^ProgressBlock)(NSProgress *uploadProgress);

//初始化方法
+(KKNetWorking *)getShard;

//请求网络返数据
-(void)request:(HTTPMothd)Mothd url:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(Completion)result;

//上传图片(限制2M大小)
- (void)uploadImageWithUrl:(NSString *)urlString imageName:(NSString *)imageName image:(UIImage *)image completion:(Completion)resultConpletion;

-(void)networkReachability;

@end
