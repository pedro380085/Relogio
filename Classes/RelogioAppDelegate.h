//
//  RelogioAppDelegate.h
//  Relogio
//
//  Created by Pedro on 07/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RelogioViewController;

@interface RelogioAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RelogioViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RelogioViewController *viewController;

@end

