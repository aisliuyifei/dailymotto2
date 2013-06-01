//
//  YouMiFeaturedAppModel.h
//  YouMiSDK
//
//  Created by Layne on 12-01-05.
//  Copyright (c) 2012年 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouMiWallAppModel : NSObject <NSCoding, NSCopying> {
 @private
    id _internal;
}

@property(nonatomic, readonly)    NSString    *storeID;           // 该开放源应用的标示
@property(nonatomic, readonly)    NSString    *identifier;        // 应用的Bundle Identifier
@property(nonatomic, readonly)    NSString    *name;              // 应用名称
@property(nonatomic, readonly)    NSString    *desc;              // 应用描述
@property(nonatomic, readonly)    NSString    *price;             // 应用在App Store的购买价格
@property(nonatomic, readonly)    NSInteger   points;             // 积分值[该值对有积分应用有效，对无积分应用默认为0]
@property(nonatomic, readonly)    NSString    *size;              // 安装包大小
@property(nonatomic, readonly)    NSString    *category;          // 应用的类别
@property(nonatomic, readonly)    NSString    *author;            // 应用版权所有者
@property(nonatomic, readonly)    NSString    *smallIconURL;      // 应用的小图标
@property(nonatomic, readonly)    NSString    *largeIconURL;      // 应用的大图标
@property(nonatomic, readonly)    NSString    *linkURL;           // 应用点击后的链接
@property(nonatomic, readonly)    NSDate      *expiredDate;       // 该开放源的过期时间

@property(nonatomic, readonly)    NSString    *adText;            // 广告词 YouMiSDK 4.8 添加

@end
