//
//  Register.m
//  HooKed
//
//  Created by Kristie Syda on 5/24/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Register.h"
#import <Parse/Parse.h>
#import "Menu.h"
#import "Account.h"
#import "Forgot.h"

@implementation Register


// didMoveToView
//
// Had to add the textfields to didMoveToView
// Because they won't show up in the SKScene
//
-(void)didMoveToView:(SKView *)view {
    
    //Username
    name = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/3, self.size.height/3 + 20, 220, 40)];
    name.placeholder = @"Username";
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    name.borderStyle = UITextBorderStyleRoundedRect;
    name.backgroundColor = [UIColor whiteColor];
    name.textColor = [UIColor blackColor];
    
    //Password
    password = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/3, self.size.height/3 + 70, 220, 40)];
    password.placeholder = @"Password";
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.backgroundColor = [UIColor whiteColor];
    password.textColor = [UIColor blackColor];
    
    [self.view addSubview:name];
    [self.view addSubview:password];
}

// Have to remove textfields off screen manually
-(void)removeFields {
    [name removeFromSuperview];
    [password removeFromSuperview];
}

// Setup Scene
- (instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        //Background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg_register.png"];
        bg.size = CGSizeMake(self.size.width, self.size.height);
        bg.position = CGPointMake(self.size.width/2, self.size.height/2);
        bg.zPosition = -1;
        
        //Login button w/Label added
        SKSpriteNode *btnLogin = [SKSpriteNode spriteNodeWithImageNamed:@"btn_register"];
                                 SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
                                 label.text = @"Login";
                                 label.name = label.text;
                                 label.fontColor = [SKColor whiteColor];
                                 label.fontSize = 20;
                                 label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
                                 label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
                                 
                                 [btnLogin addChild:label];
                                 [btnLogin setPosition:CGPointMake(self.size.width/2, self.size.height/2 - 80)];
                                 btnLogin.zPosition = 0;
                                 btnLogin.name = label.text;
        
        //Breadcrumbs at the bottom
        SKLabelNode *forgot = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
        forgot.text = @" Forgot Password?     |";
        forgot.name = @"forgot";
        forgot.position = CGPointMake(btnLogin.position.x - 60, btnLogin.position.y - 70);
        forgot.zPosition = 1;
        forgot.fontSize = 12;
        forgot.fontColor = [SKColor blackColor];
        
        SKLabelNode *create = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
        create.text = @" Create Account ";
        create.name = @"create";
        create.position = CGPointMake(btnLogin.position.x + 60, btnLogin.position.y - 70);
        create.zPosition = 1;
        create.fontSize = 12;
        create.fontColor = [SKColor blackColor];

        [self addChild:btnLogin];
        [self addChild:bg];
        [self addChild:forgot];
        [self addChild:create];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Login
    if ([touched.name isEqualToString:@"Login"]){
        [PFUser logInWithUsernameInBackground:name.text password:password.text block:^(PFUser *user, NSError *error) {
            if(user) {
                //set user
                [PFUser becomeInBackground:[user sessionToken] block:^(PFUser *currentUser, NSError *error) {
                    if(error){
                        
                        NSLog(@"Error with login");
                        
                    } else {
                        //login successful - Open menu
                        [self removeFields];
                        Menu *scene = [Menu sceneWithSize:self.size];
                        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
                        [self.view presentScene:scene transition:trans];
                    }
                }];
            } else {
                NSLog(@"Wrong username or Password");
            }
        }];
        
    //Forgot Password
    } else if ([touched.name isEqualToString:@"forgot"]){
     
        [self removeFields];
        Forgot *scene = [Forgot sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
        
    //Create Account
    } else if ([touched.name isEqualToString:@"create"]){
       
        //Open account scene
        [self removeFields];
        Account *scene = [Account sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];
    }
        
}

@end
