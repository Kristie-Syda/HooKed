//
//  ShopCell.m
//  HooKed
//
//  Created by Kristie Syda on 6/10/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell


//Sets up Shop
-(void)SetupCell:(int)price image:(NSString *)pic name:(NSString *)name {
    
    priceLabel.text = [NSString stringWithFormat:@"%d",price];
    picView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", pic]];
    nameLabel.text = name;
}

//Sets up closet
-(void)SetupCloset:(NSString*)pic name:(NSString*)name {
    picView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", pic]];
    nameLabel.text = name;
}
                                        
                                        
                                        
                                        
                                        
                            
@end
