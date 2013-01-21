//
//  DominionVars.h
//  DominionDB
//
//  Created by Brandon Dusseau on 1/3/13.
//  Copyright (c) 2013 Malechite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DominionVars : NSObject{
    
    //options for which sets are enabled
    BOOL base;
    BOOL intrigue;
    BOOL seaside;
    BOOL alchemy;
    BOOL prosperity;
    BOOL cornucopia;
    BOOL hinterlands;
    BOOL darkages;
    BOOL promo;
    
    //query options
    NSString *query_type;
    
    //storing cards after a query
    BOOL loaded;
    NSMutableArray *kingdom_cards;
    
    //storing card selections
    NSIndexPath *replace_index;

}

@property (nonatomic, assign) BOOL base;
@property (nonatomic, assign) BOOL intrigue;
@property (nonatomic, assign) BOOL seaside;
@property (nonatomic, assign) BOOL alchemy;
@property (nonatomic, assign) BOOL prosperity;
@property (nonatomic, assign) BOOL cornucopia;
@property (nonatomic, assign) BOOL hinterlands;
@property (nonatomic, assign) BOOL darkages;
@property (nonatomic, assign) BOOL promo;

@property (nonatomic, copy) NSString *query_type;

@property (nonatomic, assign) BOOL loaded;
@property(nonatomic) NSMutableArray *kingdom_cards;

@property (nonatomic) NSIndexPath *replace_index;

+ (DominionVars *)sharedVars;

@end
