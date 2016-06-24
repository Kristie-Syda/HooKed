//
//  Tutorial.m
//  HooKed
//
//  Created by Kristie Syda on 6/12/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Tutorial.h"
#import "TutData.h"

@interface Tutorial ()

@end

@implementation Tutorial

-(void)grabData {
    pages = [[NSMutableArray alloc]init];
    
    TutData *pg1 = [[TutData alloc]init];
    pg1.info = @"Tap fish to move forward & stop tapping fish to move backwards.";
    pg1.pic = @"swim__000";
    pg1.pgNum = @"1";
    
    TutData *pg2 = [[TutData alloc]init];
    pg2.info = @"Avoid the hooks that randomly come down.";
    pg2.pic = @"tut_hook";
    pg2.pgNum = @"2";
    
    TutData *pg3 = [[TutData alloc]init];
    pg3.info = @"Eat the Worms to grow bigger & faster.";
    pg3.pic = @"worm_001";
    pg3.pgNum = @"3";
    
    TutData *pg4 = [[TutData alloc]init];
    pg4.info = @"Eat the worms to also change into a different kind of fish. Watch the bar at the top left.";
    pg4.pic = @"tut_fishBar";
    pg4.pgNum = @"4";
    
    TutData *pg5 = [[TutData alloc]init];
    pg5.info = @"The further you go, the higher the score you get. You will also recieve coins for the score you earn each round";
    pg5.pic = @"tut_score";
    pg5.pgNum = @"5";
    
    TutData *pg6 = [[TutData alloc]init];
    pg6.info = @"Use your coins to buy items in the shop";
    pg6.pic = @"tut_shop";
    pg6.pgNum = @"6";

    
    [pages addObject:pg1];
    [pages addObject:pg2];
    [pages addObject:pg3];
    [pages addObject:pg4];
    [pages addObject:pg5];
    [pages addObject:pg6];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self grabData];
    object = 0;
  
    TutData *data = [pages objectAtIndex:object];
    infoLabel.text = data.info;
    imgView.image = [UIImage imageNamed:data.pic];
    progress.text = [NSString stringWithFormat:@"%@/6", data.pgNum];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_menu"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)next:(id)sender {
    object ++;
    if(object > 5){
        object = 0;
    }
    TutData *data = [pages objectAtIndex:object];
    infoLabel.text = data.info;
    imgView.image = [UIImage imageNamed:data.pic];
    progress.text = [NSString stringWithFormat:@"%@/6", data.pgNum];
}

-(IBAction)previous:(id)sender {
    object --;
    if(object < 0){
        object = 2;
    }
    TutData *data = [pages objectAtIndex:object];
    infoLabel.text = data.info;
    imgView.image = [UIImage imageNamed:data.pic];
    progress.text = [NSString stringWithFormat:@"%@/6", data.pgNum];
}

@end
