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
#import "profile.h"
#import <SpriteKit/SpriteKit.h>

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
    
    ShopData *yellowShirt = [[ShopData alloc]init];
    yellowShirt.price = 100;
    yellowShirt.imageName = @"yellowShirt";
    yellowShirt.name = @"Yellow Shirt";
    yellowShirt.shopName = @"img_yellowShirt";
    
    ShopData *beenieHat = [[ShopData alloc]init];
    beenieHat.price = 50;
    beenieHat.imageName = @"beenieHat";
    beenieHat.name = @"Beenie Hat";
    beenieHat.shopName = @"img_beenieHat";
    
    ShopData *drinkHat = [[ShopData alloc]init];
    drinkHat.price = 500;
    drinkHat.imageName = @"drinkHat";
    drinkHat.name = @"Drink Hat";
    drinkHat.shopName = @"img_drinkHat";
    
    ShopData *vikingHat = [[ShopData alloc]init];
    vikingHat.price = 300;
    vikingHat.imageName = @"vikingHat";
    vikingHat.name = @"Viking Hat";
    vikingHat.shopName = @"img_vikingHat";
    
    ShopData *santaHat = [[ShopData alloc] init];
    santaHat.price = 200;
    santaHat.imageName = @"santaHat";
    santaHat.name = @"Santa Hat";
    santaHat.shopName = @"img_santaHat";
    
    ShopData *spinHat = [[ShopData alloc] init];
    spinHat.price = 400;
    spinHat.imageName = @"spinHat";
    spinHat.name = @"Spin Hat";
    spinHat.shopName = @"img_spinHat";

    //add to array
    [items addObject:blueShirt];
    [items addObject:redShirt];
    [items addObject:yellowShirt];
    [items addObject:beenieHat];
    [items addObject:drinkHat];
    [items addObject:vikingHat];
    [items addObject:santaHat];
    [items addObject:spinHat];
}
-(void)cantBuyItem:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
   
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"OKAY"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
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
            NSArray *alreadyOwn = object[@"Closet"];
            Boolean dontHave = false;
            
            //Loop through closet
            for(NSString *img in alreadyOwn){
                if([img isEqualToString:data.shopName]){
                    dontHave = true;
                }
            }
            
            //Can buy if player dont already own it
            if(dontHave == false) {
                //Can buy if player has enough coins
                if(coins > sData.price) {
                    //deduct price from total coins
                    int newCoins = coins - sData.price;
                    
                    //set new coins
                    object[@"Coins"] = [NSNumber numberWithInt:newCoins];
                    //set new item in closet
                    [object addUniqueObject:sData.shopName forKey:@"Closet"];
                    object[@"ItemName"] = sData.shopName;
                    [self GrabCoins];
                    [self cantBuyItem:@"Item bought"];
                    [object saveInBackground];
                } else {
                      //informs player they do not have enough coins
                     [self cantBuyItem:@"Not enough coins in the back"];
                }
            } else {
                //informs player they already own item
                [self cantBuyItem:@"You already own this item"];
            }
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Grab coins from parse
    [self GrabCoins];
    //Grab data to make collectionview
    [self GrabData];
    
    if ( [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"] ) {
    } else {
        //Background
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_menu"]]];
    }
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

@end
