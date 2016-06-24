//
//  GameScene.m
//  HooKed
//
//  Created by Kristie Syda on 5/24/16.
//  Copyright (c) 2016 Kristie Syda. All rights reserved.
//

#import "GameScene.h"
#import "Worm.h"
#import "PauseMenu.h"
#import "Menu.h"
#import "GameOver.h"
#import "ScoreBox.h"
#import <Parse/Parse.h>
#import "Tutorial.h"

@implementation GameScene

static const uint32_t cat_fish = 0x1 << 0;
static const uint32_t cat_hook = 0x1 << 1;
static const uint32_t cat_worm = 0x1 << 2;
static const uint32_t cat_world = 0x1 << 3;

#pragma mark - Game Methods
//Fish
-(void)CreateFish:(CGPoint)location {
    NSString *atlasName;
    
    if ((level == 0)|(level>17)){
        atlasName = @"swim";
    }else if (level == 1){
        atlasName = @"swim1";
    }else if (level == 2){
        atlasName = @"swim2";
    } else if (level == 3){
        atlasName = @"fish1_1";
    } else if (level == 4){
        atlasName = @"fish1_2";
    } else if (level == 5){
        atlasName = @"fish1_3";
    } else if (level == 6){
        atlasName = @"fish2_1";
    } else if (level == 7){
        atlasName = @"fish2_2";
    } else if (level == 8){
        atlasName = @"fish2_3";
    } else if (level == 9) {
        atlasName = @"fish3_1";
    } else if (level == 10){
        atlasName = @"fish3_2";
    } else if (level == 11){
        atlasName = @"fish3_3";
    } else if (level == 12){
        atlasName = @"fish4_1";
    } else if (level == 13){
        atlasName = @"fish4_2";
    } else if (level == 14){
        atlasName = @"fish4_3";
    } else if (level == 15){
        atlasName = @"fish5_1";
    } else if (level == 16) {
        atlasName = @"fish5_2";
    } else if (level == 17){
        atlasName = @"fish5_3";
    }

    //Fish texture/Animation
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    NSArray * textureNames = [[atlas textureNames] sortedArrayUsingSelector: @selector(compare:)];
    NSMutableArray *swimTextures = [NSMutableArray new];
    for (NSString *name in textureNames) {
        [swimTextures addObject: [atlas textureNamed: name]];
    }
    SKAction *swimming = [SKAction animateWithTextures:swimTextures timePerFrame:0.5];
    
    //Fish Node
    fish = [SKNode node];
    SKSpriteNode *fishNode = [SKSpriteNode spriteNodeWithTexture:swimTextures[0]];
    fish.position = location;
    fish.name = @"fish";
    fish.zPosition = 0;
    fish.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fishNode.size];
    fish.physicsBody.allowsRotation = NO;
    fish.physicsBody.categoryBitMask = cat_fish;
    fish.physicsBody.contactTestBitMask = cat_hook|cat_worm;
    [fishNode runAction:[SKAction repeatActionForever:swimming]];
    
    //see if player has an item
    PFUser *current = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    //Find player
    [query whereKey:@"Player" equalTo:current];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //Loop through player array
        for(PFObject *player in objects){
            playerId = [player objectId];
        }
        
        //Update info
        PFQuery *info = [PFQuery queryWithClassName:@"Score"];
        [info getObjectInBackgroundWithId:playerId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            NSString *itemName = [object objectForKey:@"ItemName"];
            NSString *fish2 = [NSString stringWithFormat:@"%@%@",itemName,@"2"];
            NSString *fish3 = [NSString stringWithFormat:@"%@%@",itemName,@"3"];
            NSString *fish4 = [NSString stringWithFormat:@"%@%@",itemName,@"4"];
            NSString *fish5 = [NSString stringWithFormat:@"%@%@",itemName,@"5"];
            NSString *fish6 = [NSString stringWithFormat:@"%@%@",itemName,@"6"];
            
            if(![itemName isEqualToString:@"NONE"]){
                if(level < 3){
                    NSLog(@"level = %i",level);
                    SKSpriteNode *itemNode = [SKSpriteNode spriteNodeWithImageNamed:itemName];
                    itemNode.size = CGSizeMake(fishNode.size.width, fishNode.size.height);
                    [fish addChild:itemNode];

                } else if((level > 2)&&(level < 6)){
                    NSLog(@"level = %i",level);
                    SKSpriteNode *itemNode = [SKSpriteNode spriteNodeWithImageNamed:fish2];
                    itemNode.size = CGSizeMake(fishNode.size.width, fishNode.size.height);
                    [fish addChild:itemNode];
                    
                } else if((level > 5) && (level < 9)){
                    NSLog(@"level = %i",level);
                    SKSpriteNode *itemNode = [SKSpriteNode spriteNodeWithImageNamed:fish3];
                    itemNode.size = CGSizeMake(fishNode.size.width, fishNode.size.height);
                    itemNode.position = CGPointMake(0, 5);
                    [fish addChild:itemNode];
                    
                } else if((level > 8) && (level < 12)){
                    NSLog(@"level = %i",level);
                    SKSpriteNode *itemNode = [SKSpriteNode spriteNodeWithImageNamed:fish4];
                    itemNode.size = CGSizeMake(fishNode.size.width, fishNode.size.height);
                    [fish addChild:itemNode];
                    
                } else if((level > 11) && (level < 15)){
                    NSLog(@"level = %i",level);
                    SKSpriteNode *itemNode = [SKSpriteNode spriteNodeWithImageNamed:fish6];
                    itemNode.size = CGSizeMake(fishNode.size.width, fishNode.size.height);
                    itemNode.position = CGPointMake(0, 5);
                    [fish addChild:itemNode];
                    
                } else if ((level > 14)&&(level < 18)){
                    NSLog(@"level = %i",level);
                    SKSpriteNode *itemNode = [SKSpriteNode spriteNodeWithImageNamed:fish5];
                    itemNode.size = CGSizeMake(fishNode.size.width, fishNode.size.height);
                    itemNode.position = CGPointMake(0, 10);
                    [fish addChild:itemNode];
                }
            }
        }];        
    }];

    [fish addChild:fishNode];
    [self addChild:fish];
}

