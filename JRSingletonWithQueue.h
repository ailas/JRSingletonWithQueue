//
//  JRSingletonWithQueue.h
//  JR
//
//  Created by Josef Rysanek on 28/10/13.
//  Copyright (c) 2013 josef.rysanek@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRSingletonWithQueue : NSObject
{
    // EXAMPLE
    int someNumber;
    // EXAMPLE
}

+ (id)sharedManager;

// EXAMPLE
- (int)someNumber;
- (void)setSomeNumber :(int)number;
// EXAMPLE

@end
