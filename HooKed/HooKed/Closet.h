//
//  Closet.h
//  HooKed
//
//  Created by Kristie Syda on 6/12/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Closet : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
{
    IBOutlet UICollectionView *myCollection;
    NSMutableArray *items;
    NSString *playerId;
}

@end
