//
//  ViewController.m
//  Calculator
//
//  Created by Chen Wang on 8/27/18.
//  Copyright © 2018 Chen Wang. All rights reserved.
//

#import "ViewController.h"
#import "KeyButton.h"

#define BUTTON_WIDTH (self.view.frame.size.width/4)
#define BUTTON_HEIGHT (self.view.frame.size.width/4)


@interface ViewController ()
{
    KeyButton* AC;
    CGFloat leftValue;
    NSInteger operator;//0 = /, 1 = *, 2 = -, 3 = +, 4 = =
    BOOL reload;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadTitleList];
    [self loadViews];
    [self createButtons];
    [self editLabel];
}


-(NSString*)formatDisplay:(CGFloat)num{
    
    
    NSString * testNumber = [NSString stringWithFormat:@"%f",num];
    
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    
    return outNumber;
    
    
    
//
//    if(num - (NSInteger)num == 0){
//        return [NSString stringWithFormat:@"%ld",(NSInteger)num];
//    }
//
//    if(((NSInteger)(num*1000) - (NSInteger)(num*100)*10)>=5){
//        num+= 0.001;
//    }
//    return [NSString stringWithFormat:@"%.3f",num];
}




//生成与按键匹配的title
-(void)loadTitleList{
    self.titleList = @{@"0-0":@"AC",
                       @"0-1":@"+/-",
                       @"0-2":@"%",
                       @"0-3":@"/",
                       @"1-0":@"7",
                       @"1-1":@"8",
                       @"1-2":@"9",
                       @"1-3":@"*",
                       @"2-0":@"4",
                       @"2-1":@"5",
                       @"2-2":@"6",
                       @"2-3":@"-",
                       @"3-0":@"1",
                       @"3-1":@"2",
                       @"3-2":@"3",
                       @"3-3":@"+",
                       @"4-2":@".",
                       @"4-3":@"=",
                       };
}


//设置显示窗口和按键区布局
- (void)loadViews{
    self.view.backgroundColor = [UIColor blackColor];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(5*BUTTON_HEIGHT))];
//    self.topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.topView];
    
    
    self.botView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-(5*BUTTON_HEIGHT), self.view.frame.size.width, 5*BUTTON_HEIGHT)];
    [self.view addSubview:self.botView];
}


-(void)createButtons{

    self.op = [[NSMutableArray alloc] init];
    //创建除了 0 以外的所有按键并放入buttonList
    for(NSInteger row = 0; row<5; row++){
        for(NSInteger col = 0; col<4; col++){
            if((row == 4 && col ==0) || (row == 4 && col == 1)){
                continue;
            }
            UIView* buttonView = [[UIView alloc]initWithFrame:CGRectMake(col*BUTTON_WIDTH, row*BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
            KeyButton * button = [[KeyButton alloc]initWithFrame:CGRectMake(10, 10, BUTTON_WIDTH-20, BUTTON_HEIGHT-20)];
            [button ColorWithRow:row Column:col];
            [button setTag:10000+row*100+col];
            
            [button setTitle:[NSString stringWithFormat:@"%@", [self.titleList objectForKey:[NSString stringWithFormat:@"%ld-%ld",row,col]]] forState:UIControlStateNormal];

            [buttonView addSubview:button];
            [self.botView addSubview:buttonView];
            
            if(row == 0 && col == 0){
                AC = button;
            }
            if(col == 3 && row != 4){
                [button addTarget:self action:@selector(operatorClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.op addObject:button];
            }else{
                [button addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
                [button addTarget:self action:@selector(buttonClicked2:) forControlEvents:UIControlEventTouchDown];
            }
        }
    }
    
    
    //按键 0
    UIView* buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 4*BUTTON_HEIGHT, BUTTON_WIDTH*2, BUTTON_HEIGHT)];
    KeyButton * button = [[KeyButton alloc]initWithFrame:CGRectMake(10, 10, (BUTTON_WIDTH*2-20), BUTTON_HEIGHT-20)];
    [button setTag:20000];
    
    
    [button.layer setCornerRadius:(buttonView.bounds.size.width-20)/4-5];
    
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, (BUTTON_WIDTH*2-20)/4-10, 0, 0)];
    
    
    [button setTitle:@"0" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(buttonClicked2:) forControlEvents:UIControlEventTouchDown];
    
    [buttonView addSubview:button];
    [self.botView addSubview:buttonView];
}



