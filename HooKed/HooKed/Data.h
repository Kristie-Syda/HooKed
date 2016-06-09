//
//  Data.h
//  HooKed
//
//  Created by Kristie Syda on 6/9/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Data : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *playerId;
@property(nonatomic, strong) NSNumber *score;
@property(nonatomic, assign) int rank;
@property(nonatomic, strong) PFGeoPoint *location;


@end
