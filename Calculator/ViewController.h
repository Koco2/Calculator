//
//  ViewController.h
//  Calculator
//
//  Created by Chen Wang on 8/27/18.
//  Copyright © 2018 Chen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic,strong)NSMutableArray * op;
@property(nonatomic,strong)UILabel *display;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *botView;
@property(nonatomic,strong)NSDictionary * titleList;


@end

