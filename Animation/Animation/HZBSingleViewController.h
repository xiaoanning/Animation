//
//  HZBSingleViewController.h
//  Animation
//
//  Created by 安宁 on 2017/6/23.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZBSingleModel.h"


@interface HZBSingleViewController : UIViewController

@property ( nonatomic , retain ) HZBSingleModel * singleModel ; //数据

@property ( nonatomic , copy ) void(^animationStratCallback)(BOOL start) ; //动画开始和结束的回调

@end
