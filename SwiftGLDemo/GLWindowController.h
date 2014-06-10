//
//  GLWindowController.h
//  SwiftGLDemo
//
//  Created by Scott Bennett on 2014-06-09.
//  Copyright (c) 2014 Scott Bennett. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GLView.h"
#import "GLFullscreenWindow.h"

@interface GLWindowController : NSWindowController {
    // IBOutlet must be used so that, in Inteface Builder,
    // we can connect the view in the NIB to windowedView
    IBOutlet GLView *view;
    
    // Fullscreen window
    GLFullscreenWindow *fullscreenWindow;
    
    // Non-Fullscreen window (also the initial window)
    NSWindow *standardWindow;
}

@end
