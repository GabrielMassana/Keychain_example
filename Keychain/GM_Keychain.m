//
//  GM_Keychain.m
//  Keychain
//
//  Created by Gabriel Massana on 14/05/2014.
//  Copyright (c) 2014 Gabriel Massana. All rights reserved.
//

#import "GM_Keychain.h"
#import <Security/Security.h>

//Unique string used to identify the keychain item:
static const NSString *serviceName          = @"com.company.something.unique.Keychain";
//static const NSString *accountAttributeKey  = @"kAccountAttributeKey";

@implementation GM_Keychain


+ (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier
{
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    
    //kSecAttrGeneric is what we will use to identify the keychain item
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    
    
    //NSData *encodedAccountAttributeKey = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    
    //kSecAttrAccount and kSecAttrService should be set to something unique for this keychain
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    
    return searchDictionary;
}


/**
 * Search in Keychain by identifier
 *
 *
 */
+ (NSData *)searchKeychainCopyMatching:(NSString *)identifier
{
    
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    NSData *result = nil;
    OSStatus status = noErr;
    
    status = SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, (void *)&result);
    
    return result;
}

/**
 *
 * Add new item (password) to the Keychain with identifier
 *
 */
+ (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier
{
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    
    NSLog(@"status = %d", (int)status);
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}
/**
 *
 * Modify an item (password) in Keychain with identifier
 *
 *
 */
+ (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier
{
    
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                    (__bridge CFDictionaryRef)updateDictionary);
    
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

/**
 *
 * Delete item that match a search query with identifier
 *
 */
+ (void)deleteKeychainValue:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
}

@end
