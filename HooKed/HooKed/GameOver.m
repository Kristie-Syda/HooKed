//
//  GameOver.m
//  HooKed
//
//  Created by Kristie Syda on 6/5/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver

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
        title_user.position = CGPointMake(self.size.width/3 - 20, self.size.height - 200);
        title_user.zPosition = 0;
        
        //Score Title Label
        SKLabelNode *title_score = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_score.text = @"Score:";
        title_score.fontColor = [SKColor blackColor];
        title_score.fontSize = 20;
        title_score.position = CGPointMake(self.size.width/3 - 20, self.size.height - 250);
        title_score.zPosition = 0;
        
        //Score Title Label
        SKLabelNode *title_coins = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        title_coins.text = @"Coins Earned:";
        title_coins.fontColor = [SKColor blackColor];
        title_coins.fontSize = 20;
        title_coins.position = CGPointMake(self.size.width/3 - 20, self.size.height - 300);
        title_coins.zPosition = 0;
        
        
        
        [self addChild:bg];
        [self addChild:titleLabel];
        [self addChild:title_user];
        [self addChild:title_score];
        [self addChild:title_coins];
       
    }
    
    return self;
}

@end
