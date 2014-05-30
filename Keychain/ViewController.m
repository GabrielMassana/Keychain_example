//
//  ViewController.m
//  Keychain
//
//  Created by Gabriel Massana on 14/05/2014.
//  Copyright (c) 2014 Gabriel Massana. All rights reserved.
//

#import "ViewController.h"
#import "GM_Keychain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"1 ");
    
    NSData *passwordData = [GM_Keychain stringInDataForKey:@"kUDID"];
    if (passwordData != nil)
    {
        NSString *UDID = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        NSLog(@"UDID = %@", UDID);
    }
    else
    {
        NSString *uuid = [[NSUUID UUID] UUIDString];
        NSLog(@"Save UDID = %@", uuid);
        
        BOOL saved = [GM_Keychain setString:uuid forKey:@"kUDID"];
        
        if (saved)
        {
            NSLog(@"No error while saving");
        }
        else
        {
            NSLog(@"Error while saving");
        }
    }
    NSLog(@"2 ");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
