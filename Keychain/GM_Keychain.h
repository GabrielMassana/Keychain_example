//
//  GM_Keychain.h
//  Keychain
//
//  Created by Gabriel Massana on 14/05/2014.
//  Copyright (c) 2014 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GM_Keychain : NSObject

//Search in Keychain by identifier
+ (NSData *)searchKeychainCopyMatching:(NSString *)identifier;

//Add new item (password) to the Keychain with identifier
+ (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;

//Modify an item (password) in Keychain with identifier
+ (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;

//Delete item that match a search query with identifier
+ (void)deleteKeychainValue:(NSString *)identifier ;

@end
