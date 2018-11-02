//
//  CLPrivacyManager.h
//  CLPrivacyManagerDemo
//
//  Created by AUG on 2018/11/1.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocationManager;
@class CBCentralManager;
@class HKHealthStore;
@class HMHomeManager;
@class CMMotionActivityManager;
@class EKEventStore;
@class CNContactStore;


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger,PrivacyPermissionType) {
    PrivacyPermissionTypePhoto = 0,///<相册
    PrivacyPermissionTypeCamera,///<相机
    PrivacyPermissionTypeMedia,///<媒体资料库
    PrivacyPermissionTypeMicrophone,///<麦克风
    PrivacyPermissionTypeLocationAlways,///<后台定位
    PrivacyPermissionTypeLocationWhenInUse,///<前台定位
    PrivacyPermissionTypeBluetooth,///<蓝牙
    PrivacyPermissionTypePushNotification,///<推送
    PrivacyPermissionTypeSpeech,///<语音识别
    PrivacyPermissionTypeEvent,///<日历
    PrivacyPermissionTypeContact,///<通讯录
    PrivacyPermissionTypeReminder,///<提醒事项
};

typedef NS_ENUM(NSUInteger,PrivacyPermissionAuthorizationStatus) {
    PrivacyPermissionAuthorizationStatusAuthorized = 0,///<授权
    PrivacyPermissionAuthorizationStatusDenied,///<拒绝
    PrivacyPermissionAuthorizationStatusNotDetermined,///<没有进行选择
    PrivacyPermissionAuthorizationStatusRestricted,///<权限受限
    PrivacyPermissionAuthorizationStatusLocationAlways,///<后台定位
    PrivacyPermissionAuthorizationStatusLocationWhenInUse,///前台定位
    PrivacyPermissionAuthorizationStatusUnkonwn,///未知
};


@interface CLPrivacyManager : NSObject

@property (nonatomic, strong) CLLocationManager         *locationManager;       // 定位
@property (nonatomic, strong) CBCentralManager          *centralManager;        // 蓝牙
@property (nonatomic, strong) EKEventStore              *reminderEventStore;    // 提醒事项
@property (nonatomic, strong) EKEventStore              *eventStore;            // 日历
@property (nonatomic, strong) CNContactStore            *contactStore;          // 通讯录

+(instancetype)sharedManager;


- (void)accessPrivacyPermissionWithType:(PrivacyPermissionType)type completion:(void(^)(BOOL response,PrivacyPermissionAuthorizationStatus status))completion;


@end

NS_ASSUME_NONNULL_END
