//
//  HZBAnimationImageView.m
//  Animation
//
//  Created by 安宁 on 2017/8/7.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "UIAnimationImageView.h"

@interface UIAnimationImageView () <CAAnimationDelegate>

@property ( nonatomic , retain ) NSArray <NSString *> * imageNameArray ;
@property ( nonatomic , assign ) NSInteger currentShowImageIndex ;
@property ( nonatomic , retain ) NSTimer * timer ;


@end

@implementation UIAnimationImageView


-(NSInteger)getCurrentShowImageIndex
{
    return _currentShowImageIndex ;
}

-(void)downImage
{

    self.image = [UIImage imageNamed:_imageNameArray[_currentShowImageIndex]];
    
}

-(void)configTimer
{
    if (_timer)
    {
        [_timer invalidate] ;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addAnimation1) userInfo:nil repeats:YES];
}

-(void)addAnimation1
{
    _currentShowImageIndex ++ ;
    if (_currentShowImageIndex >= _imageNameArray.count)
    {
        _currentShowImageIndex = 0 ;
    }
    
    [self downImage];
    
    
//    self.backgroundColor = [UIColor colorWithRed:(arc4random() % 100)/100.0f green:(arc4random()%100)/100.0f blue:(arc4random()%100)/100.0f alpha:1];
    [self.layer removeAllAnimations];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
    transition.removedOnCompletion = YES ;

    transition.subtype = kCATransitionFromRight;//{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    
    transition.delegate = self;
    [self.layer addAnimation:transition forKey:nil];
    
    //    [_subView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
}

-(void)setImageNameArray:(NSArray<NSString *> *)imageNameArray
{
    _currentShowImageIndex = 0 ;
    _imageNameArray = imageNameArray ;

    [self downImage];
    
    [self configTimer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}


@end
