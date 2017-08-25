//
//  HZBCarouselAnimation.m
//  Animation
//
//  Created by 安宁 on 2017/8/22.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBCarouselAnimation.h"

@interface HZBCarouselAnimation ()

@property ( nonatomic , retain ) NSMutableArray < UIImageView * > * imageViewArray ;
@property ( nonatomic , retain ) NSMutableArray * imageArray ;
@property ( nonatomic , assign ) NSUInteger currentIndex ;

@property ( nonatomic , retain ) NSTimer * animationTimer ;

@end

@implementation HZBCarouselAnimation

#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.clipsToBounds = YES ;
        
        _imageViewArray = [NSMutableArray arrayWithCapacity:3];
        CGFloat width = CGRectGetWidth(frame) ;
        CGFloat height = CGRectGetHeight(frame) ;
        for (int i = 0 ; i < 3; i++)
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-width + width*i, 0, width, height)];
            imageView.tag = i + 1 ;
            imageView.clipsToBounds = YES ;
            
            imageView.userInteractionEnabled = YES ;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)]];
            
            [imageView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panImage:)]];
            
            [_imageViewArray addObject:imageView];
            
            [self addSubview:imageView];
            
        }
    }
    
    return self ;
}

#pragma mark 启动定时器
-(void)startAnimationTimer
{
    [self invalidateAnimationTimer];
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAnimation) userInfo:nil repeats:YES];
}

#pragma mark 注销定时器
-(void)invalidateAnimationTimer
{
    if (_animationTimer)
    {
        [_animationTimer invalidate];
        _animationTimer = nil ;
    }

}


#pragma mark 定时动画  往左移动
-(void)timerAnimation
{
    
    UIImageView * midImageView = _imageViewArray[1];
    UIImageView * rightImageView = _imageViewArray[2];
    UIImageView * leftImageView = _imageViewArray[0];

    CGRect midFrame = midImageView.frame ;
    CGRect rightFrame = rightImageView.frame ;
    CGRect leftFrame = leftImageView.frame ;
    CGFloat widht = CGRectGetWidth(midFrame);
    midFrame.origin.x = -widht ;
    rightFrame.origin.x = 0 ;
    leftFrame.origin.x = widht ;

    __block typeof(midImageView) weakMIV = midImageView ;
    __block typeof(rightImageView) weakRIV = rightImageView ;
    __block typeof(leftImageView) weakLIV = leftImageView ;
    
    __block typeof(self) weakSelf = self ;
    [UIView animateWithDuration:0.5 animations:^{
        
        weakMIV.frame = midFrame ;
        weakRIV.frame = rightFrame ;

    } completion:^(BOOL finished) {
        
        weakSelf.currentIndex += 1 ;
        if (weakSelf.currentIndex == weakSelf.imageArray.count)
        {
            weakSelf.currentIndex = 0 ;
        }
        
        weakLIV.frame = leftFrame ;
        NSInteger rightIndex = weakSelf.currentIndex + 1 ;
        if (rightIndex == weakSelf.imageArray.count)
        {
            rightIndex = 0 ;
        }
        weakLIV.image = [UIImage imageNamed:weakSelf.imageArray[rightIndex]] ;
        
        NSLog(@" == %ld",weakSelf.currentIndex) ;
        
        weakSelf.imageViewArray = [NSMutableArray arrayWithObjects:weakMIV,weakRIV,weakLIV, nil];
    }];
    

}
#pragma mark 动画  往右移动
-(void)animationFromLeftToRight
{
    
    UIImageView * midImageView = _imageViewArray[1];
    UIImageView * rightImageView = _imageViewArray[2];
    UIImageView * leftImageView = _imageViewArray[0];
    
    CGRect midFrame = midImageView.frame ;
    CGRect rightFrame = rightImageView.frame ;
    CGRect leftFrame = leftImageView.frame ;
    CGFloat widht = CGRectGetWidth(midFrame);
    midFrame.origin.x = widht ;
    rightFrame.origin.x = -widht ;
    leftFrame.origin.x = 0 ;
    
    __block typeof(midImageView) weakMIV = midImageView ;
    __block typeof(rightImageView) weakRIV = rightImageView ;
    __block typeof(leftImageView) weakLIV = leftImageView ;
    
    __block typeof(self) weakSelf = self ;
    [UIView animateWithDuration:0.5 animations:^{
        
        weakMIV.frame = midFrame ;
        weakLIV.frame = leftFrame ;
        
    } completion:^(BOOL finished) {
        
        weakSelf.currentIndex -= 1 ;
        if (weakSelf.currentIndex == -1)
        {
            weakSelf.currentIndex = weakSelf.imageArray.count - 1 ;
        }
        
        weakRIV.frame = rightFrame ;
        NSInteger leftIndex = weakSelf.currentIndex - 1 ;
        if (leftIndex == -1)
        {
            leftIndex = weakSelf.imageArray.count - 1 ;
        }
        weakRIV.image = [UIImage imageNamed:weakSelf.imageArray[leftIndex]] ;
        
        NSLog(@" == %ld",weakSelf.currentIndex) ;
        
        weakSelf.imageViewArray = [NSMutableArray arrayWithObjects:weakRIV,weakLIV,weakMIV, nil];
    }];
    
    
}

