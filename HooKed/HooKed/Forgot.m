//
//  Forgot.m
//  HooKed
//
//  Created by Kristie Syda on 5/25/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Forgot.h"
#import <Parse/Parse.h>
#import "Register.h"

@implementation Forgot

// didMoveToView
//
// Had to add the textfields to didMoveToView
// Because they won't show up in the SKScene
//
-(void)didMoveToView:(SKView *)view {
    
    //Email
    email = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/4, self.size.height/3 + 90, 280, 30)];
    email.placeholder = @"Email";
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.backgroundColor = [UIColor whiteColor];
    email.textColor = [UIColor blackColor];
    
    [self.view addSubview:email];
}

// Have to remove textfields off screen manually
-(void)removeFields {
    [email removeFromSuperview];
}


// Setup Scene
- (instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        //Background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg_forgot.png"];
        bg.size = CGSizeMake(self.size.width, self.size.height);
        bg.position = CGPointMake(self.size.width/2, self.size.height/2);
        bg.zPosition = -1;
        
        //Submit button w/Label added
        SKSpriteNode *btnSubmit = [SKSpriteNode spriteNodeWithImageNamed:@"btn_register"];
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
        label.text = @"Submit";
        label.name = label.text;
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 16;
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        
        [btnSubmit addChild:label];
        [btnSubmit setPosition:CGPointMake(self.size.width/2, self.size.height/2 - 100)];
        btnSubmit.zPosition = 0;
        btnSubmit.name = label.text;
        
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
        [btnBack setPosition:CGPointMake(self.size.width/4, self.size.height - 100)];
        btnBack.zPosition = 0;
        btnBack.name = bLabel.text;
        
        //Title label
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        titleLabel.text = @"Password reset";
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        titleLabel.fontSize = 30;
        titleLabel.position = CGPointMake(self.size.width/2 + 10, self.size.height - 160);
        titleLabel.zPosition = 0;
        
        //Description label
        SKLabelNode *dLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
        dLabel.text = @"We will send you a reset link to your email.";
        dLabel.fontColor = [SKColor blackColor];
        dLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        dLabel.fontSize = 14;
        dLabel.position = CGPointMake(self.size.width/4 + 140, self.size.height - 200);
        dLabel.zPosition = 0;
        
        [self addChild:titleLabel];
        [self addChild:btnSubmit];
        [self addChild:bg];
        [self addChild:dLabel];
        [self addChild:btnBack];
    }
    
    return self;
}

//Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Submit button
    if ([touched.name isEqualToString:@"Submit"]){
        
        [PFUser requestPasswordResetForEmailInBackground:email.text];
        
        [self removeFields];
        Register *scene = [Register sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
        
    } else if ([touched.name isEqualToString:@"Back"]){
        
        [self removeFields];
        Register *scene = [Register sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
        
    }
}

@end
