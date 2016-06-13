//
//  GameScene.h
//  HooKed
//

//  Copyright (c) 2016 Kristie Syda. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Worm.h"
#import "PauseMenu.h"
#import "ScoreBox.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>
{
    SKNode*fish;
    SKSpriteNode *bg;
    SKSpriteNode *bg1;
    SKSpriteNode *bg2;
    SKSpriteNode *hook;
    Worm *worm;
    NSTimeInterval time;
    int level;
    PauseMenu *pause;
    SKNode *menu;
    SKSpriteNode *btn_pause;
    SKSpriteNode *fishBar;
    ScoreBox *scoreBox;
    SKLabelNode *scoreLbl;
    int score;
    NSString *playerId;
    SKSpriteNode *startBtn;
}
@end
