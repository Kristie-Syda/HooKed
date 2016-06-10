//
//  GameViewController.m
//  HooKed
//
//  Created by Kristie Syda on 5/24/16.
//  Copyright (c) 2016 Kristie Syda. All rights reserved.
//

#import "GameViewController.h"
#import "Register.h"
#import "GameScene.h"
#import "Menu.h"
#import <Parse/Parse.h>
#import "ShopData.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = NO;
    skView.showsPhysics = YES;
    
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        Menu *scene = [[Menu alloc] initWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFit;
        scene.anchorPoint = CGPointMake(0, 0);
        /* Notifications */
        
        //Player wants to quit game
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitGame:) name:@"quitGame" object:nil];
        // Present the scene.
        [skView presentScene:scene];
        
        
    } else {
        // Create and configure the Register/Login scene.
        Register *scene = [[Register alloc] initWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFit;
        scene.anchorPoint = CGPointMake(0, 0);
      
        // Present the scene.
        [skView presentScene:scene];
    }
    
   
}

-(void)viewDidAppear:(BOOL)animated{
     /* Notifications */
    
    //Player wants to quit game
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitGame:) name:@"quitGame" object:nil];
}

//Notification Methods

//Quit Game
- (void)quitGame:(NSNotification*) notification {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:@"Are you sure you want to quit?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yes = [UIAlertAction actionWithTitle:@"YES"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       Menu *scene = [Menu sceneWithSize:skView.bounds.size];
                                                       SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
                                                       [skView presentScene:scene transition:trans];
                                                   }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"NO"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                }];

    [alert addAction:cancel];
    [alert addAction:yes];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
