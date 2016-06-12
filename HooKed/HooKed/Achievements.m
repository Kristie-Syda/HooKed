//
//  Achievements.m
//  HooKed
//
//  Created by Kristie Syda on 6/11/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Achievements.h"
#import <Parse/Parse.h>
#import "AchData.h"
#import "TableCell.h"

@interface Achievements ()

@end

@implementation Achievements

-(void)getAchievements {
    
    //Pull parse data
    PFQuery *query = [PFQuery queryWithClassName:@"Achievements"];
    [query whereKey:@"Player" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSNumber *one;
        NSNumber *two;
        NSNumber *three;
        
        //Loop through parse objects
        for(PFObject *info in objects){
            one = info[@"A1"];
            two = info[@"A2"];
            three = info[@"A3"];
        }
    
        AchData *achievement1 = [[AchData alloc]init];
        achievement1.Title = @"StockPile";
        achievement1.Details = @"Earn 1,000 points";
        achievement1.Image = one;
        
        AchData *achievement2 = [[AchData alloc]init];
        achievement2.Title = @"Decade";
        achievement2.Details = @"Earn 2,000 points";
        achievement2.Image = two;
        
        AchData *achievement3 = [[AchData alloc]init];
        achievement3.Title = @"Five-spots";
        achievement3.Details = @"Earn 5,000 points";
        achievement3.Image = three;
        
        [achArray addObject:achievement1];
        [achArray addObject:achievement2];
        [achArray addObject:achievement3];
        [myTable reloadData];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Initalize array
    achArray = [[NSMutableArray alloc]init];
    [self getAchievements];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_menu"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [achArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell != nil){
        AchData *data = [achArray objectAtIndex:indexPath.row];
        [cell setUpAch:data.Title Details:data.Details Image:data.Image];
    }
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)back{
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
