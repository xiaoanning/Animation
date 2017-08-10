//
//  HZBSingleModel.h
//  Animation
//
//  Created by 安宁 on 2017/6/23.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 For 'HZBAnimationOrientationHorizontal', 'HZBAnimationDirectionForward' is right-to-left, like pages in a book.
 For 'HZBAnimationOrientationVertical', bottom-to-top, like pages in a wall calendar.
 
 */
typedef NS_ENUM(NSInteger, HZBAnimationOrientation)
{
    HZBAnimationOrientationHorizontal = 0, 
    HZBAnimationOrientationVertical = 1
};

typedef NS_ENUM(NSInteger, HZBAnimationDirection)
{
    HZBAnimationDirectionForward = 0 ,
    HZBAnimationDirectionReverse = 1
};

@interface HZBSingleModel : NSObject

@property ( nonatomic , assign ) NSInteger index ;  //该条数据的序列
@property ( nonatomic , copy ) NSString * text ;    //该条数据显示的文本

@property ( nonatomic , assign ) CGFloat contentWidth ; //跑马屏的宽度
@property ( nonatomic , assign ) CGFloat contentHeight ; //跑马屏的高度


@property ( nonatomic , assign ) HZBAnimationOrientation animationOrientation ;  //动画的方向

-(instancetype)initWithDataDic:(NSDictionary *)dic ;

@end
