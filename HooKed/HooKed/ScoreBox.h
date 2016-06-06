//
//  ScoreBox.h
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScoreBox : SKNode
{
    CGSize bar;
}

-(SKSpriteNode *)CreateBar:(CGPoint)position;
-(SKNode *)createScoreBox:(CGPoint)position;
@end
