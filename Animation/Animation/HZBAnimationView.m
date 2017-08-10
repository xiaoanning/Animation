//
//  HZBAnimationView.m
//  Animation
//
//  Created by 安宁 on 2017/6/23.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBAnimationView.h"

typedef NS_ENUM(NSInteger , KKViewControllerIndex)
{
    KKViewControllerIndexBefore = 1 ,
    KKViewControllerIndexAfter = 2 ,

};

@interface HZBAnimationView () <UIPageViewControllerDelegate , UIPageViewControllerDataSource>

@property ( nonatomic , assign ) HZBAnimationOrientation orientation ;
@property ( nonatomic , assign ) HZBAnimationDirection direction ;

@property ( nonatomic , assign ) BOOL animationCirculation ;

@property ( nonatomic , assign ) BOOL canDrag ;

@property ( nonatomic , retain ) UIPageViewController * pageViewController ;

@property ( nonatomic , retain ) NSTimer * timer ;

@end

@implementation HZBAnimationView

-(instancetype)initWithFrame:(CGRect)frame orientation:(HZBAnimationOrientation) orientation direction:(HZBAnimationDirection) direction animationCirculation:(BOOL) animationCirculation canDrag:(BOOL)canDrag
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _orientation = orientation ;
        _direction = direction ;
        _animationCirculation = animationCirculation ;
        _canDrag = canDrag ;
        
        [self createUI];
    }
    
    return self ;
}

-(void)createUI
{
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:[@(_orientation) integerValue] options:nil];
    _pageViewController.delegate = self ;
    _pageViewController.dataSource = self ;
    
    _pageViewController.view.frame = self.bounds ;
    
    _pageViewController.view.userInteractionEnabled = _canDrag ;
    
    [self addSubview:_pageViewController.view];

}

-(void)setDataArray:(NSMutableArray<HZBSingleModel *> *)dataArray
{
    _dataArray = dataArray ;
    
    if (_pageViewController.viewControllers.count == 0 )
    {
        HZBSingleViewController * vc = [self getSingleViewController:KKViewControllerIndexAfter];
        
        [_pageViewController setViewControllers:@[vc] direction:[@(_direction) integerValue] animated:YES completion:^(BOOL finished) {
            
        }];
        
        
        [self createTimer];

    }
}

-(void)createTimer
{
    __block typeof(self) weakSelf = self ;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        
        HZBSingleViewController * nextVC = [weakSelf getSingleViewController:KKViewControllerIndexAfter];
        
        if (nextVC)
        {
            [UIView animateWithDuration:3 animations:^{

                [weakSelf.pageViewController setViewControllers:weakSelf.pageViewController.viewControllers direction:[@(weakSelf.direction) integerValue] animated:YES completion:^(BOOL finished) {
                    
                }];

                [weakSelf.pageViewController setViewControllers:@[nextVC] direction:[@(weakSelf.direction) integerValue] animated:YES completion:^(BOOL finished) {
                    
                }];
            }];

        }else
        {
            timer.fireDate = [NSDate distantFuture];
        }

        
    }];
}

-(HZBSingleViewController *)getSingleViewController:(KKViewControllerIndex)direction
{
    HZBSingleViewController * nextVC = [[HZBSingleViewController alloc]init];
    
    __block typeof(self) weakSelf = self ;
    [nextVC setAnimationStratCallback:^(BOOL start){
        
        if (start)
        {
            [weakSelf createTimer];
        }else
        {
            [weakSelf.timer setFireDate:[NSDate distantFuture]] ;
        }
        
    }];
    NSInteger index = 0 ;
    
    
    if (_pageViewController.viewControllers.count != 0)
    {
        HZBSingleViewController * currentVC = _pageViewController.viewControllers[0];
        
        if (direction == KKViewControllerIndexBefore)
        {
            if (currentVC.singleModel.index == 0 )
            {
                if (_animationCirculation)
                {
                    index = _dataArray.count - 1 ;
                }else
                {
                    return nil ;
                }
                
            }else
            {
                index = currentVC.singleModel.index - 1 ;
            }
            
        }else if (direction == KKViewControllerIndexAfter)
        {
            if (currentVC.singleModel.index == _dataArray.count - 1 )
            {
                if (_animationCirculation)
                {
                    index = 0 ;
                }else
                {
                    return nil ;
                }
                
                
            }else
            {
                index = currentVC.singleModel.index + 1 ;
            }
            
        }

    }
    
    
    [nextVC setSingleModel:_dataArray[index]];
    [nextVC.singleModel setIndex:index];
    
    return nextVC ;

}


- ( UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    HZBSingleViewController * beforeVC = [self getSingleViewController:KKViewControllerIndexBefore];
    
    return beforeVC ;
    
    
}
- ( UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    HZBSingleViewController * afterVC = [self getSingleViewController:KKViewControllerIndexAfter];
    
    return afterVC ;
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    NSLog(@"willTransitionToViewControllers");
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"didFinishAnimating");
    
}



@end
