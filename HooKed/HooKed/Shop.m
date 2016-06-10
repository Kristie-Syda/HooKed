//
//  Shop.m
//  HooKed
//
//  Created by Kristie Syda on 6/10/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Shop.h"
#import <Parse/Parse.h>
#import "ShopData.h"
#import "ShopCell.h"

@interface Shop ()

@end

@implementation Shop


-(void)GrabCoins {
    //Pull data from parse
    PFUser *current = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query whereKey:@"Player" equalTo:current];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //Loop through player array
        for(PFObject *player in objects){
            playerId = [player objectId];
        }
        
        //Get coin info
        PFQuery *info = [PFQuery queryWithClassName:@"Score"];
        [info getObjectInBackgroundWithId:playerId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            coins = [[object objectForKey:@"Coins"] intValue];
            coinLabel.text = [NSString stringWithFormat:@"%d",coins];
        }];
        
    }];

}
-(void)GrabData {
    
    items = [[NSMutableArray alloc]init];
    
    ShopData *blueShirt = [[ShopData alloc]init];
    blueShirt.price = 100;
    blueShirt.imageName = @"blueShirt";
    blueShirt.name = @"Blue Shirt";
    blueShirt.shopName = @"img_blueShirt";
    
    ShopData *redShirt = [[ShopData alloc]init];
    redShirt.price = 100;
    redShirt.imageName = @"redShirt";
    redShirt.name = @"Red Shirt";
    redShirt.shopName = @"img_redShirt";
    
    //add to array
    [items addObject:blueShirt];
    [items addObject:redShirt];
}
-(void)buyItem:(ShopData *)data {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:@"Are you sure you want to buy this?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yes = [UIAlertAction actionWithTitle:@"YES"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    ShopData *info =  [[ShopData alloc]init];
                                                    info = data;
                                                    [self checkItems:info];
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"NO"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    [alert addAction:cancel];
    [alert addAction:yes];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)checkItems:(ShopData *)data {
    ShopData *sData = [[ShopData alloc]init];
    sData = data;
    PFUser *current = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    //Find player
    [query whereKey:@"Player" equalTo:current];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //Loop through player array
        for(PFObject *player in objects){
            playerId = [player objectId];
        }
        //Get info
        PFQuery *info = [PFQuery queryWithClassName:@"Score"];
        [info getObjectInBackgroundWithId:playerId block:^(PFObject * _Nullable object, NSError * _Nullable error) {

            //deduct price from total coins
            int newCoins = coins - sData.price;
            
            //set new coins
            object[@"Coins"] = [NSNumber numberWithInt:newCoins];
            //set new item in closet
            [object addUniqueObject:sData.shopName forKey:@"Closet"];
             object[@"ItemName"] = sData.shopName;
            [self GrabCoins];
            [object saveInBackground];
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Grab coins from parse
    [self GrabCoins];
    //Grab data to make collectionview
    [self GrabData];
    //Background
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_menu"]]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [items count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    ShopData *data = [items objectAtIndex:indexPath.row];
    [cell SetupCell:data.price image:data.imageName name:data.name];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    if(cell != nil){
        ShopData *data = [items objectAtIndex:indexPath.row];
        [self buyItem:data];
    }
}

-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
