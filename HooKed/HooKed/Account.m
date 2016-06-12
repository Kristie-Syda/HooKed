//
//  Account.m
//  HooKed
//
//  Created by Kristie Syda on 5/24/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import "Account.h"
#import <Parse/Parse.h>
#import "Menu.h"
#import "Register.h"

@implementation Account

// didMoveToView
//
// Had to add the textfields to didMoveToView
// Because they won't show up in the SKScene
//
-(void)didMoveToView:(SKView *)view {
    
    //First Name
    first = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/4 - 50, self.size.height/3 + 15, 160, 30)];
    first.placeholder = @"First Name";
    first.clearButtonMode = UITextFieldViewModeWhileEditing;
    first.borderStyle = UITextBorderStyleRoundedRect;
    first.backgroundColor = [UIColor whiteColor];
    first.textColor = [UIColor blackColor];
    
    //Last Name
    last = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/4 + 130, self.size.height/3 + 15, 180, 30)];
    last.placeholder = @"Last Name";
    last.clearButtonMode = UITextFieldViewModeWhileEditing;
    last.borderStyle = UITextBorderStyleRoundedRect;
    last.backgroundColor = [UIColor whiteColor];
    last.textColor = [UIColor blackColor];
    
    //Email
    email = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/4 - 50, self.size.height/3 + 55, 210, 30)];
    email.placeholder = @"Email";
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.backgroundColor = [UIColor whiteColor];
    email.textColor = [UIColor blackColor];
    
    //UserName
    userName = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/4 - 50, self.size.height/3 + 95, 210, 30)];
    userName.placeholder = @"Username";
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.backgroundColor = [UIColor whiteColor];
    userName.textColor = [UIColor blackColor];
    
    
    //Password
    password = [[UITextField alloc]initWithFrame:CGRectMake(self.size.width/4 - 50, self.size.height/3 + 135, 210, 30)];
    password.placeholder = @"Password";
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.backgroundColor = [UIColor whiteColor];
    password.textColor = [UIColor blackColor];
    
    
    
    [self.view addSubview:first];
    [self.view addSubview:last];
    [self.view addSubview:userName];
    [self.view addSubview:password];
    [self.view addSubview:email];
}

// Have to remove textfields off screen manually
-(void)removeFields {
    [first removeFromSuperview];
    [last removeFromSuperview];
    [userName removeFromSuperview];
    [email removeFromSuperview];
    [password removeFromSuperview];
}

//Create Account Method
-(void)createAccount {
    
    PFUser *User = [PFUser user];
    User[@"First"] = first.text;
    User[@"Last"] = last.text;
    User.username = userName.text;
    User.password = password.text;
    User.email = email.text;
    
    [User signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error){
          //Creating User
            PFObject *userData = [PFObject objectWithClassName:@"Score"];
            [userData setObject:[PFUser currentUser] forKey:@"Player"];
            PFUser *user = [PFUser currentUser];
            
             [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *point, NSError *err){
                 //fake location -- debugging purposes
                 //PFGeoPoint *fake = [PFGeoPoint geoPointWithLatitude:5 longitude:5];
                 PFGeoPoint *real = point;
                 
                 //Set up score properties
                 PFObject *info = [PFObject objectWithClassName:@"Score"];
                 info[@"score"] = [NSNumber numberWithInt:0];
                 info[@"Location"] = real;
                 info[@"UserName"] = [user username];
                 info[@"Player"] = user;
                 info[@"HighScore"] = [NSNumber numberWithInt:0];
                 info[@"Coins"] = [NSNumber numberWithInt:0];
                 info[@"ItemName"] = @"NONE";
                 [info saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                 }];
                 
                 //Set up achievement properties
                 PFObject *data = [PFObject objectWithClassName:@"Achievements"];
                 data[@"Player"] = user;
                 data[@"A1"] = [NSNumber numberWithBool:0];
                 data[@"A2"] = [NSNumber numberWithBool:0];
                 data[@"A3"] = [NSNumber numberWithBool:0];
                 [data saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                 }];
                 
                 //OPEN Menu Scene
                 [self removeFields];
                 Menu *scene = [Menu sceneWithSize:self.size];
                 SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
                 [self.view presentScene:scene transition:trans];
             }];
        } else {
            NSLog(@"Something went wrong while creating user");
        }
    }];
    
}

// Setup Scene
- (instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        //Background
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg_account.png"];
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
        [btnSubmit setPosition:CGPointMake(self.size.width/2, self.size.height/2 - 130)];
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
        [btnBack setPosition:CGPointMake(self.size.width/4, self.size.height - 90)];
        btnBack.zPosition = 0;
        btnBack.name = bLabel.text;

        
        //Title label
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        titleLabel.text = @"Create Account";
        titleLabel.fontColor = [SKColor blackColor];
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        titleLabel.fontSize = 30;
        titleLabel.position = CGPointMake(self.size.width/2 + 10, self.size.height - 100);
        titleLabel.zPosition = 0;
        
        [self addChild:titleLabel];
        [self addChild:btnSubmit];
        [self addChild:bg];
        [self addChild:btnBack];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Submit button
    if ([touched.name isEqualToString:@"Submit"]){
        [self createAccount];
        
    } else if ([touched.name isEqualToString:@"Back"]){
        
        [self removeFields];
        Register *scene = [Register sceneWithSize:self.size];
        SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
        [self.view presentScene:scene transition:trans];

    }
}


@end
