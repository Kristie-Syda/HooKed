//
//  Menu.m
//  HooKed
//
//  Created by Kristie Syda on 5/24/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Menu.h"
#import <Parse/Parse.h>
#import "GameScene.h"
#import "Register.h"
#import "Leaderboard.h"
#import "Profile.h"
#import "Achievements.h"
#import "Tutorial.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@implementation Menu

// Button Method:
//
// Makes button - Adds a Label & Position
//
-(SKSpriteNode *)makeBtn:(NSString*)title position:(CGPoint)position {

    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"btn_menu"];
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


// Setup Scene
- (instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        //Background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg_menu.png"];
        bg.size = CGSizeMake(self.size.width, self.size.height);
        bg.position = CGPointMake(self.size.width/2, self.size.height/2);
        bg.zPosition = -1;
        
        //Menu title label
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        titleLabel.text = @"Menu";
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        titleLabel.fontSize = 40;
        titleLabel.zPosition = 0;
        
        
        //LogOut
        SKSpriteNode *logOut = [SKSpriteNode spriteNodeWithImageNamed:@"btn_LogOut"];
        logOut.name = @"LogOut";
        
        //View Profile
        SKSpriteNode *viewProfile = [SKSpriteNode spriteNodeWithImageNamed:@"btn_viewProf"];
        viewProfile.name = @"Profile";
        
        if ( [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"] ) {
            titleLabel.position = CGPointMake(768/2 + 10, 1024 - 200);
            logOut.position = CGPointMake(768/4 - 20, 1024 - 200);
            viewProfile.position = CGPointMake(768/4 - 20, 1024 - 240);
        
        } else {
            titleLabel.position = CGPointMake(self.size.width/2 + 10, self.size.height - 100);
            logOut.position = CGPointMake(self.size.width/4 - 20,self.size.height - 80);
            viewProfile.position = CGPointMake(self.size.width/4 - 20, self.size.height - 120);
        }
        
        //Play Game Button
        SKSpriteNode *play = [self makeBtn:@"Play Game" position:CGPointMake(titleLabel.position.x, titleLabel.position.y - 50)];
        
        //Tutorial
        SKSpriteNode *tut = [self makeBtn:@"Game Guide" position:CGPointMake(play.position.x, play.position.y - 50)];
        
        //Achievements
        SKSpriteNode *ach = [self makeBtn:@"Achievements" position:CGPointMake(tut.position.x, tut.position.y - 50)];
        
        //Leaderboard
        SKSpriteNode *lead = [self makeBtn:@"Leaderboard" position:CGPointMake(ach.position.x, ach.position.y - 50)];
        

        
        [self addChild:titleLabel];
        [self addChild:play];
        [self addChild:tut];
        [self addChild:ach];
        [self addChild:lead];
        [self addChild:logOut];
        [self addChild:viewProfile];
        [self addChild:bg];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    if ([touched.name isEqualToString:@"Play Game"]){
        
        GameScene *scene = [GameScene sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
    
    }
    else if ([touched.name isEqualToString:@"Game Guide"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Tutorial *vc = [storyboard instantiateViewControllerWithIdentifier:@"Tutorial"];
        [self.view.window.rootViewController presentViewController:vc animated:true completion:nil];
    }
    else if ([touched.name isEqualToString:@"Achievements"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Achievements *vc = [storyboard instantiateViewControllerWithIdentifier:@"Achievements"];
        [self.view.window.rootViewController presentViewController:vc animated:true completion:nil];
    }
    else if ([touched.name isEqualToString:@"Leaderboard"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Leaderboard *vc = [storyboard instantiateViewControllerWithIdentifier:@"Leaderboard"];
        [self.view.window.rootViewController presentViewController:vc animated:true completion:nil];
    }
    else if ([touched.name isEqualToString:@"LogOut"]){
        [PFUser logOut];
        PFUser *currentUser = [PFUser currentUser];
        NSLog(@"%@ logged out",currentUser);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/permissions"
                                           parameters:nil
                                           HTTPMethod:@"DELETE"]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
                 NSLog(@"Revoking is successfull");
             else
                 NSLog(@"Failure revoking: %@", error);
         }];

        
        Register *scene = [Register sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
    }
    else if ([touched.name isEqualToString:@"Profile"]){
        Profile *scene = [Profile sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
    }
}


@end
