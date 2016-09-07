//
//  MFMapManage.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/7.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFMapManager.h"

@interface MFMapManager ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MFMapManager

- (void)start {
    
    _locationManager          = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
}

/** 定位成功 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [manager stopUpdatingLocation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didUpdateAndGetLastCLLocation:)]) {
        
        CLLocation *location = [locations lastObject];
        [_delegate mapManager:self didUpdateAndGetLastCLLocation:location];
    }
}

/** 定位失败 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    MFLog(@"定位失败");
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
        MFLog(@"定位功能关闭");
        if (_delegate && [_delegate respondsToSelector:@selector(mapManagerServerClosed:)]) {
            [_delegate mapManagerServerClosed:self];
        }
    } else {
        MFLog(@"定位功能开启");
        if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didFailed:)]) {
            MFLog(@"%@", error);
            [_delegate mapManager:self didFailed:error];
        }
    }
}

@synthesize authorizationStatus = _authorizationStatus;

- (CLAuthorizationStatus)authorizationStatus {
    
    return [CLLocationManager authorizationStatus];
}

@end
