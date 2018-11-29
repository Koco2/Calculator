//
//  KeyButton.h
//  Calculator
//
//  Created by Chen Wang on 8/27/18.
//  Copyright © 2018 Chen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyButton : UIButton


@property(nonatomic,strong)UIColor * PreColor;
@property(nonatomic,strong)UIColor * highlightColor;
@property(nonatomic,strong)UIColor * PreTextColor;
@property(nonatomic,strong)UIColor * highlightTextColor;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)ColorWithRow:(NSInteger)row Column:(NSInteger)col;

@end
