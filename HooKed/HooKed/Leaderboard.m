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

@interface Leaderboard ()

@end

@implementation Leaderboard

#pragma mark - Data Methods
//Load Global Scores
-(void)loadGlobal {
    NSLog(@"loadGlobal");
    [playerArray removeAllObjects];
    current = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query orderByDescending:@"HighScore"];
    [query whereKey:@"HighScore" greaterThan:@0];
    [query findObjectsInBackgroundWithBlock:^(NSArray *all, NSError *error) {
        int i = 0;
        //loop through data and create custom object
        for (PFObject *player in all) {

            Data *data = [[Data alloc]init];
            data.name = player[@"UserName"];
            data.score = player[@"score"];
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
   
    [playerArray removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query orderByDescending:@"HighScore"];
    [query whereKey:@"HighScore" greaterThan:@0];
   
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        PFGeoPoint *location = geoPoint;
        [query whereKey:@"Location" nearGeoPoint:location withinMiles:20];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            int i = 0;
            //loop through data and create custom object
            for (PFObject *player in objects) {
                
                Data *data = [[Data alloc]init];
                data.name = player[@"UserName"];
                data.score = player[@"score"];
                data.playerId = current.objectId;
                data.location = player[@"Location"];
                data.rank = ++i;
                
                NSLog(@"%@",player[@"USerName"]);
                //add to array
                [playerArray addObject:data];
            }
            //reload data while in this method to finish loading
            [myTable reloadData];
        }];
    }];
}

#pragma mark - SetUp View
- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize array
    playerArray = [[NSMutableArray alloc]init];
    [self loadGlobal];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_menu"]]];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell != nil){
        Data *data = [playerArray objectAtIndex:indexPath.row];
        cell.textLabel.text = data.name;
        cell.detailTextLabel.text = [data.score stringValue];
    }
    
    return cell;
}

#pragma mark - IBActions
-(IBAction)local:(id)sender {
    [self loadLocal];
}
-(IBAction)gloabal:(id)sender {
    [self loadGlobal];
}

@end
