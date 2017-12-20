//
//  MSSAutoresizeLabelFlowConfig.m
//  MSSAutoresizeLabelFlow
//
//  Created by Mrss on 15/12/26.
//  Copyright © 2015年 expai. All rights reserved.
//

#import "MSSAutoresizeLabelFlowConfig.h"

@implementation MSSAutoresizeLabelFlowConfig

+ (MSSAutoresizeLabelFlowConfig *)shareConfig {
    static MSSAutoresizeLabelFlowConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc]init];
    });
    return config;
}

// default

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentInsets = UIEdgeInsetsMake(10, 10, 10, 2);
        self.lineSpace = 10;
        self.itemHeight = 25;
        self.itemSpace = 10;
        self.itemCornerRaius = 5;
        self.itemColor = [UIColor whiteColor];
        self.itemColor = [UIColor clearColor];
        self.textMargin = 20;
        self.textColor = [UIColor darkTextColor];
        self.textColor = [UIColor whiteColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.backgroundColor = kwhiteColor;
        
        self.colors = @[kcolorWithRGB(146, 197, 238),kcolorWithRGB(192, 104, 208),kcolorWithRGB(245, 188, 120),kcolorWithRGB(145, 206, 213),kcolorWithRGB(103, 204, 183),kcolorWithRGB(231, 143, 143)];
    }
    return self;
}

@end
