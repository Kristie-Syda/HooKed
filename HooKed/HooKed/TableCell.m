//
//  TableCell.m
//  HooKed
//
//  Created by Kristie Syda on 6/10/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//Set up tableview cells for leaderboard
-(void)setUpCell:(int)rankNumber name:(NSString*)username score:(NSNumber *)scoreNumber {
    rank.text = [NSString stringWithFormat:@"%d",rankNumber];
    userName.text = username;
    score.text = [scoreNumber stringValue];
}

//Set up tableview cells for achievements
-(void)setUpAch:(NSString *)title Details:(NSString *)details Image:(NSNumber *)pic {
    UIImage *green = [UIImage imageNamed:@"green"];
    UIImage *grey = [UIImage imageNamed:@"grey"];
    
    Title.text = title;
    Details.text = details;
    
    
    if(pic == [NSNumber numberWithBool:0]){
        status.image = grey;
    } else if(pic == [NSNumber numberWithBool:1]) {
        status.image = green;
    }
    
}

@end
