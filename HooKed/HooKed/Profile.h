//
//  Profile.h
//  HooKed
//
//  Created by Kristie Syda on 6/9/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Shop.h"

@interface Profile : SKScene
{
    NSString *userName;
    NSString *playerId;
    SKLabelNode *title_user;
    SKLabelNode *title_score;
    SKLabelNode *title_coins;
    SKLabelNode *lbl_coins;
    int score;
    int coins;

}

@end
