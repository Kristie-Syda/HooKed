//
//  ShopCell.h
//  HooKed
//
//  Created by Kristie Syda on 6/10/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UICollectionViewCell
{
    IBOutlet UIImageView *picView;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *nameLabel;
}

-(void)SetupCell:(int)price image:(NSString *)pic name:(NSString *)name;
-(void)SetupCloset:(NSString*)pic name:(NSString*)name;
@end
