//
//  InterfaceController.m
//  LiveMessage WatchKit Extension
//
//  Created by Etudiant on 06/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController() <WCSessionDelegate>

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if ([WCSession class] && [WCSession isSupported]) {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    // Configure interface objects here.
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSString* msg = [message objectForKey:@"message"];
    
    // Manière lisible de faire un AlertView
    WKAlertAction* a1 = [WKAlertAction actionWithTitle:@"CLOSE" style:WKAlertActionStyleCancel handler:^{
        NSLog(@"CANCEL");
    }];
    WKAlertAction* a2 = [WKAlertAction actionWithTitle:@"REPONDRE" style:WKAlertActionStyleDefault handler:^{
        // ENVOI LE MESSAGE
        if ([WCSession defaultSession].reachable) {
            [[WCSession defaultSession]sendMessage:@{@"messageFromWatch" : @"Hello From Watch"} replyHandler:nil errorHandler:nil];
        }
        NSLog(@"REPONDRE");
    }];
    
    NSArray* actions = @[a1, a2];
    
    // Manière compliqué de faire un AlertView
//    NSArray* actions = @[[WKAlertAction actionWithTitle:@"CLOSE" style:WKAlertActionStyleCancel handler:^{
//        NSLog(@"CANCEL");
//    }],
//    [WKAlertAction actionWithTitle:@"REPONDRE" style:WKAlertActionStyleDefault handler:^{
//        NSLog(@"REPONDRE");
//    }]];
    
    [self presentAlertControllerWithTitle:@"Message" message:msg preferredStyle:WKAlertControllerStyleActionSheet actions:actions];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



