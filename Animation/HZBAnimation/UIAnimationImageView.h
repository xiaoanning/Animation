//
//  HZBAnimationImageView.h
//  Animation
//
//  Created by 安宁 on 2017/8/7.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAnimationImageView : UIImageView

-(void)setImageNameArray:(NSArray<NSString *> *)imageNameArray ;

-(NSInteger)getCurrentShowImageIndex;

@end
