//
//  Profile.m
//  HooKed
//
//  Created by Kristie Syda on 6/9/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Profile.h"
#import "Menu.h"
#import <Parse/Parse.h>
#import "Shop.h"
#import "Closet.h"

@implementation Profile

-(void)grabData {
    
    //Grab data from parse
    PFUser *current = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query whereKey:@"Player" equalTo:current];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //Loop through player array
        for(PFObject *player in objects){
            playerId = [player objectId];
        }
        
        //Get info
        PFQuery *info = [PFQuery queryWithClassName:@"Score"];
        [info getObjectInBackgroundWithId:playerId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            score = [[object objectForKey:@"HighScore"] intValue];
            userName = [object objectForKey:@"UserName"];
            coins = [[object objectForKey:@"Coins"] intValue];
            
            //UserName label
            SKLabelNode *lbl_user = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
            lbl_user.text = userName;
            lbl_user.fontColor = [SKColor blackColor];
            lbl_user.fontSize = 20;
            lbl_user.position = CGPointMake(self.size.width/3 - 30 + title_user.frame.size.width, self.size.height - 180);
            lbl_user.zPosition = 1;
            
            //Score label
            SKLabelNode *lbl_score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
            lbl_score.text = [@(score) stringValue];
            lbl_score.fontColor = [SKColor blackColor];
            lbl_score.fontSize = 20;
            lbl_score.position = CGPointMake(self.size.width/3 - 40 + title_score.frame.size.width, self.size.height - 230);
            lbl_score.zPosition = 1;
            
            //Coins label
            lbl_coins = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
            lbl_coins.text = [@(coins) stringValue];
            lbl_coins.fontColor = [SKColor blackColor];
            lbl_coins.fontSize = 20;
            lbl_coins.position = CGPointMake(self.size.width/3 - 20 + title_coins.frame.size.width, self.size.height - 280);
            lbl_coins.zPosition = 1;
            
            [self addChild:lbl_coins];
            [self addChild:lbl_user];
            [self addChild:lbl_score];
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
        
        //Profile title label
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        titleLabel.text = @"Profile";
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        titleLabel.fontSize = 40;
        titleLabel.position = CGPointMake(self.size.width/2 - 20, self.size.height - 110);
        titleLabel.zPosition = 0;
        
        //Back button w/Label added
        SKSpriteNode *btnBack = [SKSpriteNode spriteNodeWithImageNamed:@"btn_back"];
        SKLabelNode *bLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
        bLabel.text = @"Back";
        bLabel.name = bLabel.text;
        bLabel.fontColor = [SKColor whiteColor];
        bLabel.fontSize = 16;
        bLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        bLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [btnBack addChild:bLabel];
        [btnBack setPosition:CGPointMake(self.size.width/4 - 20, self.size.height - 100)];
        btnBack.zPosition = 0;
        btnBack.name = bLabel.text;
        
        //Username Title Label
        title_user = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_user.text = @"Username:";
        title_user.fontColor = [SKColor blackColor];
        title_user.fontSize = 20;
        title_user.position = CGPointMake(self.size.width/3 - 20, self.size.height - 180);
        title_user.zPosition = 0;
        
        //Score Title Label
        title_score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_score.text = @"High Score:";
        title_score.fontColor = [SKColor blackColor];
        title_score.fontSize = 20;
        title_score.position = CGPointMake(self.size.width/3 - 20, self.size.height - 230);
        title_score.zPosition = 0;
        
        //Coins Title Label
        title_coins = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_coins.text = @"Bank:";
        title_coins.fontColor = [SKColor blackColor];
        title_coins.fontSize = 20;
        title_coins.position = CGPointMake(self.size.width/3 - 20, self.size.height - 280);
        title_coins.zPosition = 0;
        
        //Shop button w/Label added
        SKSpriteNode *btnShop = [SKSpriteNode spriteNodeWithImageNamed:@"btn_shop"];
        btnShop.position = CGPointMake(titleLabel.position.x + 145, self.size.height - 100);
        btnShop.name = @"shop";
        
        //Back button w/Label added
        SKSpriteNode *btnCloset = [SKSpriteNode spriteNodeWithImageNamed:@"btn_back"];
        SKLabelNode *cLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
        cLabel.text = @"Closet";
        cLabel.name = cLabel.text;
        cLabel.fontColor = [SKColor whiteColor];
        cLabel.fontSize = 16;
        cLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        cLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        [btnCloset addChild:cLabel];
        [btnCloset setPosition:CGPointMake(btnShop.position.x, self.size.height - 150)];
        btnCloset.zPosition = 0;
        btnCloset.name = cLabel.text;
        
        [self grabData];
    
        [self addChild:btnShop];
        [self addChild:title_user];
        [self addChild:title_score];
        [self addChild:title_coins];
        [self addChild:titleLabel];
        [self addChild:btnBack];
        [self addChild:btnCloset];
        [self addChild:bg];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [lbl_coins removeFromParent];
    [self grabData];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    if ([touched.name isEqualToString:@"Back"]){
        
        Menu *scene = [Menu sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
        
    } else if ([touched.name isEqualToString:@"shop"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Shop *vc = [storyboard instantiateViewControllerWithIdentifier:@"Shop"];
        [self.view.window.rootViewController presentViewController:vc animated:true completion:nil];
        
    } else if([touched.name isEqualToString:@"Closet"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Closet *vc = [storyboard instantiateViewControllerWithIdentifier:@"Closet"];
        [self.view.window.rootViewController presentViewController:vc animated:true completion:nil];
    }
}
@end
