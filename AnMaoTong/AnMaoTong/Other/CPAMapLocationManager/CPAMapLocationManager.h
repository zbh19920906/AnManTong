//
//  CPAMapLocationManager.h
//  yuexia
//
//  Created by 陈平 on 2017/12/13.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"

typedef void(^ReGeocodeBlock)(AMapReGeocode * reGeocode);
typedef void(^SearchPOIBlock)(AMapPOISearchResponse * response);

@interface CPAMapLocationManager : AMapLocationManager

/**
 定位大头症坐标(使用这个)
 */
@property (nonatomic , assign) CLLocationCoordinate2D centerAnnotationCoordinate;

/**
 当前约会的位置(使用这个)
 */
@property (nonatomic , assign) CLLocationCoordinate2D appointmentCoordinate;

/**
 当前约会位置名(使用这个)
 */
@property (nonatomic , copy) NSString *appointmentAddress;

/**
 当前约会城市(使用这个)
 */
@property (nonatomic , copy) NSString *appointmentCity;

/**
 用户位置维度(使用这个)
 */
@property (nonatomic , copy) NSString *lon;

/**
 用户位置经度(使用这个)
 */
@property (nonatomic , copy) NSString *lat;

/**
 用户位置城市(使用这个)
 */
@property (nonatomic , copy) NSString *city;

/**
 用户位置省(使用这个)
 */
@property (nonatomic , copy) NSString *province;

/**
 用户位置区(使用这个)
 */
@property (nonatomic, copy) NSString *district;

/**
 用户位置街道(使用这个)
 */
@property (nonatomic, copy) NSString *street;

/**
 用户位置兴趣点名称(使用这个)
 */
@property (nonatomic, copy) NSString *POIName;

/**
 用户位置所属兴趣点名称(使用这个)
 */
@property (nonatomic, copy) NSString *AOIName;

/**
 当前自身定位坐标
 */
@property (nonatomic , assign , readonly) CLLocationCoordinate2D currentCoordinate;

/**
 定位是否授权 (授权、未授权)
 */
@property (nonatomic , assign) BOOL isCanLocationAuthorization;

/**
 用户自身定位状态(成功、失败)
 */
@property (nonatomic , assign) BOOL isLocationStatus;

/**
 逆地理状态(成功、失败)
 */
@property (nonatomic , assign) BOOL isReGeocodeStatus;

/**
 定位信号
 */
@property (nonatomic , strong) RACReplaySubject *locationReplaySubject;

/**
 提交实时位置
 */
@property (nonatomic , strong) RACCommand *subLocationCommand;

/**
 初始化
 */
+(instancetype)shareManager;

/**
 开启定位
 */
- (void)startUpdatingLocationManager;

/**
 逆地理编码
 */
- (void)reGeocodeForLocationManager:(CLLocationCoordinate2D)coordinate reGeocodeComplete:(ReGeocodeBlock)complete;

/**
 POI搜索
 */
- (void)searchPOIForSearchStr:(NSString *)searchStr city:(NSString *)city searchComplete:(SearchPOIBlock)complete;

/**
 POI搜索周边、根据经纬度
 */
- (void)searchPOIAroundForCoordinate:(CLLocationCoordinate2D)coordinate searchComplete:(SearchPOIBlock)complete;

/**
 显示权限提示框
 */
- (void)showAuthorizationSatusRequestAlert;

/**
 开启系统授权
 */
- (void)openSystemAuthorization;
@end
