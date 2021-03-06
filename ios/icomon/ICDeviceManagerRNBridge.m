//
//  ICDeviceManagerRNBridge.m
//  BleDemo
//
//  Created by Symons on 2021/7/7.
//

#import "ICDeviceManagerRNBridge.h"
#import <ICDeviceManager/ICDeviceManager.h>
#import "MJExtension.h"

//#define CALL_RET_STATE(ret) if (callback) {callback(ret ? @"ok" : @"fail", NO);}
#define CALL_RET_INT(ret) if (callback) {callback(ret);}

#define ToDevice(dict) ICDevice *deviceObj = [ICDevice new]; deviceObj.macAddr = dict[@"macAddr"];


@interface ICDeviceManagerRNBridge () <ICDeviceManagerDelegate, ICScanDeviceDelegate>

@end


@implementation ICDeviceManagerRNBridge

RCT_EXPORT_MODULE(ICDeviceManagerRNBridge);



- (NSArray<NSString *> * )supportedEvents
{
  return @[@"onScanResult", @"onDeviceManagerDelegate"];
}


RCT_EXPORT_METHOD(initMgr)
{
  [ICDeviceManager shared].delegate = self;
  [[ICDeviceManager shared] initMgr];
}

RCT_EXPORT_METHOD(updateUserInfo:(NSDictionary *)userInfoDict)
{
    ICUserInfo *userInfo = [ICUserInfo new];
    if (userInfoDict[@"age"]) {
        userInfo.age = [userInfoDict[@"age"] intValue];
    }
    if (userInfoDict[@"height"]) {
        userInfo.height = [userInfoDict[@"height"] intValue];
    }
    if (userInfoDict[@"sex"]) {
        userInfo.sex = [userInfoDict[@"sex"] intValue];
    }
    if (userInfoDict[@"weight"]) {
        userInfo.weight = [userInfoDict[@"weight"] floatValue];
    }
    if (userInfoDict[@"bfaType"]) {
        userInfo.bfaType = [userInfoDict[@"bfaType"] intValue];
    }
    if (userInfoDict[@"weightUnit"]) {
        userInfo.weightUnit = [userInfoDict[@"weightUnit"] intValue];
    }
    if (userInfoDict[@"rulerUnit"]) {
        userInfo.rulerUnit = [userInfoDict[@"rulerUnit"] intValue];
    }
    if (userInfoDict[@"peopleType"]) {
        userInfo.peopleType = [userInfoDict[@"peopleType"] intValue];
    }
    if (userInfoDict[@"rulerMode"]) {
        userInfo.rulerMode = [userInfoDict[@"rulerMode"] intValue];
    }
    if (userInfoDict[@"targetWeight"]) {
        userInfo.targetWeight = [userInfoDict[@"targetWeight"] floatValue];
    }
    if (userInfoDict[@"kitchenUnit"]) {
        userInfo.kitchenUnit = [userInfoDict[@"kitchenUnit"] intValue];
    }
    if (userInfoDict[@"userIndex"]) {
        userInfo.userIndex = [userInfoDict[@"userIndex"] intValue];
    }
    if (userInfoDict[@"weightDirection"]) {
        userInfo.weightDirection = [userInfoDict[@"weightDirection"] intValue];
    }
    if (userInfoDict[@"enableMeasureImpendence"]) {
        userInfo.enableMeasureImpendence = [userInfoDict[@"enableMeasureImpendence"] intValue];
    }
    if (userInfoDict[@"enableMeasureBalance"]) {
        userInfo.enableMeasureBalance = [userInfoDict[@"enableMeasureBalance"] intValue];
    }
    if (userInfoDict[@"enableMeasureHr"]) {
        userInfo.enableMeasureHr = [userInfoDict[@"enableMeasureHr"] intValue];
    }
    if (userInfoDict[@"enableMeasureGravity"]) {
        userInfo.enableMeasureGravity = [userInfoDict[@"enableMeasureGravity"] intValue];
    }
    [[ICDeviceManager shared] updateUserInfo:userInfo];
}



