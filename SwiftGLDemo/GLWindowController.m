//
//  GLWindowController.m
//  SwiftGLDemo
//
//  Created by Scott Bennett on 2014-06-09.
//  Copyright (c) 2014 Scott Bennett. All rights reserved.
//

#import "GLWindowController.h"

@implementation GLWindowController

- (instancetype) initWithWindow:(NSWindow *)window {
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        fullscreenWindow = nil;
    }
    return self;
}

- (void) windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void) goFullscreen {
    // If app is already fullscreen...
    if (fullscreenWindow) {
        // ...don't do anything
        return;
    }
    
    // Allocate a new fullscreen window
    fullscreenWindow = [[GLFullscreenWindow alloc] init];
    
    // Resize the view to screensize
    NSRect viewRect = [fullscreenWindow frame];
    
    // Set the view to the size of the fullscreen window
    [view setFrameSize:viewRect.size];
    
    // Set the view in the fullscreen window
    [fullscreenWindow setContentView:view];
    
    standardWindow = [self window];
    
    // Hide non-fullscreen window so it doesn't show up when switching out
    // of this app (i.e. with CMD-TAB)
    [standardWindow orderOut:self];
    
    // Set controller to the fullscreen window so that all input will go to
    // this controller (self)
    [self setWindow:fullscreenWindow];
    
    // Show the window and make it the key window for input
    [fullscreenWindow makeKeyAndOrderFront:self];
}

- (void) goWindow {
    // If controller doesn't have a full screen window...
    if (fullscreenWindow == nil) {
        // ...app is already windowed so don't do anything
        return;
    }
    
    // Get the rectangle of the original window
    NSRect viewRect = [standardWindow frame];
    
    // Set the view rect to the new size
    [view setFrame:viewRect];
    
    // Set controller to the standard window so that all input will go to
    // this controller (self)
    [self setWindow:standardWindow];
    
    // Set the content of the orginal window to the view
    [[self window] setContentView:view];
    
    // Show the window and make it the key window for input
    [[self window] makeKeyAndOrderFront:self];
    
    // Ensure we set fullscreen Window to nil so our checks for
    // windowed vs. fullscreen mode elsewhere are correct
    fullscreenWindow = nil;
}

- (void) keyDown:(NSEvent *)event {
    unichar c = [[event charactersIgnoringModifiers] characterAtIndex:0];
    
    switch (c) {
            // Handle [ESC] key
        case 27:
            if (fullscreenWindow == nil) {
                exit(EXIT_SUCCESS);
            } else {
                [self goWindow];
            }
            return;
            
            // Have f key toggle fullscreen
        case 'f':
            if (fullscreenWindow == nil) {
                [self goFullscreen];
            } else {
                [self goWindow];
            }
            return;
    }
    
    // Allow other character to be handled (or not and beep)
    [super keyDown:event];
}

@end