#pragma mark 设置图片数据
-(void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray ;
    
    if (imageArray.count == 1 )
    {
        UIImageView * midImageView = _imageViewArray[1];
        midImageView.image = [UIImage imageNamed:imageArray[0]];
        _currentIndex = 0 ;
    }else if (imageArray.count > 1)
    {
        UIImageView * midImageView = _imageViewArray[1];
        midImageView.image = [UIImage imageNamed:imageArray[0]];
        _currentIndex = 0 ;
        
        UIImageView * rightImageView = _imageViewArray[2];
        rightImageView.image = [UIImage imageNamed:imageArray[1]];

        UIImageView * leftImageView = _imageViewArray[0];
        leftImageView.image = [UIImage imageNamed:imageArray[imageArray.count-1]];
        
        
        [self startAnimationTimer];
    }
}

#pragma mark 滑动
-(void)panImage:(UIPanGestureRecognizer *)pan
{
//    NSLog(@" %@",NSStringFromCGPoint([pan translationInView:self]));

    if (_imageArray && _imageArray.count > 1)
    {
        //滑动
        
        UIImageView * midImageView = _imageViewArray[1];
        UIImageView * rightImageView = _imageViewArray[2];
        UIImageView * leftImageView = _imageViewArray[0];

        CGRect midFrame = midImageView.frame ;
        CGRect rightFrame = rightImageView.frame ;
        CGRect leftFrame = leftImageView.frame ;
        CGFloat widht = CGRectGetWidth(midFrame);
        CGFloat offsetx = [pan translationInView:self].x;
        midFrame.origin.x = offsetx ;
        rightFrame.origin.x = widht + offsetx ;
        leftFrame.origin.x = -widht + offsetx ;
        
        midImageView.frame = midFrame ;
        rightImageView.frame = rightFrame ;
        leftImageView.frame = leftFrame ;

        if (pan.state == UIGestureRecognizerStateBegan)
        {
            [self invalidateAnimationTimer];
        }else if (pan.state == UIGestureRecognizerStateEnded)
        {
            if (offsetx <= 0 )
            {
                [self timerAnimation];
            }else
            {
                [self animationFromLeftToRight];
            }
            [self startAnimationTimer];
        }

        
    }
}

#pragma mark 点击某张图
-(void)tapImage:(UIGestureRecognizer *)ges
{
    if (_tapImageView)
    {
        NSInteger index = ges.view.tag-1 ;
        
        NSLog(@"点击图片的下标 %@",@(index)) ;
        _tapImageView(index);
    }
}

@end
