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

@implementation GameScene

static const uint32_t cat_fish = 0x1 << 0;
static const uint32_t cat_hook = 0x1 << 1;
static const uint32_t cat_worm = 0x1 << 2;
static const uint32_t cat_world = 0x1 << 3;

#pragma mark - Game Methods
//Fish
-(SKSpriteNode *)CreateFish {
    NSLog(@"level == %i", level);
    NSString *atlasName;
    
    if (level == 0){
        atlasName = @"swim";
    }else if (level == 1){
        atlasName = @"swim1";
    }else if (level == 2){
        atlasName = @"swim2";
    } else if (level == 3){
        atlasName = @"swim";
    } else if (level == 4){
        atlasName = @"swim";
    } else if (level == 5){
        atlasName = @"swim";
    } else if (level == 6){
        atlasName = @"swim";
    } else if (level == 7){
        atlasName = @"swim";
    } else if (level == 8){
        atlasName = @"swim";
    }

    //Fish texture/Animation
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    NSArray * textureNames = [[atlas textureNames] sortedArrayUsingSelector: @selector(compare:)];
    NSMutableArray *swimTextures = [NSMutableArray new];
    for (NSString *name in textureNames) {
        [swimTextures addObject: [atlas textureNamed: name]];
    }
    SKAction *swimming = [SKAction animateWithTextures:swimTextures timePerFrame:0.2];
    
    //Fish Node
    fish = [SKNode node];
    SKSpriteNode *fishNode = [SKSpriteNode spriteNodeWithTexture:swimTextures[0]];
    //SKSpriteNode *fishNode = [SKSpriteNode spriteNodeWithImageNamed:@"swim1"];
    fish.position = CGPointMake(self.size.width/4, self.size.height/2);
    fish.name = @"fish";
    fish.zPosition = 0;
    fish.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fishNode.size];
    fish.physicsBody.dynamic = NO;
    fish.physicsBody.allowsRotation = NO;
    fish.physicsBody.categoryBitMask = cat_fish;
    fish.physicsBody.contactTestBitMask = cat_hook|cat_worm;
    [fishNode runAction:[SKAction repeatActionForever:swimming]];
    [fish addChild:fishNode];
    [self addChild:fish];
    return fishNode;
}
//Hooks
-(SKSpriteNode *)CreateHooks {
    
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
-(void)SpawnHooks {
    //Spawning Hooks
    SKAction *spawn = [SKAction performSelector:@selector(CreateHooks) onTarget:self];
    SKAction *wait = [SKAction waitForDuration:5];
    SKAction *spawnSeq = [SKAction sequence:@[spawn, wait]];
    SKAction *spawning = [SKAction repeatActionForever:spawnSeq];
    [self runAction:spawning];
}
//Worms
-(Worm *)CreateWorms{
    
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
-(void)SpawnWorms {
    //Spawning Worms
    SKAction *spawn = [SKAction performSelector:@selector(CreateWorms) onTarget:self];
    SKAction *wait = [SKAction waitForDuration:20];
    SKAction *spawnSeq = [SKAction sequence:@[spawn, wait]];
    SKAction *spawning = [SKAction repeatActionForever:spawnSeq];
    [self runAction:spawning];
}
-(void)CreateBackground {
    
    //Background
    bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg1"];
    bg.size = CGSizeMake(self.size.width, self.size.height);
    bg.position = CGPointMake(0, self.size.height/2);
    bg.zPosition = -1;
    [self addChild:bg];
    
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg2"];
    bg1.size = CGSizeMake(self.size.width, self.size.height);
    bg1.position = CGPointMake(bg.size.width - 1, self.size.height/2);
    bg1.zPosition = -1;
    [self addChild:bg1];
    
    bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg3"];
    bg2.size = CGSizeMake(self.size.width, self.size.height);
    bg2.position = CGPointMake(bg1.size.width - 1, self.size.height/2);
    bg2.zPosition = -1;
    [self addChild:bg2];
}

#pragma mark - Scene Setup
// Setup Scene
- (instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.contactTestBitMask = cat_world;
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(-0.6, 0.0);
        level = 0;
        
        [self CreateFish];
        [self CreateBackground];
        [self SpawnHooks];
        [self SpawnWorms];
        
       
        pause = [[PauseMenu alloc]init];
        btn_pause = [pause makePause:CGPointMake((self.size.width - btn_pause.size.width) - 30, (self.size.height - btn_pause.size.height) - 30)];
        [self addChild:btn_pause];
    }
    
    return self;
}

#pragma mark - Touches & Contacts
//Touches & Contacts
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    fish.physicsBody.dynamic = YES;
    fish.physicsBody.velocity = CGVectorMake(0, 0);
    
    if (level == 0){
        [fish.physicsBody applyImpulse:CGVectorMake(20, 0)];
    }else if (level == 1){
        [fish.physicsBody applyImpulse:CGVectorMake(25, 0)];
    }else if (level == 2){
        [fish.physicsBody applyImpulse:CGVectorMake(30, 0)];
    } else if (level == 3){
        [fish.physicsBody applyImpulse:CGVectorMake(35, 0)];
    } else if (level == 4){
        [fish.physicsBody applyImpulse:CGVectorMake(40, 0)];
    } else if (level == 5){
        [fish.physicsBody applyImpulse:CGVectorMake(45, 0)];
    } else if (level == 6){
        [fish.physicsBody applyImpulse:CGVectorMake(50, 0)];
    } else if (level == 7){
        [fish.physicsBody applyImpulse:CGVectorMake(55, 0)];
    } else if (level == 8){
        [fish.physicsBody applyImpulse:CGVectorMake(60, 0)];
    }
    
    if([touched.name isEqualToString:@"pause"]){
         self.paused = true;
        [btn_pause removeFromParent];
         menu = [pause createPauseMenu:CGPointMake(self.size.width/2, self.size.height/2)];
        [self addChild:menu];
        
    } else if([touched.name isEqualToString:@"Resume"]){
        self.paused = false;
        [menu removeFromParent];
        btn_pause = [pause makePause:CGPointMake((self.size.width - btn_pause.size.width), (self.size.height - btn_pause.size.height))];
        [self addChild:btn_pause];
    } else if([touched.name isEqualToString:@"Tutorial"]){
        NSLog(@"tutorial opens");
    } else if([touched.name isEqualToString:@"Quit"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"quitGame" object:self];
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
        NSLog(@"hook");
    } else if (theContact.categoryBitMask == cat_worm) {
        update = [(Worm *)theContact.node collision:fish];
        [fish removeFromParent];
        level = level + 1;
        [self CreateFish];
    }
}

#pragma mark - Update Method
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    //Background Movement
    if(fish.position.x > self.size.width/2){
        
        bg.position = CGPointMake(bg.position.x-3, bg.position.y);
        bg1.position = CGPointMake(bg1.position.x-3,bg1.position.y);
        bg2.position = CGPointMake(bg2.position.x-3, bg2.position.y);
        hook.position = CGPointMake(hook.position.x - 3, hook.position.y);
        worm.position = CGPointMake(worm.position.x-3,worm.position.y);
            if(bg.position.x < -bg.size.width){
                bg.position = CGPointMake(bg2.position.x + bg2.size.width, bg.position.y);
            }
            if(bg1.position.x < -bg1.size.width){
                bg1.position = CGPointMake(bg.position.x + bg.size.width, bg1.position.y);
            }
            if(bg2.position.x < -bg2.size.width){
                bg2.position = CGPointMake(bg1.position.x + bg1.size.width, bg2.position.y);
            }

    }
    
}

@end
