//
//  YouMiPointsManager.h
//  YouMiSDK
//
//  Created by ENZO YANG on 13-4-25.
//  Copyright (c) 2013年 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// Notify more points recived from YouMi server.
// 通知从有米服务器获得了积分
// notification userInfo example:
// @{ kYouMiPointsManagerFreshPointsKey: @123 }
extern NSString *const kYouMiPointsManagerRecivedPointsNotification;

// 使用下面这个 key 从 Notification userInfo 中获得积分
// 【重要】通知里的积分只是用于通知用户新增了多少积分
// 不要消耗通知了的积分，请使用[YouMiPointsManager spendPoints:]来消耗积分
// Use this key to get fresh points in Notification userInfo.
// [IMPORTANT] fresh points just for notify user, don't add it up to points manager created by yourself! Use [YouMiPointsManager spendPoints:] instead.
extern NSString *const kYouMiPointsManagerFreshPointsKey;

@interface YouMiPointsManager : NSObject

// 开启积分管理, 【重要】如果开启，其余获取积分方式将会无法获得积分。如果不开启，下面各个方法无效
// enable PointsManager, [IMPORTANT] Other method won't recieve points if enable. Methods bellow won't won't work if not enabled.
+ (void)enable;

// 使用积分, 积分不足时返回NO
// return NO if points are not enough
+ (BOOL)spendPoints:(NSUInteger)points;

// 奖励积分, 不会发送 Notification, 如果整型越界则返回NO
// return NO if integer out of bounds
// won't send Notification
+ (BOOL)rewardPoints:(NSUInteger)points;

// 剩余积分
// points remained
+ (NSUInteger)pointsRemained;

@end
