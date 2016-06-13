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
    
    TutData *pg2 = [[TutData alloc]init];
    pg2.info = @"Avoid the hooks that randomly come down.";
    pg2.pic = @"tut_hook";
    
    TutData *pg3 = [[TutData alloc]init];
    pg3.info = @"Eat the Worms to grow bigger.";
    pg3.pic = @"worm_001";

    
    [pages addObject:pg1];
    [pages addObject:pg2];
    [pages addObject:pg3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self grabData];
    object = 0;
  
    TutData *data = [pages objectAtIndex:object];
    infoLabel.text = data.info;
    imgView.image = [UIImage imageNamed:data.pic];
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
    if(object > 2){
        object = 0;
    }
    TutData *data = [pages objectAtIndex:object];
    infoLabel.text = data.info;
    imgView.image = [UIImage imageNamed:data.pic];
}

-(IBAction)previous:(id)sender {
    object --;
    if(object < 0){
        object = 2;
    }
    TutData *data = [pages objectAtIndex:object];
    infoLabel.text = data.info;
    imgView.image = [UIImage imageNamed:data.pic];
}

@end