//Hooks
-(SKSpriteNode *)CreateHooks {
    
    if(gameOver){
        return nil;
    } else {
        //hook speed changes with level
        if (level == 0){
            time = 5;
        }else if (level == 1){
            time = 4.5;
        }else if (level == 2){
            time = 4.0;
        } else if (level == 3){
            time = 3.5;
        } else if (level == 4){
            time = 3.0;
        } else if (level == 5){
            time = 2.5;
        } else if (level == 6){
            time = 2.0;
        } else if (level == 7){
            time = 1.5;
        } else if (level == 8){
            time = 1.0;
        } else if (level == 9){
            time = 0.8;
        }else if (level == 10){
            time = 0.7;
        }else if (level == 11){
            time = 0.6;
        } else if (level == 12){
            time = 0.5;
        } else if (level == 13){
            time = 1.0;
        } else if (level == 14){
            time = 0.9;
        } else if (level == 15){
            time = 0.8;
        } else if (level == 16){
            time = 0.7;
        } else if (level == 17){
            time = 0.5;
        }
        
        
        //Random number generator with width size
        int rand = arc4random()%(int)self.size.width;
        
        //Hook physics
        hook = [SKSpriteNode node];
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"hook"];
        node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
        node.physicsBody.dynamic = NO;
        node.zPosition = 0;
        node.position = CGPointMake(rand, 667);
        node.physicsBody.categoryBitMask = cat_hook;
        node.physicsBody.contactTestBitMask = cat_fish;
        node.physicsBody.collisionBitMask = cat_fish;
        
        //Hook Movement Up & Down
        SKAction *hookDown = [SKAction moveToY:self.size.height - 180 duration:time];
        SKAction *hookUp = [SKAction moveToY:667 duration:time];
        SKAction *hookMovement = [SKAction sequence:@[hookDown,hookUp,[SKAction removeFromParent]]];
        [node runAction:hookMovement];
        [hook addChild:node];
        [self addChild:hook];
        return hook;
    }
}
-(void)SpawnHooks {
    //Spawning Hooks
    SKAction *spawn = [SKAction performSelector:@selector(CreateHooks) onTarget:self];
    SKAction *wait = [SKAction waitForDuration:5];
    SKAction *spawnSeq = [SKAction sequence:@[spawn, wait]];
    SKAction *spawningH = [SKAction repeatActionForever:spawnSeq];
    [self runAction:spawningH];
}

