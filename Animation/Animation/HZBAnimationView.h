//
//  HZBAnimationView.h
//  Animation
//
//  Created by 安宁 on 2017/6/23.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZBSingleViewController.h"

@interface HZBAnimationView : UIView

-(instancetype)initWithFrame:(CGRect)frame orientation:(HZBAnimationOrientation) orientation direction:(HZBAnimationDirection) direction  animationCirculation:(BOOL) animationCirculation canDrag:(BOOL)canDrag ;

@property ( nonatomic , retain ) NSMutableArray<HZBSingleModel * > * dataArray ;

@end
