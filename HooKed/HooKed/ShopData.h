//
//  ShopData.h
//  HooKed
//
//  Created by Kristie Syda on 6/10/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopData : NSObject
@property(nonatomic, assign)int price;
@property(nonatomic, strong)NSString *imageName;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *shopName;
@property(nonatomic, strong)NSArray *clothes;
@property(nonatomic, strong)NSNumber *own;
@end