//Worms
-(Worm *)CreateWorms{
    
    if(gameOver){
        return nil;
    } else {
        //Worm Animation
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"worm"];
        NSArray * textureNames = [[atlas textureNames] sortedArrayUsingSelector: @selector(compare:)];
        NSMutableArray *wormTextures = [NSMutableArray new];
        for (NSString *name in textureNames) {
            [wormTextures addObject: [atlas textureNamed: name]];
        }
        SKAction *wormMovement = [SKAction animateWithTextures:wormTextures timePerFrame:0.2];
        //Random number generator with width size
        int rand = arc4random()%(int)self.size.width;
        //Worm physics
        worm = [Worm node];
        SKSpriteNode *wormNode = [SKSpriteNode spriteNodeWithTexture:wormTextures[0]];
        [wormNode runAction:[SKAction repeatActionForever:wormMovement]];
        worm.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wormNode.size];
        worm.physicsBody.dynamic = NO;
        worm.zPosition = 0;
        worm.position = CGPointMake(rand, self.size.height/2);
        worm.physicsBody.categoryBitMask = cat_worm;
        worm.physicsBody.contactTestBitMask = cat_fish;
        [worm addChild:wormNode];
        [self addChild:worm];
        return worm;
    }
}
-(void)SpawnWorms {
    //Spawning Worms
    SKAction *spawn = [SKAction performSelector:@selector(CreateWorms) onTarget:self];
    SKAction *wait = [SKAction waitForDuration:20];
    SKAction *spawnSeq = [SKAction sequence:@[spawn, wait]];
    SKAction *spawning = [SKAction repeatActionForever:spawnSeq];
    [self runAction:spawning];
}

//Background
-(void)CreateBackground {
    
    //Background
    bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg1"];
    bg.size = CGSizeMake(self.size.width, self.size.height);
    bg.position = CGPointMake(0, self.size.height/2);
    bg.zPosition = -1;
    [self addChild:bg];
    
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg2"];
    bg1.size = CGSizeMake(self.size.width, self.size.height);
    bg1.position = CGPointMake(bg.size.width, self.size.height/2);
    bg1.zPosition = -1;
    [self addChild:bg1];
    
    bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg3"];
    bg2.size = CGSizeMake(self.size.width, self.size.height);
    bg2.position = CGPointMake(bg1.size.width, self.size.height/2);
    bg2.zPosition = -1;
    [self addChild:bg2];
}

//Score Box
-(void)CreateScoreBox {
    scoreBox = [[ScoreBox alloc]init];
    SKNode *box = [scoreBox createScoreBox:CGPointMake(self.size.width/3 - 90, self.size.height - 45)];
    fishBar = [scoreBox CreateBar:CGPointMake(20,self.frame.size.height - 32)];
    scoreLbl = [scoreBox CreateLabel:@"0"];
    scoreLbl.position = CGPointMake(self.frame.size.width/3 - 130, self.size.height - 66);
    [self addChild:scoreLbl];
    [self addChild:fishBar];
    [self addChild:box];
}
-(void)changeProgress:(int)levelNum {
    if((level == 0)|(level>17)){
        level=0;
        fishBar.size = CGSizeMake(0, 10);}
    else if(levelNum == 1){
        fishBar.size = CGSizeMake(250/3, 10);}
    else if(levelNum == 2) {
        fishBar.size = CGSizeMake(250/2 + 30, 10);}
    else if(levelNum == 3){
        fishBar.size = CGSizeMake(0,10);}
    else if(levelNum == 4) {
        fishBar.size = CGSizeMake(250/3,10);}
    else if(levelNum == 5) {
        fishBar.size = CGSizeMake(250/2 + 30, 10);}
    else if(levelNum == 6) {
        fishBar.size = CGSizeMake(0, 10);}
    else if(levelNum == 7){
        fishBar.size = CGSizeMake(250/3,10);}
    else if(levelNum == 8) {
        fishBar.size = CGSizeMake(250/2 + 30,10);}
    else if(levelNum == 9) {
        fishBar.size = CGSizeMake(0, 10);}
    else if(levelNum == 10) {
        fishBar.size = CGSizeMake(250/3, 10);}
    else if(levelNum == 11){
        fishBar.size = CGSizeMake(250/2 + 30,10);}
    else if(levelNum == 12) {
        fishBar.size = CGSizeMake(0,10);}
    else if(levelNum == 13) {
        fishBar.size = CGSizeMake(250/3, 10);}
    else if(levelNum == 14) {
        fishBar.size = CGSizeMake(250/2 + 30, 10);}
    else if(levelNum == 15){
        fishBar.size = CGSizeMake(0,10);}
    else if(levelNum == 16) {
        fishBar.size = CGSizeMake(250/3,10);}
    else if(levelNum == 17) {
        fishBar.size = CGSizeMake(250/2 + 30, 10);}
}

