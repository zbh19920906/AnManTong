//
//  NSObject+Permissions.m
//  JIaYou
//
//  Created by lk05 on 2017/6/2.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "NSObject+Permissions.h"

@implementation NSObject (Permissions)

//定位权限
+ (BOOL)isLocation
{
    BOOL isOpen;
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusRestricted||authStatus==kCLAuthorizationStatusDenied) {
        isOpen = NO;
    }else{
        isOpen = YES;
    }
    return isOpen;
}

//相机权限
+ (BOOL)isVideo
{
    BOOL isOpen;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined || authStatus == AVAuthorizationStatusAuthorized) {
        isOpen = YES;
    }else{
        isOpen = NO;
    }
    return isOpen;
}

//版本适配
+ (void)versionsJudge:(NSString *)locationKey
{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationLaunchOptionsLocationKey:locationKey} completionHandler:nil];
    } else if(iOS8_3Later){
        if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }else{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication] canOpenURL:url]){
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

//网络状态
+ (NSString *)networkStatus
{
    UIApplication *app = [UIApplication sharedApplication];
    id statusBar = [app valueForKeyPath:@"statusBar"];
    NSString *network = @"";
    
    if (IS_IPHONE_X) {
        id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
        UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
        
        NSArray *subviews = [[foregroundView subviews][2] subviews];
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                network = @"WIFI";
            }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                network = [subview valueForKeyPath:@"originalText"];
            }
        }
    }else {
        //非 iPhone X
        UIView *foregroundView = [statusBar valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [foregroundView subviews];
        
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
                switch (networkType) {
                    case 0:
                        network = @"NO";
                        break;
                    case 1:
                        network = @"2G";
                        break;
                    case 2:
                        network = @"3G";
                        break;
                    case 3:
                        network = @"4G";
                        break;
                    case 5:
                        network = @"WIFI";
                        break;
                    default:
                        network = @"NO";
                        break;
                }
            }
        }
    }
    if ([network isEqualToString:@""]) {
        network = @"NO";
    }
    return network;
}

@end
