//
//  Query.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/27/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GameOptions.h"

@interface Query : NSMutableArray{
    NSMutableArray *cards;
    sqlite3 * db;
    GameOptions *options;
    const char *sql;
}

@property(nonatomic) GameOptions *options;
@property(nonatomic) const char *sql;
@property(nonatomic) NSMutableArray *cards;

- (void) get_cards;
//+(NSMutableArray*) run:(NSObject*) options;

@end
