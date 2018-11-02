//
//  CLPrivacyManager.m
//  CLPrivacyManagerDemo
//
//  Created by AUG on 2018/11/1.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLPrivacyManager.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <HealthKit/HealthKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>


//第1步: 存储唯一实例
static CLPrivacyManager *_manager = nil;

@interface CLPrivacyManager ()

@end


@implementation CLPrivacyManager

//第2步: 分配内存空间时都会调用这个方法. 保证分配内存alloc时都相同.
+(id)allocWithZone:(struct _NSZone *)zone {
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}
//第3步: 保证init初始化时都相同
+(instancetype)sharedManager {
    return [[self alloc] init];
}

-(id)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super init];
    });
    return _manager;
}

//第4步: 保证copy时都相同
-(id)copyWithZone:(NSZone *)zone{
    return _manager;
}

//第五步: 保证mutableCopy时相同
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _manager;
}

- (void)accessPrivacyPermissionWithType:(PrivacyPermissionType)type completion:(void(^)(BOOL response,PrivacyPermissionAuthorizationStatus status))completion API_AVAILABLE(ios(10.0)){
    switch (type) {
        case PrivacyPermissionTypePhoto: {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusDenied) {
                    completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                } else if (status == PHAuthorizationStatusNotDetermined) {
                    completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == PHAuthorizationStatusRestricted) {
                    completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                } else if (status == PHAuthorizationStatusAuthorized) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                }
            }];
        }break;
            
        case PrivacyPermissionTypeCamera: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == AVAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == AVAuthorizationStatusRestricted) {
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
            
        case PrivacyPermissionTypeMedia: {
            [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                if (status == MPMediaLibraryAuthorizationStatusDenied) {
                    completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                } else if (status == MPMediaLibraryAuthorizationStatusNotDetermined) {
                    completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == MPMediaLibraryAuthorizationStatusRestricted) {
                    completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                } else if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                }
            }];
        }break;
            
        case PrivacyPermissionTypeMicrophone: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == AVAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == AVAuthorizationStatusRestricted) {
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
            
        case PrivacyPermissionTypeLocationAlways: {
            if ([CLLocationManager locationServicesEnabled]) {
                [self.locationManager requestAlwaysAuthorization];
            }
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusAuthorizedAlways) {
                completion(YES,PrivacyPermissionAuthorizationStatusLocationAlways);
            } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                completion(YES,PrivacyPermissionAuthorizationStatusLocationWhenInUse);
            } else if (status == kCLAuthorizationStatusDenied) {
                completion(NO,PrivacyPermissionAuthorizationStatusDenied);
            } else if (status == kCLAuthorizationStatusNotDetermined) {
                completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
            } else if (status == kCLAuthorizationStatusRestricted) {
                completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
            }
        }break;
            
        case PrivacyPermissionTypeLocationWhenInUse: {
            if ([CLLocationManager locationServicesEnabled]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusAuthorizedAlways) {
                completion(YES,PrivacyPermissionAuthorizationStatusLocationAlways);
            } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                completion(YES,PrivacyPermissionAuthorizationStatusLocationWhenInUse);
            } else if (status == kCLAuthorizationStatusDenied) {
                completion(NO,PrivacyPermissionAuthorizationStatusDenied);
            } else if (status == kCLAuthorizationStatusNotDetermined) {
                completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
            } else if (status == kCLAuthorizationStatusRestricted) {
                completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
            }
        }break;
            
        case PrivacyPermissionTypeBluetooth: {
            CBManagerState state = [self.centralManager state];
            if (state == CBManagerStateUnsupported || state == CBManagerStateUnauthorized || state == CBManagerStateUnknown) {
                completion(NO,PrivacyPermissionAuthorizationStatusDenied);
            } else {
                completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
            }
        }break;
            
        case PrivacyPermissionTypePushNotification: {
            if (@available(iOS 10.0, *)) {
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                UNAuthorizationOptions types = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
                [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                            //
                        }];
                    } else {

                    }
                }];
            } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
            }
#pragma clang diagnostic pop
        }break;
            
        case PrivacyPermissionTypeSpeech: {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
                    completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                } else if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
                    completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
                    completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                } else if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                }
            }];
        }break;
            
        case PrivacyPermissionTypeEvent: {
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == EKAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == EKAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == EKAuthorizationStatusRestricted) {
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
            
        case PrivacyPermissionTypeContact: {
            [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == CNAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    }else if (status == CNAuthorizationStatusRestricted){
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    }else if (status == CNAuthorizationStatusNotDetermined){
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
            
        case PrivacyPermissionTypeReminder: {
            [self.reminderEventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(YES,PrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == EKAuthorizationStatusDenied) {
                        completion(NO,PrivacyPermissionAuthorizationStatusDenied);
                    }else if (status == EKAuthorizationStatusNotDetermined){
                        completion(NO,PrivacyPermissionAuthorizationStatusNotDetermined);
                    }else if (status == EKAuthorizationStatusRestricted){
                        completion(NO,PrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }break;
            
        default:
            break;
    }
}

- (CLLocationManager *) locationManager{
    if (_locationManager == nil){
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (CBCentralManager *) centralManager{
    if (_centralManager == nil){
        _centralManager = [[CBCentralManager alloc] init];
    }
    return _centralManager;
}

- (EKEventStore *) reminderEventStore{
    if (_reminderEventStore == nil){
        _reminderEventStore = [[EKEventStore alloc] init];
    }
    return _reminderEventStore;
}

- (EKEventStore *) eventStore{
    if (_eventStore == nil){
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}

- (CNContactStore *) contactStore{
    if (_contactStore == nil){
        _contactStore = [[CNContactStore alloc] init];
    }
    return _contactStore;
}

@end
