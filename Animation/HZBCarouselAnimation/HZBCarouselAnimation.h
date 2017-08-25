//
//  HZBCarouselAnimation.h
//  Animation
//
//  Created by 安宁 on 2017/8/22.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZBCarouselAnimation : UIView

#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame ;

#pragma mark 设置图片数据
-(void)setImageArray:(NSMutableArray *)imageArray ;

#pragma mark 点击图片后的回调 
@property ( nonatomic , copy ) void(^tapImageView)(NSInteger index) ;

@end
