//
//  Leaderboard.h
//  HooKed
//
//  Created by Kristie Syda on 6/9/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface Leaderboard : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTable;
    NSMutableArray *playerArray;
    NSMutableArray *idArray;
    PFUser *current;
    IBOutlet UILabel *type;
    int i;
    NSString *playerId;
}
@end
