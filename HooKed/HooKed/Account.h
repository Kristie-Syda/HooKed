//
//  Account.h
//  HooKed
//
//  Created by Kristie Syda on 5/24/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface Account : SKScene 
{
    UITextField *first;
    UITextField *last;
    UITextField *email;
    UITextField *userName;
    UITextField *password;
}
@end
