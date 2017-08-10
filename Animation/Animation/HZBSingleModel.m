//
//  HZBSingleModel.m
//  Animation
//
//  Created by 安宁 on 2017/6/23.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBSingleModel.h"

@implementation HZBSingleModel

-(instancetype)initWithDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self ;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