RCT_EXPORT_METHOD(setUserList:(NSArray<NSDictionary *> *)userlist)
{
    NSMutableArray<ICUserInfo *> *userInfoList = [NSMutableArray arrayWithCapacity:4];
    if (userlist.count > 0) {
        for (NSDictionary *userInfoDict in userlist) {
            ICUserInfo *userInfo = [ICUserInfo new];
            if (userInfoDict[@"age"]) {
                userInfo.age = [userInfoDict[@"age"] intValue];
            }
            if (userInfoDict[@"height"]) {
                userInfo.height = [userInfoDict[@"height"] intValue];
            }
            if (userInfoDict[@"sex"]) {
                userInfo.sex = [userInfoDict[@"sex"] intValue];
            }
            if (userInfoDict[@"weight"]) {
                userInfo.weight = [userInfoDict[@"weight"] floatValue];
            }
            if (userInfoDict[@"bfaType"]) {
                userInfo.bfaType = [userInfoDict[@"bfaType"] intValue];
            }
            if (userInfoDict[@"weightUnit"]) {
                userInfo.weightUnit = [userInfoDict[@"weightUnit"] intValue];
            }
            if (userInfoDict[@"rulerUnit"]) {
                userInfo.rulerUnit = [userInfoDict[@"rulerUnit"] intValue];
            }
            if (userInfoDict[@"peopleType"]) {
                userInfo.peopleType = [userInfoDict[@"peopleType"] intValue];
            }
            if (userInfoDict[@"rulerMode"]) {
                userInfo.rulerMode = [userInfoDict[@"rulerMode"] intValue];
            }
            if (userInfoDict[@"targetWeight"]) {
                userInfo.targetWeight = [userInfoDict[@"targetWeight"] floatValue];
            }
            if (userInfoDict[@"kitchenUnit"]) {
                userInfo.kitchenUnit = [userInfoDict[@"kitchenUnit"] intValue];
            }
            if (userInfoDict[@"userIndex"]) {
                userInfo.userIndex = [userInfoDict[@"userIndex"] intValue];
            }
            if (userInfoDict[@"weightDirection"]) {
                userInfo.weightDirection = [userInfoDict[@"weightDirection"] intValue];
            }
            if (userInfoDict[@"enableMeasureImpendence"]) {
                userInfo.enableMeasureImpendence = [userInfoDict[@"enableMeasureImpendence"] intValue];
            }
            if (userInfoDict[@"enableMeasureBalance"]) {
                userInfo.enableMeasureBalance = [userInfoDict[@"enableMeasureBalance"] intValue];
            }
            if (userInfoDict[@"enableMeasureHr"]) {
                userInfo.enableMeasureHr = [userInfoDict[@"enableMeasureHr"] intValue];
            }
            if (userInfoDict[@"enableMeasureGravity"]) {
                userInfo.enableMeasureGravity = [userInfoDict[@"enableMeasureGravity"] intValue];
            }
            [userInfoList addObject:userInfo];
        }
        [[ICDeviceManager shared] setUserList:userInfoList];
    }
    else {
    }
}

/**
 ????????????
*/
RCT_EXPORT_METHOD(scanDevice)
{
  [[ICDeviceManager shared] scanDevice:self];
}

/**
 ????????????
 */
RCT_EXPORT_METHOD(stopScan)
{
    [[ICDeviceManager shared] stopScan];
}

/**
 ????????????
 */
RCT_EXPORT_METHOD(addDevice:(NSDictionary *)device callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[ICDeviceManager shared] addDevice:deviceObj callback:^(ICDevice *device, ICAddDeviceCallBackCode code) {
      if (callback) {
        callback(@[ [device mj_keyValues], @(code)]);
      }
    }];
}

/**
 ??????????????????(???:????????????device????????????block???????????????)
 */
RCT_EXPORT_METHOD(addDevices:(NSArray<NSDictionary *> *)devices  callback:(RCTResponseSenderBlock)callback)
{
    NSMutableArray<ICDevice *> *deviceObjs = [NSMutableArray arrayWithCapacity:4];
    for (NSDictionary *dict in devices) {
        ToDevice(dict);
        [deviceObjs addObject:deviceObj];
    }
    [[ICDeviceManager shared] addDevices:deviceObjs callback:^(ICDevice *device, ICAddDeviceCallBackCode code) {
      if (callback) {
        callback(@[ [device mj_keyValues], @(code)]);
      }
    }];
}

/**
 ????????????
 */
