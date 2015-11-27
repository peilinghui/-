//
//  MusicCell.h
//  音乐播放器
//
//  Created by peilinghui on 15/11/23.
//  Copyright © 2015年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Music;
@interface MusicCell : UITableViewCell
+ (instancetype)musicCellWithTableView:(UITableView *)tableView;

@property(strong,nonatomic)Music *music;

@end