//start button
-(SKSpriteNode *)createStart {
    //Back button w/Label added
    SKSpriteNode *btnStart = [SKSpriteNode spriteNodeWithImageNamed:@"btn_back"];
    SKLabelNode *bLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
    bLabel.text = @"Start";
    bLabel.name = bLabel.text;
    bLabel.fontColor = [SKColor whiteColor];
    bLabel.fontSize = 16;
    bLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    bLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    [btnStart addChild:bLabel];
    [btnStart setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    btnStart.zPosition = 1;
    btnStart.name = bLabel.text;
    return btnStart;
}
//Game Over
-(void)GameOver {
    [musicPlayer stop];
    [self runAction:over];
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE"];
    label.text = @"Game Over";
    label.fontSize = 40;
    label.fontColor = [SKColor blackColor];
    label.position = CGPointMake(0, 0);
    label.zPosition = 3;
    fish.physicsBody.dynamic = false;
    [fish removeFromParent];
    [hook removeFromParent];
    [worm removeFromParent];
    
    SKAction *move = [SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.4];
    [label runAction:move];
    
    [self addChild:label];
}
//Music button
-(void)music {
    
    SKSpriteNode *node;
    if(musicOn){
        node = [SKSpriteNode spriteNodeWithImageNamed:@"btn_music"];
    } else {
        node = [SKSpriteNode spriteNodeWithImageNamed:@"music2"];
    }
    
    node.name = @"music";
    node.position = CGPointMake((self.size.width - 80), (self.size.height - 30));
    node.zPosition = 1;
    [self addChild:node];
}

#pragma mark - Scene Setup
// Setup Scene
- (instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.contactTestBitMask = cat_world;
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(-0.6, 0.0);
        gameOver = false;
        musicOn = true;
        gameStarted = false;
        gamePaused = false;
        level = 0;
        score = 0;
        
        [self CreateFish:CGPointMake(self.size.width/4, self.size.height/2)];
        [self CreateBackground];
        [self CreateScoreBox];
        startBtn = [self createStart];
        [self addChild:startBtn];
        fish.physicsBody.dynamic = NO;
        
        pause = [[PauseMenu alloc]init];
        btn_pause = [pause makePause:CGPointMake((self.size.width - btn_pause.size.width) - 30, (self.size.height - btn_pause.size.height) - 30)];
        [self addChild:btn_pause];
        [self music];
     
        //Music/SFX
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Pelican" ofType:@"caf"]];
        musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        over = [SKAction playSoundFileNamed:@"over.caf" waitForCompletion:NO];
        eating = [SKAction playSoundFileNamed:@"eating.caf" waitForCompletion:NO];
    }
    return self;
}

