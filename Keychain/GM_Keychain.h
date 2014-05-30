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
+ (NSData *)stringInDataForKey:(NSString *)identifier;

//Add new item (password) to the Keychain with identifier
+ (BOOL)setString:(NSString *)password forKey:(NSString *)identifier;

//Modify an item (password) in Keychain with identifier
+ (BOOL)updateString:(NSString *)password forKey:(NSString *)identifier;

//Delete item that match a search query with identifier
+ (void)deleteStringWithKey:(NSString *)identifier;

@end
