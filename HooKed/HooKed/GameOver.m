//
//  GameOver.m
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "GameOver.h"
#import "Menu.h"
#import <Parse/Parse.h>

@implementation GameOver

-(void)getInfo {
    PFUser *current = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    //Find player
    [query whereKey:@"Player" equalTo:current];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //Loop through player array
        for(PFObject *player in objects){
            playerId = [player objectId];
        }
        
        //Get info
        PFQuery *info = [PFQuery queryWithClassName:@"Score"];
        [info getObjectInBackgroundWithId:playerId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            score = [[object objectForKey:@"score"] intValue];
            highScore = [[object objectForKey:@"HighScore"] intValue];
            userName = [object objectForKey:@"UserName"];
        }];
        
    }];

    
    
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
        titleLabel.text = @"Game Over";
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        titleLabel.fontSize = 40;
        titleLabel.position = CGPointMake(self.size.width/2, self.size.height - 100);
        titleLabel.zPosition = 0;
        
        //Username Title Label
        SKLabelNode *title_user = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_user.text = @"Username:";
        title_user.fontColor = [SKColor blackColor];
        title_user.fontSize = 20;
        title_user.position = CGPointMake(self.size.width/3 - 20, self.size.height - 180);
        title_user.zPosition = 0;
        
        //Score Title Label
        SKLabelNode *title_score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_score.text = @"Score:";
        title_score.fontColor = [SKColor blackColor];
        title_score.fontSize = 20;
        title_score.position = CGPointMake(self.size.width/3 - 20, self.size.height - 230);
        title_score.zPosition = 0;
        
        //Coins Title Label
        SKLabelNode *title_coins = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_coins.text = @"Coins Earned:";
        title_coins.fontColor = [SKColor blackColor];
        title_coins.fontSize = 20;
        title_coins.position = CGPointMake(self.size.width/3 - 20, self.size.height - 280);
        title_coins.zPosition = 0;
        
        //Highscore Title Label
        SKLabelNode *title_high = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_high.text = @"Highschore:";
        title_high.fontColor = [SKColor blackColor];
        title_high.fontSize = 20;
        title_high.position = CGPointMake(self.size.width/3 - 20, self.size.height - 320);
        title_high.zPosition = 0;
        
        //Back button w/Label added
        SKSpriteNode *btnBack = [SKSpriteNode spriteNodeWithImageNamed:@"btn_back"];
        SKLabelNode *bLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
        bLabel.text = @"Menu";
        bLabel.name = bLabel.text;
        bLabel.fontColor = [SKColor whiteColor];
        bLabel.fontSize = 16;
        bLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        bLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [btnBack addChild:bLabel];
        [btnBack setPosition:CGPointMake(self.size.width/4 - 20, self.size.height - 90)];
        btnBack.zPosition = 0;
        btnBack.name = bLabel.text;
        
        PFUser *current = [PFUser currentUser];
        PFQuery *query = [PFQuery queryWithClassName:@"Score"];
        //Find player
        [query whereKey:@"Player" equalTo:current];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            //Loop through player array
            for(PFObject *player in objects){
                playerId = [player objectId];
            }
            
            //Get info
            PFQuery *info = [PFQuery queryWithClassName:@"Score"];
            [info getObjectInBackgroundWithId:playerId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
                score = [[object objectForKey:@"score"] intValue];
                
                //if score is greater than highscore than update score to highscore
                if(score > highScore){
                    object[@"HighScore"] = [NSNumber numberWithInt:score];
                    [object saveInBackground];
                }

                highScore = [[object objectForKey:@"HighScore"] intValue];
                userName = [object objectForKey:@"UserName"];
                
                //UserName label
                SKLabelNode *lbl_user = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                lbl_user.text = userName;
                lbl_user.fontColor = [SKColor blackColor];
                lbl_user.fontSize = 20;
                lbl_user.position = CGPointMake(self.size.width/3 - 40 + title_user.frame.size.width, self.size.height - 180);
                lbl_user.zPosition = 1;
                
                //Score label
                SKLabelNode *lbl_score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                lbl_score.text = [@(score) stringValue];
                lbl_score.fontColor = [SKColor blackColor];
                lbl_score.fontSize = 20;
                lbl_score.position = CGPointMake(self.size.width/3 - 20 + title_score.frame.size.width, self.size.height - 230);
                lbl_score.zPosition = 1;
                
                //highscore label
                SKLabelNode *lbl_high = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                lbl_high.text = [@(highScore) stringValue];
                lbl_high.fontColor = [SKColor blackColor];
                lbl_high.fontSize = 20;
                lbl_high.position = CGPointMake(self.size.width/3 - 20 + title_high.frame.size.width, self.size.height - 320);
                lbl_high.zPosition = 1;
                
                [self addChild:lbl_user];
                [self addChild:lbl_score];
                [self addChild:lbl_high];
                
            }];
            
        }];

        [self addChild:bg];
        [self addChild:titleLabel];
        [self addChild:title_user];
        [self addChild:title_score];
        [self addChild:title_coins];
        [self addChild:btnBack];
        [self addChild:title_high];
        
    }
    
    return self;
}

//Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Submit button
    if ([touched.name isEqualToString:@"Menu"]){
        
       
        Menu *scene = [Menu sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
        
    }
}


@end
