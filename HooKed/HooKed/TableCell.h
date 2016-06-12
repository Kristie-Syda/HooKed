//
//  TableCell.h
//  HooKed
//
//  Created by Kristie Syda on 6/10/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
{
    IBOutlet UILabel *rank;
    IBOutlet UILabel *userName;
    IBOutlet UILabel *score;
    IBOutlet UIImageView *status;
    IBOutlet UILabel *Title;
    IBOutlet UILabel *Details;
}

-(void)setUpCell:(int)rankNumber name:(NSString*)username score:(NSNumber *)scoreNumber;
-(void)setUpAch:(NSString *)title Details:(NSString *)details Image:(NSNumber *)pic;

@end
