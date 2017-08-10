//
//  HZBSingleViewController.m
//  Animation
//
//  Created by 安宁 on 2017/6/23.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBSingleViewController.h"

@interface HZBSingleViewController ()

@property ( nonatomic , retain ) UILabel * showContentLabel ;

@property ( nonatomic , assign ) CGSize contentSize ;

@end

@implementation HZBSingleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [self createContentView];
}

-(void)createContentView
{
    _showContentLabel = [[UILabel alloc]init];
//    _showContentLabel.backgroundColor = [UIColor lightGrayColor];
    _showContentLabel.text = [NSString stringWithFormat:@"index:%@ text:%@",@(_singleModel.index),_singleModel.text];
    _showContentLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:_showContentLabel];
    
    [self setLabelFrame];
}

-(void)setLabelFrame
{
    if (_singleModel.animationOrientation == HZBAnimationOrientationVertical)
    {
        //多行显示 设置截断模式
        _showContentLabel.numberOfLines = 0 ;
        _showContentLabel.lineBreakMode = NSLineBreakByClipping ;
        
        //计算单行的文字高度
        CGFloat singleLineHeight = [self getTextHeight:_showContentLabel.font];
        
        //设置行间距
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = (_singleModel.contentHeight - singleLineHeight)/2  ;
        
        //富文本设置文字和段落的样式
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_showContentLabel.text] attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
        _showContentLabel.attributedText = attStr ;
        
        //计算文本所占的区域
        _contentSize = [_showContentLabel sizeThatFits:CGSizeMake(_singleModel.contentWidth - 10*2, 9999)];

        //设置文本的frame
        _showContentLabel.frame = CGRectMake(10, paragraphStyle.lineSpacing, _contentSize.width, _contentSize.height) ;
        
        CGRect frameTemp = _showContentLabel.frame ;

        //当本文高度大于跑马屏的高度时  分多行显示
        if ( _contentSize.height - (-frameTemp.origin.y + _singleModel.contentHeight) > 0)
        {
            //动画开始时回调
            [self animationCallback:NO];
            
            __block typeof(self) weakSelf = self ;
            //定时 隔断时间移动一行
            [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * timer) {
                
                CGRect frame = weakSelf.showContentLabel.frame ;
                //换行显示的动画
                [UIView animateWithDuration:1 animations:^{
                    
                        //移动label 显示下一行
                    weakSelf.showContentLabel.frame = CGRectMake(frame.origin.x, paragraphStyle.lineSpacing + frame.origin.y - weakSelf.singleModel.contentHeight , frame.size.width, frame.size.height) ;
                    
                    //当显示最后一行时  停止定时 停止动画 并回调
                    if ( weakSelf.contentSize.height - (-frame.origin.y + weakSelf.singleModel.contentHeight) <= weakSelf.singleModel.contentHeight - paragraphStyle.lineSpacing )
                    {
                        [timer setFireDate:[NSDate distantFuture]];
                        [weakSelf animationCallback:YES];
                    }

                } completion:^(BOOL finished) {
                    
                }];
            }];
        }

    }
}

-(void)animationCallback:(BOOL )start
{
    if (_animationStratCallback)
    {
        _animationStratCallback(start);
    }
}

-(CGFloat)getTextHeight:(UIFont *)font
{
    UILabel * label = [[UILabel alloc]init];
    label.font = font ;
    label.text = [NSString stringWithFormat:@"测试21"];
    [label sizeToFit];
    
    return label.frame.size.height ;
}

@end
