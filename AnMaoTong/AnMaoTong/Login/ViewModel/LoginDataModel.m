//
//  LoginDataModel.m
//  yuexia
//
//  Created by 陈平 on 2017/12/5.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "LoginDataModel.h"

//定时器的最大时间
const NSInteger codeMaxTime = 60;

@interface LoginDataModel ()

/**
 定时器
 */
@property (nonatomic , strong) NSTimer *timer;

@end


@implementation LoginDataModel

#pragma mark - set

#pragma mark - 生命周期
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.codeTime = codeMaxTime;
        self.isTimerOpen = NO;
    }
    return self;
}

#pragma mark - Private Method
- (void)timerUpdata
{
    self.codeTime --;
    if (self.codeTime <= 0)
    {
        [self endTimer];
    }
}

#pragma mark - Public Method
- (void)startTimer
{
    if (self.isTimerOpen == NO)
    {
        self.isTimerOpen = YES;
        self.timer.fireDate = [NSDate distantPast];
    }
}

- (void)endTimer
{
    if (self.isTimerOpen)
    {
        self.isTimerOpen = NO;
        _timer.fireDate = [NSDate distantFuture];
        [_timer invalidate];
        _timer = nil;
        self.codeTime = codeMaxTime;
    }
}

#pragma mark - get
- (NSTimer *)timer
{
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerUpdata) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (RACCommand *)getCodeCommand
{
    if (_getCodeCommand == nil)
    {
        _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){
                [SVProgressHUD show];
                [[KKNetWorking getShard] request:GET url:getCode parameters:@{@"phone":KKString(input)} completion:^(BOOL isSuccess, id json, NSInteger code) {
                    [subscriber sendNext:RACTuplePack(@(code == 1))];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _getCodeCommand;
}

- (RACCommand *)loginCommand
{
    if (_loginCommand == nil)
    {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){
                NSDictionary *dic = @{@"phone":KKString(input[0]),
                                      @"password":KKString([input[1] md5])
                                      };
                [SVProgressHUD show];
//                [CPNetTool login:dic success:^(NSDictionary * _Nullable responseObject , NSURLSessionDataTask * _Nonnull task){
//                    CPLog(@"%@",responseObject)
//                    [CPUserDefaultTool setLoginPhone:CPString(input[0])];
//                    CPUserModel *user = [CPUserModel mj_objectWithKeyValues:responseObject[@"data"]];
//                    [CPAppSingle shareManager].userModel = user;
//                    [CPUserDefaultTool setUserInfo:[user mj_keyValues]];
//                    [subscriber sendNext:RACTuplePack(@(YES))];
//                    [subscriber sendCompleted];
//                } fail:^(NSString * _Nullable message, NSString *code , NSURLSessionDataTask * _Nonnull task){
//                    [SVProgressHUD showErrorHUD:message completeBlock:nil];
//                    [subscriber sendNext:RACTuplePack(@(NO))];
//                    [subscriber sendCompleted];
//                }];
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

- (RACCommand *)registerCommand
{
    if (_registerCommand == nil)
    {
        _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){
                NSDictionary *dic = @{@"phone":KKString(input[0]),
                                      @"code":KKString(input[1]),
                                      @"password":KKString([input[2] md5]),
                                      @"channel_name" : @"" ,
                                      @"type":KKString(input[3])};
                [SVProgressHUD show];
                [[KKNetWorking getShard] request:POST url:Register parameters:dic completion:^(BOOL isSuccess, id json, NSInteger code) {
                    [subscriber sendNext:RACTuplePack(@(code == 1))];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _registerCommand;
}
@end