RCT_EXPORT_METHOD(removeDevice:(NSDictionary *)device  callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);

    [[ICDeviceManager shared] removeDevice:deviceObj callback:^(ICDevice *device, ICRemoveDeviceCallBackCode code) {
        if (callback) {
          callback(@[ [device mj_keyValues], @(code)]);
        }
    }];
}

/**
 ??????????????????(???:????????????device????????????block???????????????)
 */
RCT_EXPORT_METHOD(removeDevices:(NSArray<NSDictionary *> *)devices  callback:(RCTResponseSenderBlock)callback)
{
    NSMutableArray<ICDevice *> *deviceObjs = [NSMutableArray arrayWithCapacity:4];
    for (NSDictionary *dict in devices) {
        ToDevice(dict);
        [deviceObjs addObject:deviceObj];
    }

    [[ICDeviceManager shared] removeDevices:deviceObjs callback:^(ICDevice *device, ICRemoveDeviceCallBackCode code) {
      if (callback) {
        callback(@[ [device mj_keyValues], @(code)]);
      }
    }];

}

RCT_EXPORT_METHOD(upgradeDevice:(NSDictionary *)device filePath:(NSString *)filePath)
{
    ToDevice(device);

    [[ICDeviceManager shared] upgradeDevice:deviceObj filePath:filePath];
}

RCT_EXPORT_METHOD(stopUpgradeDevice:(NSDictionary *)device)
{
    ToDevice(device);

    [[ICDeviceManager shared] stopUpgradeDevice:deviceObj];
}

RCT_EXPORT_METHOD(upgradeDevices:(NSArray<NSDictionary *> *)devices filePath:(NSString *)filePath)
{
    NSMutableArray<ICDevice *> *deviceObjs = [NSMutableArray arrayWithCapacity:4];
    for (NSDictionary *dict in devices) {
        ToDevice(dict);
        [deviceObjs addObject:deviceObj];
    }
    [[ICDeviceManager shared] upgradeDevices:deviceObjs filePath:filePath];
}

#pragma mark ?????????

/**
 ???????????????
 
 @param device          ??????
 @param unit            ??????
 @param callback        ??????
 */
