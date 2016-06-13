//
//  GameOver.h
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface GameOver : SKScene <FBSDKSharingDelegate>
{
    NSString *userName;
    NSString *playerId;
    int score;
    int highScore;
    int coins;
    int newCoins;
    FBSDKShareLinkContent *shareLink;
    FBSDKShareButton *btn_share;
}

@end