-(void)operatorClicked:(KeyButton*)sender{
    [UIView animateWithDuration:0.2 animations:^{
        for(KeyButton * button in self.op){
            if(button.tag == sender.tag){
                sender.backgroundColor = sender.highlightColor;
                [sender setTitleColor:sender.highlightTextColor forState:UIControlStateNormal];
            }else{
                button.backgroundColor = button.PreColor;
                [button setTitleColor:button.PreTextColor forState:UIControlStateNormal];
            }
        }
    }];
    reload = YES;
    switch (sender.tag) {
        case 10003:
            NSLog(@"/");
            if(!leftValue){
                leftValue = [self.display.text floatValue];
                operator = 0;
            }else{
                [self calculate];
                operator = 0;
            }
            break;
            
        case 10103:
            NSLog(@"*");
            if(!leftValue){
                leftValue = [self.display.text floatValue];
                operator = 1;
            }else{
                [self calculate];
                operator = 1;
            }
            break;
            
        case 10203:
            NSLog(@"-");
            if(!leftValue){
                leftValue = [self.display.text floatValue];
                operator = 2;
            }else{
                [self calculate];
                operator = 2;
            }
            break;
            
        case 10303:
            NSLog(@"+");
            if(!leftValue){
                leftValue = [self.display.text floatValue];
                operator = 3;
            }else{
                [self calculate];
                operator = 3;
            }
            break;
            
        default:
            NSLog(@"sender tag: %ld",sender.tag);
            break;
    }
}


-(void)calculate{
    switch (operator) {
        case 0:// /
            leftValue /= [self.display.text floatValue];
            self.display.text = [self formatDisplay:leftValue];//[NSString stringWithFormat:@"%f",leftValue];
            break;
            
        case 1:// *
            leftValue *= [self.display.text floatValue];
            self.display.text = [self formatDisplay:leftValue];//[NSString stringWithFormat:@"%f",leftValue];
            break;
            
        case 2:// -
            leftValue -= [self.display.text floatValue];
            self.display.text = [self formatDisplay:leftValue];//[NSString stringWithFormat:@"%f",leftValue];
            break;
            
        case 3:// +
            leftValue += [self.display.text floatValue];
            self.display.text = [self formatDisplay:leftValue];//[NSString stringWithFormat:@"%f",leftValue];
            break;
            
        case 4:
            break;
            
        default:
            break;
    }
}


-(void)buttonClicked1:(KeyButton*)sender{
    //NSLog(@"2");
    [UIView animateWithDuration:0.2 animations:^{
        sender.backgroundColor = sender.PreColor;
        [sender setTitleColor:sender.PreTextColor forState:UIControlStateNormal];
    }];
    
    switch (sender.tag) {
        case 10000:
            
            if([sender.currentTitle isEqualToString:@"C"]){
                self.display.text = @"0";
            }else{
                leftValue = 0;
            }
            
            break;
        case 10001:
            if([self.display.text floatValue]>0){
                self.display.text = [@"-" stringByAppendingString:self.display.text];
            }else{
                self.display.text = [self formatDisplay: (0-[self.display.text floatValue])];
            }
            
            break;
            
        case 10002:
            self.display.text = [self formatDisplay:[self.display.text floatValue]/100];//[NSString stringWithFormat:@"%f",[self.display.text floatValue]/100];
            break;
        case 10403:
            reload = YES;
            if(!leftValue){
                operator = 4;
            }else{
                [self calculate];
                operator = 4;
            }
            
            break;
            
        default:
            
            [UIView animateWithDuration:0.2 animations:^{
                for(KeyButton* button in self.op){
                    button.backgroundColor = button.PreColor;
                    [button setTitleColor:button.PreTextColor forState:UIControlStateNormal];
                }
            }];
            if(reload){
                self.display.text = @"0";
                reload = NO;
            }
            
            if([self.display.text isEqualToString:@"0"]){
                self.display.text = sender.currentTitle;
            }else{
                self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
            }
            
            break;
    }
    
    if([self.display.text isEqualToString:@"0"]){
        [AC setTitle:@"AC" forState:UIControlStateNormal];
    }else{
        [AC setTitle:@"C" forState:UIControlStateNormal];
    }
    
}

-(void)buttonClicked2:(KeyButton*)sender{
   //NSLog(@"1");
        sender.backgroundColor = sender.highlightColor;
    [sender setTitleColor:sender.highlightTextColor forState:UIControlStateNormal];
    
}


-(void)editLabel{
    self.display = [[UILabel alloc]initWithFrame:CGRectMake(15, (self.view.frame.size.height-(5*BUTTON_HEIGHT))/2, self.view.frame.size.width-30, (self.view.frame.size.height-(5*BUTTON_HEIGHT))/2)];
    self.display.textAlignment = NSTextAlignmentRight;

    [self.display setTextColor:[UIColor whiteColor]];
    [self.display setFont:[UIFont systemFontOfSize:80 weight:0.1]];
    [self.display setText:@"0"];
    [self.topView addSubview:self.display];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
