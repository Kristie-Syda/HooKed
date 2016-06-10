//
//  Leaderboard.h
//  HooKed
//
//  Created by Kristie Syda on 6/9/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Leaderboard : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTable;
    NSMutableArray *playerArray;
    PFUser *current;
    IBOutlet UIButton *btn_local;
    IBOutlet UIButton *btn_global;
    IBOutlet UIButton *btn_friends;
}
@end
