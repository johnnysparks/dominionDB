//
//  AuthorDetailView.m
//  FirstTableProject
//
//  Created by Kevin Languedoc on 10/14/12.
//  Copyright (c) 2012 kCodebook. All rights reserved.
//

#import "CardDetailView.h"

@interface CardDetailView ()

@end

@implementation CardDetailView
@synthesize card;

@synthesize name;
@synthesize set;
@synthesize type_1;
@synthesize type_2;
@synthesize cost_coins;
@synthesize cost_potions;
@synthesize add_coins;
@synthesize add_cards;
@synthesize add_actions;
@synthesize add_buys;
@synthesize add_victory_tokens;
@synthesize top_text;
@synthesize bottom_text;
@synthesize description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    card = (Card*)self.card;
    name.text               = card.name;
    set.text                = card.set;
    type_1.text             = card.type_1;
    type_2.text             = card.type_2;
    cost_coins.text         = [NSString stringWithFormat:@"%d", card.cost_coins];
    cost_potions.text       = [NSString stringWithFormat:@"%d", card.cost_potions];
    add_coins.text          = [NSString stringWithFormat:@"%d", card.add_coins];
    add_cards.text          = [NSString stringWithFormat:@"%d", card.add_cards];
    add_actions.text        = [NSString stringWithFormat:@"%d", card.add_actions];
    add_buys.text           = [NSString stringWithFormat:@"%d", card.add_buys];
    add_victory_tokens.text = [NSString stringWithFormat:@"%d", card.add_victory_tokens];
    top_text.text           = card.top_text;
    bottom_text.text        = card.bottom_text;
    description.text        = card.description;

    NSLog(@"test %@", card.name);
    NSLog(@"test %@", card.set);
    NSLog(@"test %@", card.type_1);
    NSLog(@"test %d", card.cost_coins);
    
}

- (IBAction)close_modal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidUnload
{
//    [self setAuthorName:nil];
//    [self setAuthorTitle:nil];
//    [self setAuthorGenre:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
