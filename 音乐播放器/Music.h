
//
//  Created by Vincent_Guo on 15-2-21.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject
/**
 * 歌曲名字
 */
@property(nonatomic,copy)NSString *name;
/**
 * 本地音乐文件名
 */
@property(nonatomic,copy)NSString *filename;

/**
 * 歌手名字
 */
@property(nonatomic,copy)NSString *singer;

/**
 * 歌手相片
 */
@property(nonatomic,copy)NSString *singerIcon;

/**
 * 专辑图片
 */
@property(nonatomic,copy)NSString *icon;
@end
