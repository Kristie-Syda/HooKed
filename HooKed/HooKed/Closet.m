//
//  Closet.m
//  HooKed
//
//  Created by Kristie Syda on 6/12/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Closet.h"
#import "ShopData.h"
#import "ShopCell.h"

@interface Closet ()

@end

@implementation Closet

-(void)outfitChanged {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:@"Outfit changed"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yes = [UIAlertAction actionWithTitle:@"OKAY"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                }];
    [alert addAction:yes];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)chooseItem:(NSString *)item {
    PFQuery *info = [PFQuery queryWithClassName:@"Score"];
    [info getObjectInBackgroundWithId:playerId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        
        object[@"ItemName"] = item;
        [self outfitChanged];
        [object saveInBackground];
    }];
}
-(void)grabData {
    items = [[NSMutableArray alloc]init];
    
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
        
            //Loop through closet
            for(NSString *img in alreadyOwn){
                NSString *str = [img substringWithRange:NSMakeRange(4, [img length]-4)];
                
                ShopData *data = [[ShopData alloc]init];
                data.shopName = img;
                data.imageName = str;
                [items addObject:data];
            }
            [myCollection reloadData];
        }];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self grabData];
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
    [cell SetupCloset:data.imageName name:data.shopName];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    if(cell != nil){
        ShopData *data = [items objectAtIndex:indexPath.row];
        [self chooseItem:data.shopName];
    }
}

-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
