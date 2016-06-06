//
//  ScoreBox.m
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "ScoreBox.h"

@implementation ScoreBox

-(SKSpriteNode *)CreateBar:(CGPoint)position {
    SKSpriteNode *fishBar = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(0, 0)];
    fishBar.position = position;
    fishBar.zPosition = 2;
    fishBar.anchorPoint = CGPointMake(0,0);
    return fishBar;
}

//Create Score Box
-(SKNode *)createScoreBox:(CGPoint)position {
    
    SKNode *scoreBox = [SKNode node];
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"scoreBox"];
    scoreBox.zPosition = 1;
    scoreBox.position = position;
    
    
    

    [scoreBox addChild:node];
    return scoreBox;
}

@end
