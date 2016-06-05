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

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = NO;
    skView.showsPhysics = YES;
    
    // Create and configure the Register/Login scene.
    GameScene *scene = [[GameScene alloc] initWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    scene.anchorPoint = CGPointMake(0, 0);
    
    NSLog(@"%f",skView.bounds.size.width);
    NSLog(@"%f",skView.bounds.size.height);
    // Present the scene.
    [skView presentScene:scene];
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
