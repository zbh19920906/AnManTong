//
//  NSObject+Navication.h
//  JIaYou
//
//  Created by lk05 on 2017/5/26.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface NSObject (Navication)

/**
 跳转导航

 @param coor 经纬度
 @param name 地点名
 */
+ (void)goToNavication:(CLLocationCoordinate2D)coor name:(NSString *)name;
@end
