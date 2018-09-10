
//  CPAMapLocationManager.m
//  yuexia
//
//  Created by 陈平 on 2017/12/13.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "CPAMapLocationManager.h"

NSString * kCPLocationLoading = @"正在定位";
NSString * kCPLocationFailure = @"定位失败";

@interface CPAMapLocationManager ()<
AMapLocationManagerDelegate,
AMapSearchDelegate>

/**
 搜索类
 */
@property (nonatomic , strong) AMapSearchAPI *search;

/**
 逆地理编码代码块
 */
@property (nonatomic , copy) ReGeocodeBlock reGeocodeBlock;

/**
 POI搜索代码块
 */
@property (nonatomic , copy) SearchPOIBlock searchPOIBlock;

@property (nonatomic , assign , readwrite) CLLocationCoordinate2D currentCoordinate;

@property (nonatomic , assign) BOOL showAlertView;

@end

@implementation CPAMapLocationManager

#pragma mark - set


#pragma mark - 生命周期
static CPAMapLocationManager *instance = nil;

+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil)
        {
            instance = [[CPAMapLocationManager alloc] init];
        }
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil)
        {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        self.search.timeout = 2;
        self.delegate = self;
        instance.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        instance.locationTimeout = 2;
        instance.reGeocodeTimeout = 2;
        instance.locatingWithReGeocode = YES;
        instance.delegate = self;
        [self showAuthorizationSatusRequestAlert];
        self.appointmentAddress = self.appointmentCity = self.province = self.city = self.street = self.district = self.POIName = self.AOIName = kCPLocationLoading;
    }
    return self;
}

#pragma mark - Private Method
//显示开启定位权限
- (void)showAuthorizationSatusRequestAlert
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined ||
        status == kCLAuthorizationStatusRestricted ||
        status == kCLAuthorizationStatusDenied)
    {
        [self updataIsCanLocationAuthorization:NO];
        [self updataIsLocationStatus:NO];
    }
    else
    {
        [self updataIsCanLocationAuthorization:YES];
    }
}

- (void)openSystemAuthorization
{
    [NSObject versionsJudge:UIApplicationOpenSettingsURLString];
}

- (void)updataIsLocationStatus:(BOOL)status
{
    if (self.isLocationStatus != status)
    {
        self.isLocationStatus = status;
    }
}

- (void)updataIsCanLocationAuthorization:(BOOL)status
{
    if (self.isCanLocationAuthorization != status)
    {
        self.isCanLocationAuthorization = status;
    }
}

- (void)updataIsReGeocodeStatus:(BOOL)status
{
    if (self.isReGeocodeStatus != status)
    {
        self.isReGeocodeStatus = status;
    }
}

#pragma mark - Public Method
- (void)startUpdatingLocationManager
{
    [self startUpdatingLocation];
}

- (void)reGeocodeForLocationManager:(CLLocationCoordinate2D)coordinate reGeocodeComplete:(ReGeocodeBlock)complete
{
    self.reGeocodeBlock = complete;
    self.centerAnnotationCoordinate = coordinate;
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeoRequest.radius = 100;
    regeoRequest.requireExtension = YES;
    //发起逆地理编码
    [self.search AMapReGoecodeSearch: regeoRequest];
}

- (void)searchPOIForSearchStr:(NSString *)searchStr city:(NSString *)city searchComplete:(SearchPOIBlock)complete
{
    self.searchPOIBlock = complete;
    AMapPOIKeywordsSearchRequest *tips = [[AMapPOIKeywordsSearchRequest alloc] init];
    tips.keywords  = searchStr;
    tips.city      = city;
    tips.cityLimit = YES;
    [self.search AMapPOIKeywordsSearch:tips];
}

