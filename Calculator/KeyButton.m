//
//  KeyButton.m
//  Calculator
//
//  Created by Chen Wang on 8/27/18.
//  Copyright © 2018 Chen Wang. All rights reserved.
//

#import "KeyButton.h"

@implementation KeyButton



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        NSLog(@"init called");
        self.titleLabel.font = [UIFont systemFontOfSize:30 weight:0.2];

        self.backgroundColor = [UIColor darkGrayColor];
        [self.layer setCornerRadius:(frame.size.width)/2];
        self.PreColor = [UIColor darkGrayColor];
        self.highlightColor = [UIColor lightGrayColor];
        self.PreTextColor = [UIColor whiteColor];
        self.highlightTextColor = [UIColor whiteColor];
    }
    return self;
}

-(void)ColorWithRow:(NSInteger)row Column:(NSInteger)col{
    if(row ==0 && col!=3){
        self.backgroundColor = [UIColor lightGrayColor];
        self.PreColor = [UIColor lightGrayColor];
        self.highlightColor = [UIColor whiteColor];
        self.PreTextColor = [UIColor blackColor];
        self.highlightTextColor = [UIColor blackColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    if(col == 3){
        self.backgroundColor = [UIColor orangeColor];
        self.PreColor = [UIColor orangeColor];
        self.highlightColor = [UIColor whiteColor];
        self.PreTextColor = [UIColor whiteColor];
        self.highlightTextColor = [UIColor orangeColor];
    }
}

@end
