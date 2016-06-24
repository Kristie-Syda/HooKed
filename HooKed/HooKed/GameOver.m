//
//  GameOver.m
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "GameOver.h"
#import "Menu.h"
#import "GameScene.h"
#import <Parse/Parse.h>

@implementation GameOver

#pragma mark - Facebook Button
// Facebook Sharebutton does not work on SKScene
-(void)didMoveToView:(SKView *)view{
    btn_share = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(self.size.width - 260, self.size.height - 210, 100, 35)];
    [btn_share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_share];
}
// required methods for facebook share button
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
}
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
}
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
}
- (void)share:(id)sender {
    [FBSDKShareDialog showFromViewController:self.view.window.rootViewController withContent:shareLink delegate:self];
}

#pragma mark - Setup Scene
// Setup Scene
- (id)initWithSize:(CGSize)size score:(int)scoreNum {
    
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
        title_user.position = CGPointMake(self.size.width/3, self.size.height - 180);
        title_user.zPosition = 0;
        title_user.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        
        //Score Title Label
        SKLabelNode *title_score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_score.text = @" Score:";
        title_score.fontColor = [SKColor blackColor];
        title_score.fontSize = 20;
        title_score.position = CGPointMake(self.size.width/3, self.size.height - 230);
        title_score.zPosition = 0;
        title_score.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        
        //Coins Title Label
        SKLabelNode *title_coins = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_coins.text = @" Coins Earned:";
        title_coins.fontColor = [SKColor blackColor];
        title_coins.fontSize = 20;
        title_coins.position = CGPointMake(self.size.width/3, self.size.height - 280);
        title_coins.zPosition = 0;
        title_coins.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        
        //Highscore Title Label
        SKLabelNode *title_high = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_high.text = @" Highscore:";
        title_high.fontColor = [SKColor blackColor];
        title_high.fontSize = 20;
        title_high.position = CGPointMake(self.size.width/3, self.size.height - 320);
        title_high.zPosition = 0;
        title_high.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        
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
        
        //Back button w/Label added
        SKSpriteNode *replay = [SKSpriteNode spriteNodeWithImageNamed:@"btn_back"];
        SKLabelNode *rLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
        rLabel.text = @"Replay";
        rLabel.name = rLabel.text;
        rLabel.fontColor = [SKColor whiteColor];
        rLabel.fontSize = 16;
        rLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        rLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [replay addChild:rLabel];
        [replay setPosition:CGPointMake(self.size.width - 210, self.size.height - 240)];
        replay.zPosition = 0;
        replay.name = rLabel.text;
        
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
                score = scoreNum;
                coins = [[object objectForKey:@"Coins"] intValue];
                newCoins = score/10;
                highScore = [[object objectForKey:@"HighScore"] intValue];
                userName = [object objectForKey:@"UserName"];
                
                shareLink = [[FBSDKShareLinkContent alloc] init];
                shareLink.contentURL = [NSURL URLWithString:@"https://developers.facebook.com/apps/250547675301707/"];
                shareLink.contentTitle = @"HooKed!";
                shareLink.contentDescription = [NSString stringWithFormat:@"%@ just earned a score of %i on HooKed!", [PFUser currentUser].username,score];
                btn_share.shareContent = shareLink;
                
                //Achievements
                if(score > 1000){
                    PFQuery *info = [PFQuery queryWithClassName:@"Achievements"];
                    [info whereKey:@"Player" equalTo:current];
                    
                    [info findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                        NSString *achieveId;
                        //Loop through player array
                        for(PFObject *player in objects){
                            achieveId = [player objectId];
                        }
                        
                        [info getObjectInBackgroundWithId:achieveId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
                            object[@"A1"] = [NSNumber numberWithBool:1];
                            if(score > 2000){
                                object[@"A2"] = [NSNumber numberWithBool:1];
                            }
                            if(score > 5000){
                                object[@"A3"] = [NSNumber numberWithBool:1];
                            }
                            [object saveInBackground];
                        }];
                    }];
                }
                
                //if score is greater than highscore than update score to highscore
                if(score > highScore){
                    NSLog(@"%i > %i",score,highScore);
                    object[@"HighScore"] = [NSNumber numberWithInt:score];
                    [object saveInBackground];
                    highScore = [[object objectForKey:@"HighScore"] intValue];
                }
                
                //Save new total of coins to parse
                object[@"Coins"] = [NSNumber numberWithInt:coins + newCoins];
                [object saveInBackground];
                
                //UserName label
                SKLabelNode *lbl_user = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                lbl_user.text = userName;
                lbl_user.fontColor = [SKColor blackColor];
                lbl_user.fontSize = 20;
                lbl_user.position = CGPointMake(self.size.width/3 - 20 + 40, self.size.height - 180);
                lbl_user.zPosition = 1;
                lbl_user.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;

                
                //Score label
                SKLabelNode *lbl_score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                lbl_score.text = [@(score) stringValue];
                lbl_score.fontColor = [SKColor blackColor];
                lbl_score.fontSize = 20;
                lbl_score.position = CGPointMake(self.size.width/3 - 20 + 40, self.size.height - 230);
                lbl_score.zPosition = 1;
                lbl_score.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
                
                //highscore label
                SKLabelNode *lbl_high = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                lbl_high.text = [@(highScore) stringValue];
                lbl_high.fontColor = [SKColor blackColor];
                lbl_high.fontSize = 20;
                lbl_high.position = CGPointMake(self.size.width/3 - 20 + 40, self.size.height - 320);
                lbl_high.zPosition = 1;
                lbl_high.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
                
                //coins label
                SKLabelNode *lbl_coins = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                lbl_coins.text = [@(newCoins) stringValue];
                lbl_coins.fontColor = [SKColor blackColor];
                lbl_coins.fontSize = 20;
                lbl_coins.position = CGPointMake(self.size.width/3 - 20 + 40, self.size.height - 280);
                lbl_coins.zPosition = 1;
                lbl_coins.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;

                [self addChild:lbl_user];
                [self addChild:lbl_score];
                [self addChild:lbl_high];
                [self addChild:lbl_coins];
            }];
        }];

        [self addChild:bg];
        [self addChild:titleLabel];
        [self addChild:title_user];
        [self addChild:title_score];
        [self addChild:title_coins];
        [self addChild:btnBack];
        [self addChild:title_high];
        [self addChild:replay];
    }
    
    return self;
}

#pragma mark - Touches
//Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Submit button
    if ([touched.name isEqualToString:@"Menu"]){
        [btn_share removeFromSuperview];
        Menu *scene = [Menu sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
    } else if ([touched.name isEqualToString:@"Replay"]){
        [btn_share removeFromSuperview];
        GameScene *scene = [GameScene sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
    }
}


@end
