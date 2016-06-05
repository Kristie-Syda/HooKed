//
//  PauseMenu.m
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "PauseMenu.h"

@implementation PauseMenu

// Button Method:
//
// Makes button - Adds a Label & Position
//
-(SKSpriteNode *)makeBtn:(NSString*)title position:(CGPoint)position {
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"btn_menu"];
    node.name = title;
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
    label.text = title;
    label.name = title;
    label.fontColor = [SKColor whiteColor];
    label.fontSize = 20;
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    
    [node addChild:label];
    [node setPosition:position];
     node.zPosition = 1;
     node.name = title;
    
     return node;
}


-(SKSpriteNode *)makePause:(CGPoint)position {
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"btn_pause"];
    node.name = @"pause";
    node.position = position;
    node.zPosition = 1;
   
    return node;
}

//Create Pause
-(SKNode *)createPauseMenu:(CGPoint)position {
    
    SKNode *pauseMenu = [SKNode node];
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"pauseMenu"];
    pauseMenu.position = position;
    pauseMenu.zPosition = 1;
    SKSpriteNode *resume = [self makeBtn:@"Resume" position:CGPointMake(self.frame.size.width/2, self.frame.size.height + 20)];
    resume.zPosition = 2;
    SKSpriteNode *tut = [self makeBtn:@"Tutorial" position:CGPointMake(self.frame.size.width/2, self.frame.size.height - 40)];
    tut.zPosition = 2;
    SKSpriteNode *quit = [self makeBtn:@"Quit" position:CGPointMake(self.frame.size.width/2, self.frame.size.height - 100)];
    quit.zPosition = 2;
   
    [pauseMenu addChild:quit];
    [pauseMenu addChild:tut];
    [pauseMenu addChild:resume];
    [pauseMenu addChild:node];
    return pauseMenu;
}

@end
