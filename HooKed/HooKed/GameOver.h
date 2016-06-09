//
//  GameOver.h
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOver : SKScene
{
    NSString *userName;
    NSString *playerId;
    int score;
    int highScore;
    int coins;
}

@end
