//
//  ViewController.m
//  CLPrivacyManagerDemo
//
//  Created by AUG on 2018/11/1.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "ViewController.h"
#import "CLPrivacyManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
- (void)initUI {
    _titleArray = @[@"打开相册权限",
                    @"打开相机权限",
                    @"打开媒体资料库权限",
                    @"打开麦克风权限",
                    @"打开前台位置权限",
                    @"打开后台位置权限",
                    @"打开蓝牙权限",
                    @"打开推送权限",
                    @"打开语音识别权限",
                    @"打开日历权限",
                    @"打开通讯录权限",
                    @"打开提醒事项权限",
                    ];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = YES;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textAlignment = 0;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypePhoto completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 1:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeCamera completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 2:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeMedia completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 3:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeMicrophone completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 4:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeLocationWhenInUse completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 5:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeLocationAlways completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 6:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeBluetooth completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 7:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypePushNotification completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 8:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeSpeech completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 9:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeEvent completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 10:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeContact completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        case 11:{
            [[CLPrivacyManager sharedManager] accessPrivacyPermissionWithType:PrivacyPermissionTypeReminder completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
                NSLog(@"response:%d \n status:%ld",response,status);
            }];
        }break;
            
        default:
            break;
    }
}


@end