RCT_EXPORT_METHOD(setScaleUnit:(NSDictionary *)device unit:(ICWeightUnit)unit callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setScaleUnit:deviceObj unit:unit callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
 ??????????????????
 
 @param device      ??????
 @param unit        ??????
 @param callback    ??????
 */
RCT_EXPORT_METHOD(setRulerUnit:(NSDictionary *)device unit:(ICRulerUnit)unit callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setRulerUnit:deviceObj unit:unit callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
 ??????????????????????????????
 
 @param device      ??????
 @param type        ????????????
 @param callback    ??????
 */
RCT_EXPORT_METHOD(setRulerBodyPartsType:(NSDictionary *)device type:(ICRulerBodyPartsType)type callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setRulerBodyPartsType:deviceObj type:type callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
 ?????????????????????????????????:??????

 @param device ??????
 @param weight ???????????????:???????????????????????????65535??????
 @param callback ??????
 */
RCT_EXPORT_METHOD(setWeight:(NSDictionary *)device weight:(NSInteger)weight callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setWeight:deviceObj weight:weight callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
 ???????????????????????????

 @param device ??????
 @param callback ??????
 */
RCT_EXPORT_METHOD(deleteTareWeight:(NSDictionary *)device callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] deleteTareWeight:deviceObj callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
 ???????????????????????????

 @param device ??????
 @param unit ????????????:?????????????????????????????????????????????
 @param callback ??????
 */
RCT_EXPORT_METHOD(setKitchenScaleUnit:(NSDictionary *)device unit:(ICKitchenScaleUnit)unit callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setKitchenScaleUnit:deviceObj unit:unit callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
 ?????????????????????????????????

 @param device ??????
 @param type ????????????
 @param value ?????????
 @param callback ??????
 */
RCT_EXPORT_METHOD(setNutritionFacts:(NSDictionary *)device type:(ICKitchenScaleNutritionFactType)type value:(NSInteger)value callback:(RCTResponseSenderBlock)callback)
{
    
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setNutritionFacts:deviceObj type:type value:value callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
 ????????????????????????
 
 @param device      ??????
 @param mode        ????????????
 @param callback    ??????
 */
RCT_EXPORT_METHOD(setRulerMeasureMode:(NSDictionary *)device mode:(ICRulerMeasureMode)mode callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setRulerMeasureMode:deviceObj mode:mode callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}


/**
 * ????????????
 * @param device ??????
 * @param mode   ????????????
 * @param param  ????????????
 * @param callback ??????
 */
RCT_EXPORT_METHOD(startSkip:(NSDictionary *)device mode:(ICSkipMode)mode param:(NSUInteger)param callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] startSkip:deviceObj mode:mode param:param callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}


/**
 * ????????????
 * @param device ??????
 * @param callback ??????
 */
RCT_EXPORT_METHOD(stopSkip:(NSDictionary *)device callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] stopSkip:deviceObj callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}

/**
?????????????????????

@param device ??????
@param callback ??????
*/
RCT_EXPORT_METHOD(powerOffKitchenScale:(NSDictionary *)device callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] powerOffKitchenScale:deviceObj callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];

}


/**
 ??????????????????

@param device        ??????
@param ssid             WIFI SSID
@param password    WIFI Password
*/
RCT_EXPORT_METHOD(configWifi:(NSDictionary *)device  ssid:(NSString *)ssid password:(NSString *)password callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] configWifi:deviceObj ssid:ssid password:password callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}


/**
 ??????????????????????????????

@param device        ??????
@param server          App???????????????,???:https://www.google.com
*/
RCT_EXPORT_METHOD(setServerUrl:(NSDictionary *)device  server:(NSString *)server callback:(RCTResponseSenderBlock)callback)
{
    ToDevice(device);
    [[[ICDeviceManager shared] getSettingManager] setServerUrl:deviceObj server:server callback:^(ICSettingCallBackCode code) {
      callback(@[ [device mj_keyValues], @(code)]);
    }];
}




/**
 ???????????????????????????????????????????????????updateUserInfo????????????????????????????????????
 ??????:???????????????????????????

@param device      ??????
@param userInfoDict    ????????????
*/
RCT_EXPORT_METHOD(setUserInfoToDevice:(NSDictionary *)device userInfo:(NSDictionary *)userInfoDict)
{
    ToDevice(device);
    ICUserInfo *userInfo = [ICUserInfo new];
    if (userInfoDict[@"age"]) {
        userInfo.age = [userInfoDict[@"age"] intValue];
    }
    if (userInfoDict[@"height"]) {
        userInfo.height = [userInfoDict[@"height"] intValue];
    }
    if (userInfoDict[@"sex"]) {
        userInfo.sex = [userInfoDict[@"sex"] intValue];
    }
    if (userInfoDict[@"weight"]) {
        userInfo.weight = [userInfoDict[@"weight"] floatValue];
    }
    if (userInfoDict[@"bfaType"]) {
        userInfo.bfaType = [userInfoDict[@"bfaType"] intValue];
    }
    if (userInfoDict[@"weightUnit"]) {
        userInfo.weightUnit = [userInfoDict[@"weightUnit"] intValue];
    }
    if (userInfoDict[@"rulerUnit"]) {
        userInfo.rulerUnit = [userInfoDict[@"rulerUnit"] intValue];
    }
    if (userInfoDict[@"peopleType"]) {
        userInfo.peopleType = [userInfoDict[@"peopleType"] intValue];
    }
    if (userInfoDict[@"rulerMode"]) {
        userInfo.rulerMode = [userInfoDict[@"rulerMode"] intValue];
    }
    if (userInfoDict[@"targetWeight"]) {
        userInfo.targetWeight = [userInfoDict[@"targetWeight"] floatValue];
    }
    if (userInfoDict[@"kitchenUnit"]) {
        userInfo.kitchenUnit = [userInfoDict[@"kitchenUnit"] intValue];
    }
    if (userInfoDict[@"userIndex"]) {
        userInfo.userIndex = [userInfoDict[@"userIndex"] intValue];
    }
    if (userInfoDict[@"weightDirection"]) {
        userInfo.weightDirection = [userInfoDict[@"weightDirection"] intValue];
    }
    if (userInfoDict[@"enableMeasureImpendence"]) {
        userInfo.enableMeasureImpendence = [userInfoDict[@"enableMeasureImpendence"] intValue];
    }
    if (userInfoDict[@"enableMeasureBalance"]) {
        userInfo.enableMeasureBalance = [userInfoDict[@"enableMeasureBalance"] intValue];
    }
    if (userInfoDict[@"enableMeasureHr"]) {
        userInfo.enableMeasureHr = [userInfoDict[@"enableMeasureHr"] intValue];
    }
    if (userInfoDict[@"enableMeasureGravity"]) {
        userInfo.enableMeasureGravity = [userInfoDict[@"enableMeasureGravity"] intValue];
    }
    [[[ICDeviceManager shared] getSettingManager] setUserInfo:deviceObj userInfo:userInfo];
}



#pragma mark ????????????
/**
 ??????????????????

 @param deviceInfo ??????????????????
 */
- (void)onScanResult:(ICScanDeviceInfo *)deviceInfo
{
    
    NSDictionary *deviceInfoDict = @{
                   @"name" : deviceInfo.name,
                   @"type" :@(deviceInfo.type),
                   @"subType" : @(deviceInfo.subType),
                   @"communicationType" : @(deviceInfo.communicationType),
                   @"macAddr" : deviceInfo.macAddr,
                   @"services" : deviceInfo.services ? deviceInfo.services : @[],
                   @"rssi" : @(deviceInfo.rssi),
           };
  
  [self sendEventWithName:@"onScanResult" body:@[deviceInfoDict]];
//  if (_scanBlock) {
//    _scanBlock(@[deviceInfoDict]);
//  }
}

#pragma mark ??????SDK??????

- (void)callDelegate:(NSString *)funName datas:(NSArray *)datas
{
  NSMutableArray* ret = [NSMutableArray array];
  [ret addObject:funName];
  [ret addObjectsFromArray:datas];
  [self sendEventWithName:@"onDeviceManagerDelegate" body:ret];
}

/**
 SDKc?????????????????????
 
 @param bSuccess ?????????????????????
 */
- (void)onInitFinish:(BOOL)bSuccess
{
  [self callDelegate:@"onInitFinish" datas:@[@(bSuccess)]];
}


/**
 ????????????????????????
 
 @param state ????????????
 */
- (void)onBleState:(ICBleState)state
{
  [self callDelegate:@"onBleState" datas:@[@(state)]];
}

/**
 ????????????????????????
 
 @param device ??????
 @param state ????????????
 */
- (void)onDeviceConnectionChanged:(ICDevice *)device state:(ICDeviceConnectState)state
{
  [self callDelegate:@"onDeviceConnectionChanged" datas:@[[device mj_keyValues], @(state)]];
}

/**
 ?????????????????????
 
 @param device ??????
 @param data ????????????
 */
- (void)onReceiveWeightData:(ICDevice *)device data:(ICWeightData *)data
{
    if (data.isStabilized && data.weight_g == 0) {
        return;
    }
  [self callDelegate:@"onReceiveWeightData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}


/**
 ?????????????????????
 
 @param device ??????
 @param data ????????????
 */
- (void)onReceiveKitchenScaleData:(ICDevice *)device data:(ICKitchenScaleData *)data
{
  [self callDelegate:@"onReceiveKitchenScaleData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}

/**
 ?????????????????????

 @param device ??????
 @param unit ??????????????????
 */
- (void)onReceiveKitchenScaleUnitChanged:(ICDevice *)device unit:(ICKitchenScaleUnit)unit
{
  [self callDelegate:@"onReceiveKitchenScaleUnitChanged" datas:@[[device mj_keyValues], @(unit)]];
}


/**
 ???????????????????????????
 
 @param device ??????
 @param data ??????????????????
 */
- (void)onReceiveCoordData:(ICDevice *)device data:(ICCoordData *)data
{
  [self callDelegate:@"onReceiveCoordData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}

/**
 ??????????????????
 
 @param device ??????
 @param data ????????????
 */
- (void)onReceiveRulerData:(ICDevice *)device data:(ICRulerData *)data
{
  [self callDelegate:@"onReceiveRulerData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}

/**
 ????????????????????????
 
 @param device ??????
 @param data ????????????
 */
- (void)onReceiveRulerHistoryData:(ICDevice *)device data:(ICRulerData *)data
{
  [self callDelegate:@"onReceiveRulerHistoryData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}

/**
 ??????????????????
 
 @param device ??????
 @param data ????????????
 */
- (void)onReceiveWeightCenterData:(ICDevice *)device data:(ICWeightCenterData *)data
{
  [self callDelegate:@"onReceiveWeightCenterData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}

/**
 ????????????????????????

 @param device  ??????
 @param unit    ??????????????????
 */
- (void)onReceiveWeightUnitChanged:(ICDevice *)device unit:(ICWeightUnit)unit
{
  [self callDelegate:@"onReceiveWeightUnitChanged" datas:@[[device mj_keyValues], @(unit)]];
}


/**
 ????????????????????????
 
 @param device ??????
 @param unit ??????????????????
 */
- (void)onReceiveRulerUnitChanged:(ICDevice *)device unit:(ICRulerUnit)unit
{
  [self callDelegate:@"onReceiveRulerUnitChanged" datas:@[[device mj_keyValues], @(unit)]];
}

/**
 ??????????????????????????????
 
 @param device ??????
 @param mode ????????????????????????
 */
- (void)onReceiveRulerMeasureModeChanged:(ICDevice *)device mode:(ICRulerMeasureMode)mode
{
  [self callDelegate:@"onReceiveRulerUnitChanged" datas:@[[device mj_keyValues], @(mode)]];
}


/**
 4????????????????????????
 
 @param device ??????
 @param data ???????????????
 */
- (void)onReceiveElectrodeData:(ICDevice *)device data:(ICElectrodeData *)data
{
    
}

/**
 ??????????????????????????????????????????????????????
 
 @param device  ??????
 @param step    ?????????????????????
 @param data    ??????
 */
- (void)onReceiveMeasureStepData:(ICDevice *)device step:(ICMeasureStep)step data:(NSObject *)data
{
  [self callDelegate:@"onReceiveMeasureStepData" datas:@[[device mj_keyValues], @(step), [data mj_keyValues]]];
}

/**
 ????????????????????????
 
 @param device ??????
 @param data ??????????????????
 */
- (void)onReceiveWeightHistoryData:(ICDevice *)device data:(ICWeightHistoryData *)data
{
  [self callDelegate:@"onReceiveWeightHistoryData" datas:@[[device mj_keyValues], [data mj_keyValues]]];

}


/**
 ????????????????????????
 
 @param device ??????
 @param data ??????????????????
 */
- (void)onReceiveSkipData:(ICDevice *)device data:(ICSkipData *)data
{
  [self callDelegate:@"onReceiveSkipData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}


/**
 ????????????????????????
 
 @param device ??????
 @param data ??????????????????
 */
- (void)onReceiveHistorySkipData:(ICDevice *)device data:(ICSkipData *)data
{
  [self callDelegate:@"onReceiveHistorySkipData" datas:@[[device mj_keyValues], [data mj_keyValues]]];
}

/**
 ????????????
 
 @param device ??????
 @param battery ???????????????:0~100
 */
- (void)onReceiveSkipBattery:(ICDevice *)device battery:(NSUInteger)battery
{
  [self callDelegate:@"onReceiveSkipBattery" datas:@[[device mj_keyValues], @(battery)]];
}

/**
 ????????????????????????
 @param device ??????
 @param status ????????????
 @param percent ????????????,??????:0~100
 */
- (void)onReceiveUpgradePercent:(ICDevice *)device status:(ICUpgradeStatus)status percent:(NSUInteger)percent
{
  [self callDelegate:@"onReceiveUpgradePercent" datas:@[[device mj_keyValues], @(status), @(percent)]];
}

/**
 ??????????????????

 @param device ??????
 @param deviceInfo ????????????
 */
- (void)onReceiveDeviceInfo:(ICDevice *)device deviceInfo:(ICDeviceInfo *)deviceInfo
{
  [self callDelegate:@"onReceiveDeviceInfo" datas:@[[device mj_keyValues], [deviceInfo mj_keyValues]]];
}


/*
 * ??????????????????
 * @param device ??????
 * @param state ????????????
 */
- (void)onReceiveConfigWifiResult:(ICDevice *)device state:(ICConfigWifiState)state
{
  [self callDelegate:@"onReceiveConfigWifiResult" datas:@[[device mj_keyValues], @(state)]];

}

@end
