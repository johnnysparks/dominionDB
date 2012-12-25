//
//  AuthorDetailView.h
//  FirstTableProject
//
//  Created by Kevin Languedoc on 10/14/12.
//  Copyright (c) 2012 kCodebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@class Card;
@interface CardDetailView : UIViewController
@property(nonatomic, strong)id detailId;
@property(nonatomic, strong)Card *card;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *set;
@property (strong, nonatomic) IBOutlet UITextField *type_1;
@property (strong, nonatomic) IBOutlet UITextField *type_2;
@property (strong, nonatomic) IBOutlet UITextField *cost_coins;
@property (strong, nonatomic) IBOutlet UITextField *cost_potions;
@property (strong, nonatomic) IBOutlet UITextField *add_coins;
@property (strong, nonatomic) IBOutlet UITextField *add_cards;
@property (strong, nonatomic) IBOutlet UITextField *add_actions;
@property (strong, nonatomic) IBOutlet UITextField *add_buys;
@property (strong, nonatomic) IBOutlet UITextField *add_victory_tokens;
@property (strong, nonatomic) IBOutlet UITextView *top_text;
@property (strong, nonatomic) IBOutlet UITextView *bottom_text;
@property (strong, nonatomic) IBOutlet UITextView *description;


@end
