//
//  Tutorial.h
//  HooKed
//
//  Created by Kristie Syda on 6/12/16.
//  Copyright © 2016 Kristie Syda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tutorial : UIViewController
{
    NSMutableArray *pages;
    IBOutlet UILabel *infoLabel;
    IBOutlet UIImageView *imgView;
    NSString *labelName;
    UIImage *imgName;
    int object;
}
@end
