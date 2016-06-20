//
//  Leaderboard.m
//  HooKed
//
//  Created by Kristie Syda on 6/9/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Leaderboard.h"
#import <Parse/Parse.h>
#import "Data.h"
#import "TableCell.h"

@interface Leaderboard ()

@end

@implementation Leaderboard

#pragma mark - Data Methods
//Load Global Scores
-(void)loadGlobal {
    type.text = @"Global Leaderboard";
    [playerArray removeAllObjects];
    current = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query orderByDescending:@"HighScore"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *all, NSError *error) {
        i = 0;
        //loop through data and create custom object
        for (PFObject *player in all) {

            Data *data = [[Data alloc]init];
            data.name = player[@"UserName"];
            data.score = player[@"HighScore"];
            data.playerId = current.objectId;
            data.location = player[@"Location"];
            data.rank = ++i;
            
            //add to array
            [playerArray addObject:data];
        }
        //reload data while in this method to finish loading
        [myTable reloadData];
    }];
}
//Load Local Scores
-(void)loadLocal {
    type.text = @"Local Leaderboard";
    [playerArray removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query orderByDescending:@"HighScore"];
   
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        PFGeoPoint *location = geoPoint;
        [query whereKey:@"Location" nearGeoPoint:location withinMiles:20];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            i = 0;
            //loop through data and create custom object
            for (PFObject *player in objects) {
                
                Data *data = [[Data alloc]init];
                data.name = player[@"UserName"];
                data.score = player[@"HighScore"];
                data.playerId = current.objectId;
                data.location = player[@"Location"];
                data.rank = ++i;
                
                //add to array
                [playerArray addObject:data];
            }
            //reload data while in this method to finish loading
            [myTable reloadData];
        }];
    }];
}
//Get facebook friends score
-(void)getFriends{
    type.text = @"Facebook Friends";
    [playerArray removeAllObjects];
    
    //For first time players
    NSArray *permissionsArray = @[ @"public_profile", @"user_friends"];
    if (![PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [PFFacebookUtils linkUserInBackground:[PFUser currentUser] withReadPermissions:permissionsArray block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"User linked to Facebook!");
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id"}];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Store the current user's Facebook ID on the user
                        [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                                 forKey:@"FB"];
                        [[PFUser currentUser] saveInBackground];
                    }
                }];
            } else {
                NSLog(@"User denied facebook");
            }
        }];
    }
    
    //Find out friend info
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/friends" parameters:@{@"fields": @"id"}];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        NSArray *dataArray = [result objectForKey:@"data"];
        idArray = [[NSMutableArray alloc]init];
        
        if(dataArray){
            //grab id's of friends
            for(NSMutableDictionary *friendId in dataArray){
                NSString *idNumber = [friendId objectForKey:@"id"];
                [idArray addObject:idNumber];
            }
        
            //Find the id's in parse
            PFQuery *query = [PFUser query];
            [query whereKey:@"FB" containedIn:idArray];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError * _Nullable error) {
                i = 0;
                for(PFObject *object in objects) {
                    //Find out player id's for all
                    PFQuery *score = [PFQuery queryWithClassName:@"Score"];
                    [score whereKey:@"Player" equalTo:object];
                    [score orderByDescending:@"HighScore"];
                    [score findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                        //Loop through player array
                        for(PFObject *player in objects){
                         //Get info of friends
                            PFQuery *info = [PFQuery queryWithClassName:@"Score"];
                            [info getObjectInBackgroundWithId:[player objectId] block:^(PFObject * _Nullable object, NSError * _Nullable error) {
                                //Loop through data and create custom object
                                for (PFObject *player in objects) {
                                    Data *data = [[Data alloc]init];
                                    data.name = player[@"UserName"];
                                    data.score = player[@"HighScore"];
                                    data.rank = ++i;
                                    //Add to main array
                                    [playerArray addObject:data];
                                }
                                //Reload data while in this method to finish loading
                                [myTable reloadData];
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

#pragma mark - SetUp View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize array
    playerArray = [[NSMutableArray alloc]init];
    [self loadGlobal];
    
    if ( [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"] ) {
    
    }else {
         [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_menu"]]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [playerArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell != nil){
        Data *data = [playerArray objectAtIndex:indexPath.row];
        [cell setUpCell:data.rank name:data.name score:data.score];
    }
    
    return cell;
}

#pragma mark - IBActions
-(IBAction)local:(id)sender {
    [self loadLocal];
}
-(IBAction)global:(id)sender {
    [self loadGlobal];
}
-(IBAction)friends:(id)sender {
    [self getFriends];
}
-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
