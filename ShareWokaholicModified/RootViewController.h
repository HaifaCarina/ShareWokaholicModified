//
//  RootViewController.h
//  ShareWokaholicModified
//
//  Created by Haifa Carina Baluyos on 11/5/12.
//  Copyright (c) 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface RootViewController : UIViewController <FBSessionDelegate, FBDialogDelegate,FBRequestDelegate> {
    Facebook *facebook;
}
@property (nonatomic, retain) Facebook *facebook;

@end
