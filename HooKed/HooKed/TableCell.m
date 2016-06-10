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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUpCell:(int)rankNumber name:(NSString*)username score:(NSNumber *)scoreNumber {
    rank.text = [NSString stringWithFormat:@"%d",rankNumber];
    userName.text = username;
    score.text = [scoreNumber stringValue];
}

@end