#pragma mark - Touches & Contacts
//Touches & Contacts
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    if(gameOver == false) {
        fish.physicsBody.velocity = CGVectorMake(0, 0);
    
        //Fish gets faster the higher the level
        if ((level == 0)|(level>17)){
            [fish.physicsBody applyImpulse:CGVectorMake(20, 0)];}
        else if (level == 1){
            [fish.physicsBody applyImpulse:CGVectorMake(25, 0)];}
        else if (level == 2){
            [fish.physicsBody applyImpulse:CGVectorMake(45, 0)];}
        else if (level == 3){
            [fish.physicsBody applyImpulse:CGVectorMake(30, 0)];}
        else if (level == 4){
            [fish.physicsBody applyImpulse:CGVectorMake(35, 0)];}
        else if (level == 5){
            [fish.physicsBody applyImpulse:CGVectorMake(45, 0)];
        }
        else if (level == 6){
            [fish.physicsBody applyImpulse:CGVectorMake(50, 0)];
        }
        else if (level == 7){
            [fish.physicsBody applyImpulse:CGVectorMake(55, 0)];}
        else if (level == 8){
            [fish.physicsBody applyImpulse:CGVectorMake(60, 0)];
        }
        else if (level == 9){
            [fish.physicsBody applyImpulse:CGVectorMake(65, 0)];
        }
        else if (level == 10){
            [fish.physicsBody applyImpulse:CGVectorMake(70, 0)];
        }
        else if (level == 11){
            [fish.physicsBody applyImpulse:CGVectorMake(75, 0)];
        }
        else if (level == 12){
            [fish.physicsBody applyImpulse:CGVectorMake(80, 0)];
        }
        else if (level == 13){
            [fish.physicsBody applyImpulse:CGVectorMake(85, 0)];
        }
        else if (level == 14){
            [fish.physicsBody applyImpulse:CGVectorMake(90, 0)];
        }
        else if (level == 15){
            [fish.physicsBody applyImpulse:CGVectorMake(95, 0)];
        }
        else if (level == 16){
            [fish.physicsBody applyImpulse:CGVectorMake(100, 0)];
        }
        else if (level == 17){
            [fish.physicsBody applyImpulse:CGVectorMake(105, 0)];
        }

        
        if([touched.name isEqualToString:@"pause"]){
            self.paused = true;
            gamePaused = true;
            [btn_pause removeFromParent];
            menu = [pause createPauseMenu:CGPointMake(self.size.width/2, self.size.height/2)];
            if((musicOn)&&(gameStarted)){
                [musicPlayer pause];
            }
            [self addChild:menu];
        
        } else if([touched.name isEqualToString:@"Resume"]){
            self.paused = false;
            gamePaused = false;
            [menu removeFromParent];
            btn_pause = [pause makePause:CGPointMake(((self.size.width - btn_pause.size.width) + 6), ((self.size.height - btn_pause.size.height) + 6))];
            [self addChild:btn_pause];
            
            if((musicOn)&&(gameStarted)){
                [musicPlayer play];
            }
        
        } else if([touched.name isEqualToString:@"Game Guide"]){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            Tutorial *vc = [storyboard instantiateViewControllerWithIdentifier:@"Tutorial"];
            [self.view.window.rootViewController presentViewController:vc animated:true completion:nil];
            
        } else if([touched.name isEqualToString:@"Quit"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"quitGame" object:self];
            
        } else if ([touched.name isEqualToString:@"Start"]){
            [musicPlayer play];
            [self SpawnHooks];
            [self SpawnWorms];
            [startBtn removeFromParent];
            fish.physicsBody.dynamic = YES;
            gameStarted = true;
        } else if([touched.name isEqualToString:@"music"]){
            if((gameStarted)&&(!gamePaused)){
                if(musicOn){
                    musicOn = false;
                    [self music];
                    [musicPlayer stop];
                } else {
                    musicOn = true;
                    [self music];
                    [musicPlayer play];
                }
            }
        }
    } else if(gameOver) {
        //Game over leave scene
         GameOver *scene = [[GameOver alloc]initWithSize:self.size score:score];
         SKTransition *trans = [SKTransition doorsOpenVerticalWithDuration:2];
         [self.view presentScene:scene transition:trans];
        gameOver = false;
    }
}
-(void)didBeginContact:(SKPhysicsContact *)contact {
    
    BOOL update = NO;
    SKPhysicsBody *theContact;
    
    //To figure out what contact is what
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        theContact = contact.bodyB;
    } else {
        theContact = contact.bodyA;
    }
    
    if(theContact.categoryBitMask == cat_hook){
        gameOver = true;
        [self GameOver];
        
    } else if (theContact.categoryBitMask == cat_worm) {
        [self runAction:eating];
        [fish removeFromParent];
        level = level + 1;
        [self CreateFish:theContact.node.position];
        update = [(Worm *)theContact.node collision:fish];
        [self changeProgress:level];
        score = score + 50;
        scoreLbl.text = [@(score)stringValue];
    }
}

#pragma mark - Update Method
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    //Background Movement
    if(fish.position.x > self.size.width/2){
        score = score + 1;
        scoreLbl.text = [@(score)stringValue];
        
        bg.position = CGPointMake(bg.position.x-3, bg.position.y);
        bg1.position = CGPointMake(bg1.position.x-3,bg1.position.y);
        bg2.position = CGPointMake(bg2.position.x-3, bg2.position.y);
        hook.position = CGPointMake(hook.position.x - 3, hook.position.y);
        worm.position = CGPointMake(worm.position.x-3,worm.position.y);
    }
    if(bg.position.x < -bg.size.width/2){
        bg.position = CGPointMake(bg2.position.x + bg2.size.width, bg.position.y);
    }
    if(bg1.position.x < -bg1.size.width/2){
        bg1.position = CGPointMake(bg.position.x + bg.size.width, bg1.position.y);
    }
    if(bg2.position.x < -bg2.size.width/2){
        bg2.position = CGPointMake(bg1.position.x + bg1.size.width, bg2.position.y);
    }
}

@end
