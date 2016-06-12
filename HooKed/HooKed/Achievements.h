//
//  Achievements.h
//  HooKed
//
//  Created by Kristie Syda on 6/11/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Achievements : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *myTable;
    NSMutableArray *achArray;
}
@end
