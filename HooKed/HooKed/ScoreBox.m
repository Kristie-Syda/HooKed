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

-(SKLabelNode *)CreateLabel:(NSString *)text{
    
    SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    score.text = text;
    score.fontSize = 16;
    score.fontColor = [SKColor whiteColor];
    score.zPosition = 2;
    
    return score;
}

//Create Score Box
-(SKNode *)createScoreBox:(CGPoint)position {
    
    SKNode *scoreBox = [SKNode node];
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"scoreBox"];
    scoreBox.zPosition = 1;
    scoreBox.position = position;
    
    SKLabelNode *nextFish = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
    nextFish.text = @"Next Fish";
    nextFish.fontColor = [SKColor whiteColor];
    nextFish.fontSize = 12;
    nextFish.position = CGPointMake(-95, self.frame.size.height/2 - 2);
    
    
    SKLabelNode *scoreCount = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    scoreCount.text = @"Score:";
    scoreCount.fontSize = 16;
    scoreCount.fontColor = [SKColor whiteColor];
    scoreCount.position = CGPointMake(-90, self.frame.size.height/2 - 20);
    NSLog(@" label position.x = %f , label width = %f", scoreCount.position.x, scoreCount.frame.size.width);
    
    [node addChild:nextFish];
    [node addChild:scoreCount];
    
    [scoreBox addChild:node];
    return scoreBox;
}

@end
