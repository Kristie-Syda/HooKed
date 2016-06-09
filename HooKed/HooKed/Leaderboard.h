//
//  Leaderboard.h
//  HooKed
//
//  Created by Kristie Syda on 6/9/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Leaderboard : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTable;
    NSMutableArray *playerArray;
}
@end
