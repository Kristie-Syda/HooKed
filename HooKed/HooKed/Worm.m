//
//  Worm.m
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Worm.h"

@implementation Worm

- (BOOL) collision:(SKNode *)fish {

    //Makes fish go faster when eats a worm
    fish.physicsBody.velocity = CGVectorMake(fish.physicsBody.velocity.dx + 20, fish.physicsBody.velocity.dy);
    [self removeFromParent];
    return YES;


}

@end
