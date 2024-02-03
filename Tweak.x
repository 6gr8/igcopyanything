#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <substrate.h>
#import <Photos/Photos.h>
#import <MediaPlayer/MediaPlayer.h>
#import <SpringBoard/SpringBoard.h>
#import <substrate.h>
#import <UIKit/UIKit.h>
#import <spawn.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <objc/objc-runtime.h>



@interface IGCoreTextView : UIView

@property (nonatomic, assign, readonly) NSString *text;

@end



void alertm(NSString *message, NSString *title) {
    UIAlertView *conAlert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [conAlert show];
}




%hook UILabel


-(void)setText:(id)arg1{
    %orig;
    
    if ([self.superview isKindOfClass:NSClassFromString(@"IGStatButton")] || [self.superview isKindOfClass:NSClassFromString(@"IGTapButton")]){

        NSLog(@"Meow");
        self.userInteractionEnabled = NO;

    } else {

        self.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyText:)];
        longpress.minimumPressDuration = 0.5;
        [self addGestureRecognizer:longpress];
    }
}

%new

- (void)copyText:(UILongPressGestureRecognizer *)lp {
    if (lp.state == UIGestureRecognizerStateBegan) {

        NSString *message = self.text;
        
        UIPasteboard *copy = [UIPasteboard generalPasteboard];
        [copy setString:message];
        
        alertm(message, @"DONE MEOW");
    }
}

%end



%hook IGCoreTextView

- (void)didMoveToWindow {
    %orig;

        UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyText:)];
        longpress.minimumPressDuration = 0.5;
        [self addGestureRecognizer:longpress];
}


%new


- (void)copyText:(UILongPressGestureRecognizer *)lp {
    if (lp.state == UIGestureRecognizerStateBegan) {

        NSString *message = self.text;
        
        UIPasteboard *copy = [UIPasteboard generalPasteboard];
        [copy setString:message];
        
        alertm(message, @"DONE MEWO");
    }
}


%end