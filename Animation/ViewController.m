//
//  ViewController.m
//  Animation
//
//  Created by 安宁 on 2017/6/23.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "ViewController.h"
#import "HZBAnimationView.h"
#import "UIAnimationImageView.h"

@interface ViewController ()

@property ( nonatomic , retain ) NSMutableArray * dataArray ;

@property ( nonatomic , assign ) CGFloat contentWidth ;
@property ( nonatomic , assign ) CGFloat contentHeight ;


@property ( nonatomic , assign ) HZBAnimationOrientation animationOrientation ;




@property ( nonatomic , retain ) UIAnimationImageView * subView ;
@property ( nonatomic , retain ) NSArray * imageArray ;
@property ( nonatomic , assign ) NSInteger imageIndex ;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self createUI];
}

-(void)createUI
{
    //1. pageviewController
    
//    [self animation0];
    
    
    //2. animation
    [self animation1];
    
}

#pragma mark - animation1

-(void)animation1
{
    _imageArray = @[@"Logo.png",@"Logo58.png"];
    _imageIndex = 0 ;
    
    
    
    _subView = [[UIAnimationImageView alloc]initWithFrame:CGRectMake(0, 400, CGRectGetWidth(self.view.frame), 200)];
    _subView.userInteractionEnabled = YES ;
    _subView.backgroundColor = [UIColor grayColor];
    _subView.image  =[UIImage imageNamed:_imageArray[_imageIndex]];
    _subView.layer.doubleSided = NO ;
    [self.view addSubview:_subView];
    

    [_subView setImageNameArray:_imageArray];
    
    [_subView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
}

-(void)tap
{
    NSLog(@"%@",@([_subView getCurrentShowImageIndex]));
}

#pragma mark - animation0

-(void)animation0
{
    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    _animationOrientation = HZBAnimationOrientationVertical ;
    _contentWidth = size.width ;
    _contentHeight = 64 ;
    
    [self prepareData];
    
    HZBAnimationView * animationView = [[HZBAnimationView alloc]initWithFrame:CGRectMake(0, 100, _contentWidth, _contentHeight) orientation:_animationOrientation direction:HZBAnimationDirectionForward animationCirculation:YES canDrag:NO] ;
    [animationView setDataArray:_dataArray];
    [self.view addSubview: animationView];

}
-(void)prepareData
{
    _dataArray = [NSMutableArray array];
    
    NSArray * strArray = @[
                           @"这是第一个数据" ,
                           @"遵循 UIPageViewControllerDelegate协议，当用手势导航页面和设备方向发生改变的时候会调用它的方法。 主要方法及功能如下： //翻页完成,如果翻页过程中取消翻页，则completed＝ false 可以实现内容页之间的导航功能，每一页的内容都由它自己的view controller来管理",
                           @"这是第二个数据" ,
                           @"这是第三个数据" ,
                           @"这是第四个数据" ,
                           @"这是第五个数据" ,

                           ];
    
    for (int i = 0 ; i  < 4;  i ++ )
    {
        HZBSingleModel * model = [[HZBSingleModel alloc]initWithDataDic:@{@"index":@(i),@"text":strArray[i],@"contentWidth":@(_contentWidth),@"contentHeight":@(_contentHeight),@"animationOrientation":@(_animationOrientation)}];
        
        [_dataArray addObject:model];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self createUI];
}

@end
