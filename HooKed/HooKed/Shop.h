//
//  Shop.h
//  HooKed
//
//  Created by Kristie Syda on 6/10/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Shop : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSString *playerId;
    int coins;
    IBOutlet UILabel *coinLabel;
    NSMutableArray *items;
    IBOutlet UICollectionView *myCollection;
    NSString *shopImage;
}
@end