- (void)searchPOIAroundForCoordinate:(CLLocationCoordinate2D)coordinate searchComplete:(SearchPOIBlock)complete
{
    self.searchPOIBlock = complete;
    AMapPOIAroundSearchRequest *tips = [[AMapPOIAroundSearchRequest alloc] init];
    tips.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self.search AMapPOIAroundSearch:tips];
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    self.lon = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
    self.lat = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
    if (reGeocode)
    {
        if (reGeocode.city == nil)
        {
            reGeocode.city = @"";
        }
        
        if (reGeocode.province == nil)
        {
            reGeocode.province = @"";
        }
        
        if (reGeocode.street == nil)
        {
            reGeocode.street = @"";
        }
        
        if (reGeocode.district == nil)
        {
            reGeocode.district = @"";
        }
        
        if (reGeocode.AOIName == nil)
        {
            reGeocode.AOIName = @"";
        }
        
        if (reGeocode.POIName == nil)
        {
            reGeocode.POIName = @"";
        }
        
        self.province = reGeocode.province;
        self.city = reGeocode.city;
        self.street = reGeocode.street;
        self.district = reGeocode.district;
        self.POIName = reGeocode.POIName;
        self.AOIName = reGeocode.AOIName;
        self.currentCoordinate = location.coordinate;
        
        //判断当前约会坐标是否可用
        if ((int)self.appointmentCoordinate.longitude == 0 &&
            (int)self.appointmentCoordinate.latitude == 0)
        {
            self.centerAnnotationCoordinate = location.coordinate;
            self.appointmentCoordinate  = location.coordinate;
            self.appointmentCity        = reGeocode.city;
            self.appointmentAddress     = reGeocode.formattedAddress;
        }
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
//            [CPUserDefaultTool setUserCurrentCoordinateForLat:self.lat lon:self.lon];
//            [self.subLocationCommand execute:nil];
        });
        
        [self updataIsLocationStatus:YES];
    }
    [self.locationReplaySubject sendNext:@(YES)];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    self.province = self.city = self.street = self.district = self.POIName = self.AOIName = kCPLocationFailure;
    [self updataIsLocationStatus:NO];
    [self.locationReplaySubject sendNext:@(NO)];
    [self showAuthorizationSatusRequestAlert];
}

#pragma mark - AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    //逆地理成功
    if(response.regeocode != nil)
    {
        [self updataIsReGeocodeStatus:YES];
        
        //判断当前约会坐标是否可用
        if ((int)self.appointmentCoordinate.longitude == 0 &&
            (int)self.appointmentCoordinate.latitude == 0)
        {
            self.appointmentCoordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
            self.appointmentCity = response.regeocode.addressComponent.city;
            self.appointmentAddress = response.regeocode.formattedAddress;
        }
        
        if (self.reGeocodeBlock) self.reGeocodeBlock(response.regeocode);
    }
    //逆地理失败
    else
    {
        [CPAMapLocationManager shareManager].appointmentAddress     = kCPLocationFailure;
        [CPAMapLocationManager shareManager].appointmentCity        = kCPLocationFailure;
        [CPAMapLocationManager shareManager].appointmentCoordinate  = CLLocationCoordinate2DMake(0, 0);
        
        [self updataIsReGeocodeStatus:NO];
        
        if (self.reGeocodeBlock) self.reGeocodeBlock([AMapReGeocode new]);
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (self.searchPOIBlock) self.searchPOIBlock(response);
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    [self updataIsReGeocodeStatus:NO];
    
    if (self.reGeocodeBlock) self.reGeocodeBlock([AMapReGeocode new]);
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [self showAuthorizationSatusRequestAlert];
}

#pragma mark - get
- (RACReplaySubject *)locationReplaySubject{
    if (_locationReplaySubject == nil)
    {
        _locationReplaySubject = [RACReplaySubject subject];
    }
    return _locationReplaySubject;
}

- (RACCommand *)subLocationCommand
{
    if (_subLocationCommand == nil)
    {
        _subLocationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
//            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){
//                NSDictionary *dic = @{@"lat":CPString([CPAMapLocationManager shareManager].lat),
//                                      @"lon":CPString([CPAMapLocationManager shareManager].lon),
//                                      @"city":CPString([CPAMapLocationManager shareManager].city),
//                                      };
//                [CPNetTool subLocation:dic success:^(NSDictionary * _Nullable responseObject , NSURLSessionDataTask * _Nonnull task){
//                    [subscriber sendNext:nil];
//                    [subscriber sendCompleted];
//                } fail:^(NSString * _Nullable message, NSString *code , NSURLSessionDataTask * _Nonnull task){
//                    [subscriber sendCompleted];
//                }];
                return nil;
//            }];
        }];
    }
    return _subLocationCommand;
}

@end

