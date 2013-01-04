//
//  DominionVars.m
//  DominionDB
//
//  Created by Brandon Dusseau on 1/3/13.
//  Copyright (c) 2013 Malechite. All rights reserved.
//

#import "DominionVars.h"

@implementation DominionVars

static DominionVars *shared = NULL;

@synthesize base;
@synthesize intrigue;
@synthesize seaside;
@synthesize alchemy;
@synthesize prosperity;
@synthesize cornucopia;
@synthesize hinterlands;
@synthesize darkages;
@synthesize promo;

@synthesize query_type;

@synthesize kingdom_cards;
@synthesize loaded;

- (id)init
{
    if ( self = [super init] )
    {
        // init values
        // here you assign initial values to your variable.
        // in my case, I save all these values into NSUserDefaults as users preference.
        // so i do the necessary things to ensure that happens.
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        if ([def objectForKey:@"base"]==nil) {
            base = true;
            [def setBool:self.base forKey:@"base"];
            [def synchronize];
        } else { self.base = [def boolForKey:@"base"]; }
        
        if ([def objectForKey:@"intrigue"]==nil) {
            intrigue = false;
            [def setBool:self.base forKey:@"intrigue"];
            [def synchronize];
        } else { self.base = [def boolForKey:@"intrigue"]; }
        

        loaded = false;

    }
    return self;
    
}

+ (DominionVars *)sharedVars
{
    @synchronized(shared)
    {
        if ( !shared || shared == NULL )
        {
            // allocate the shared instance, because it hasn't been done yet
            shared = [[DominionVars alloc] init];
        }
        
        return shared;
    }
}

@end
