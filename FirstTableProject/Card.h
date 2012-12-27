//
//  Card.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Card : NSObject{
    int id;
    NSString *name;
    NSString *set;
    NSString *type_1;
    NSString *type_2;
    int cost_coins;
    int cost_potions;
    int add_coins;
    int add_cards;
    int add_actions;
    int add_buys;
    int add_victory_tokens;
    NSString *top_text;
    NSString *bottom_text;
    NSString *description;
}

@property(nonatomic) int id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *set;
@property(nonatomic,copy) NSString *type_1;
@property(nonatomic,copy) NSString *type_2;
@property(nonatomic) int cost_coins;
@property(nonatomic) int cost_potions;
@property(nonatomic) int add_coins;
@property(nonatomic) int add_cards;
@property(nonatomic) int add_actions;
@property(nonatomic) int add_buys;
@property(nonatomic) int add_victory_tokens;
@property(nonatomic,copy) NSString *top_text;
@property(nonatomic,copy) NSString *bottom_text;
@property(nonatomic,copy) NSString *description;

@end
