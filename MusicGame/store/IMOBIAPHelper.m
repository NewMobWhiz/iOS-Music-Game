//
//  IMOBIAPHelper.m
//  IMOB
//

#import "IMOBIAPHelper.h"

@implementation IMOBIAPHelper

+ (IMOBIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static IMOBIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.musicWhiz.coin",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end