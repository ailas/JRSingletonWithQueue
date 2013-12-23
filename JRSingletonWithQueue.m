//
//  JRSingletonWithQueue.m
//  JR
//
//  Created by Josef Rysanek on 28/10/13.
//  Copyright (c) 2013 josef.rysanek@gmail.com. All rights reserved.
//

#import "JRSingletonWithQueue.h"

// This Singleton Class is Thread Safe.

@implementation JRSingletonWithQueue

static JRSingletonWithQueue *sharedInstanceJRSingletonWithQueue = nil;
static dispatch_queue_t serialQueueJRSingletonWithQueue;
static id initializedJRSingletonWithQueue = nil;

+ (JRSingletonWithQueue *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstanceJRSingletonWithQueue = [[JRSingletonWithQueue alloc] init];
    });
    
    return sharedInstanceJRSingletonWithQueue;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // Create serial queue
        serialQueueJRSingletonWithQueue = dispatch_queue_create("cz.jr.ios.singletonWithQueue.serialQueue", NULL);
        
        if (sharedInstanceJRSingletonWithQueue == nil)
        {
            sharedInstanceJRSingletonWithQueue = [super allocWithZone:zone];
        }
    });
    
    return sharedInstanceJRSingletonWithQueue;
}

- (id)init
{
    dispatch_sync(serialQueueJRSingletonWithQueue, ^{
        
        if (initializedJRSingletonWithQueue == nil)
        {
            initializedJRSingletonWithQueue = [super init];
        }
        
        if (initializedJRSingletonWithQueue != nil)
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                
                // Init of singleton object goes here - just once after successful init from super class!
                
                // EXAMPLE
                someNumber = 0;
                // EXAMPLE
            });
        }
    });
    
    self = initializedJRSingletonWithQueue;
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


// EXAMPLE
#pragma mark - QUEUED ACTIONS (example)

- (int)someNumber
{
    return someNumber;
}

- (void)setSomeNumber :(int)number
{
    dispatch_sync(serialQueueJRSingletonWithQueue, ^{
        
        if (someNumber != number)
        {
            NSLog(@"%@: Setting number: %i", [self class], number);
            someNumber = number;
        }
    });
}
// EXAMPLE


@end


