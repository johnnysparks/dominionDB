//
//  Card.h
//  DominionDB
//
//  Created by Kevin Languedoc on 12/5/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject{
    NSString *name;
    NSString *set;
    NSString *type_1;
    NSString *type_2;
    NSInteger *cost_coins;
    NSInteger *cost_potions;
    NSInteger *add_coins;
    NSInteger *add_cards;
    NSInteger *add_actions;
    NSInteger *add_buys;
    NSInteger *add_victory_tokens;
    NSString *top_text;
    NSString *bottom_text;
    NSString *description;
}

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *set;
@property(nonatomic,copy) NSString *type_1;
@property(nonatomic,copy) NSString *type_2;
@property(nonatomic) NSInteger *cost_coins;
@property(nonatomic) NSInteger *cost_potions;
@property(nonatomic) NSInteger *add_coins;
@property(nonatomic) NSInteger *add_cards;
@property(nonatomic) NSInteger *add_actions;
@property(nonatomic) NSInteger *add_buys;
@property(nonatomic) NSInteger *add_victory_tokens;
@property(nonatomic,copy) NSString *top_text;
@property(nonatomic,copy) NSString *bottom_text;
@property(nonatomic,copy) NSString *description;

@end
