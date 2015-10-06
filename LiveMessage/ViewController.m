//
//  ViewController.m
//  LiveMessage
//
//  Created by Etudiant on 06/10/2015.
//  Copyright © 2015 Etudiant. All rights reserved.
//

#import "ViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController () <WCSessionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([WCSession class] && [WCSession isSupported]) {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onTouchSendMessage:(id)sender {
    if ([WCSession defaultSession].reachable) {
        [[WCSession defaultSession]sendMessage:@{@"messageFromIphone" : @"Hello From iPhone"} replyHandler:nil errorHandler:nil];
    }
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSString* msg = [message objectForKey:@"messageFromWatch"];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //AlertView
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Message" message:msg preferredStyle:UIAlertActionStyleDefault];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"CLOSE" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alertController animated:YES completion:nil];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
