//
//  Query.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/27/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "Query.h"
#import "Card.h"
#import "DominionVars.h"

@implementation Query

@synthesize cards;
@synthesize sql;

- (id)init
{
    self = [super init];
    if (self) {
        //do init
    }
    return self;
}

- (void) create_query {
    DominionVars *dominion = [DominionVars sharedVars];
    
    NSLog(@"Query Type: %@", dominion.query_type);
    
    if(dominion.query_type == @"list") {
        sql = "SELECT * FROM kingdom_cards";
    } else if(dominion.query_type == @"custom" || dominion.query_type == @"replace"){
        //this is where i will build a query statement based on an object of options passed
        
        NSString *query = @"SELECT * FROM kingdom_cards WHERE id ";
        NSMutableString *sqlStatement = [NSMutableString stringWithString:query];
        
        
        if(dominion.query_type == @"replace") {
            [sqlStatement appendString:@"NOT IN ("];
            for(int i = 0; i < dominion.kingdom_cards.count; i++) {
                Card *card = dominion.kingdom_cards[i];
                [sqlStatement appendString:[NSString stringWithFormat:@"%d, ", card.id]];
                card = nil;
            }
            [sqlStatement deleteCharactersInRange:NSMakeRange([sqlStatement length]-2, 1)];
            [sqlStatement appendString:@") "];
        } else {
            [sqlStatement appendString:@"IS NOT NULL "];
        }
        [sqlStatement appendString:@"AND expansion_set IN ("];
        if (dominion.base)        { [sqlStatement appendString:@"'Basic', "]; }
        if (dominion.intrigue)    { [sqlStatement appendString:@"'Intrigue', "]; }
        if (dominion.seaside)     { [sqlStatement appendString:@"'Seaside', "]; }
        if (dominion.alchemy)     { [sqlStatement appendString:@"'Alchemy', "]; }
        if (dominion.prosperity)  { [sqlStatement appendString:@"'Prosperity', "]; }
        if (dominion.cornucopia)  { [sqlStatement appendString:@"'Cornucopia', "]; }
        if (dominion.hinterlands) { [sqlStatement appendString:@"'Hinterlands', "]; }
        if (dominion.darkages)    { [sqlStatement appendString:@"'Darkages', "]; }
        if (dominion.promo)       { [sqlStatement appendString:@"'Promo', "]; }
        [sqlStatement deleteCharactersInRange:NSMakeRange([sqlStatement length]-2, 1)];
        
        [sqlStatement appendString:@") ORDER BY RANDOM() LIMIT 1"];
        if(dominion.query_type == @"custom") {
         [sqlStatement appendString:@"0"];
        }
        
        
        sql = [sqlStatement UTF8String];
    } else {
        sql = "SELECT * FROM kingdom_cards";
    }
    NSLog(@"%s", sql);
}

- (void) get_cards{
    [self create_query];
    cards = [[NSMutableArray alloc] initWithCapacity:10];
    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"dominion.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
            
        }
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        }else{
            
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                Card * card = [[Card alloc] init];
                
                const int  *column_id                 = (const int  *)sqlite3_column_int(sqlStatement,0);
                const char *column_name               = (const char *)sqlite3_column_text(sqlStatement,1);
                const char *column_set                = (const char *)sqlite3_column_text(sqlStatement,2);
                const char *column_type_1             = (const char *)sqlite3_column_text(sqlStatement,3);
                const char *column_type_2             = (const char *)sqlite3_column_text(sqlStatement,4);
                const int  *column_cost_coins         = (const int  *)sqlite3_column_int(sqlStatement,5);
                const int  *column_cost_potions       = (const int  *)sqlite3_column_int(sqlStatement,6);
                const int  *column_add_coins          = (const int  *)sqlite3_column_int(sqlStatement,7);
                const int  *column_add_cards          = (const int  *)sqlite3_column_int(sqlStatement,8);
                const int  *column_add_actions        = (const int  *)sqlite3_column_int(sqlStatement,9);
                const int  *column_add_buys           = (const int  *)sqlite3_column_int(sqlStatement,10);
                const int  *column_add_victory_tokens = (const int  *)sqlite3_column_int(sqlStatement,11);
                const char *column_top_text           = (const char *)sqlite3_column_text(sqlStatement,12);
                const char *column_bottom_text        = (const char *)sqlite3_column_text(sqlStatement,13);
                const char *column_description        = (const char *)sqlite3_column_text(sqlStatement,14);
                
                if(column_id                 != NULL) { card.id                 = (int) column_id; }
                if(column_name               != NULL) { card.name               = [NSString stringWithUTF8String:(char *) column_name]; }
                if(column_set                != NULL) { card.set                = [NSString stringWithUTF8String:(char *) column_set]; }
                if(column_type_1             != NULL) { card.type_1             = [NSString stringWithUTF8String:(char *) column_type_1]; }
                if(column_type_2             != NULL) { card.type_2             = [NSString stringWithUTF8String:(char *) column_type_2]; }
                if(column_cost_coins         != NULL) { card.cost_coins         = (int) column_cost_coins; }
                if(column_cost_potions       != NULL) { card.cost_potions       = (int) column_cost_potions; }
                if(column_add_coins          != NULL) { card.add_coins          = (int) column_add_coins; }
                if(column_add_cards          != NULL) { card.add_cards          = (int) column_add_cards; }
                if(column_add_actions        != NULL) { card.add_actions        = (int) column_add_actions; }
                if(column_add_buys           != NULL) { card.add_buys           = (int) column_add_buys; }
                if(column_add_victory_tokens != NULL) { card.add_victory_tokens = (int) column_add_victory_tokens; }
                if(column_top_text           != NULL) { card.top_text           = [NSString stringWithUTF8String:(char *) column_top_text]; }
                if(column_bottom_text        != NULL) { card.bottom_text        = [NSString stringWithUTF8String:(char *) column_bottom_text]; }
                if(column_description        != NULL) { card.description        = [NSString stringWithUTF8String:(char *) column_description]; }
                
                [cards addObject:card];
                card=nil;
            }
        }
        sqlite3_finalize(sqlStatement);
        
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
    }
    
}

@end
