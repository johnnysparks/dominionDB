//
//  RandomizerView.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/27/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "RandomizerView.h"
#import "Query.h"
#import "GameOptions.h"
#import "Card.h"

@interface RandomizerView ()

@end

@implementation RandomizerView

@synthesize kingdom_cards;
@synthesize kingdomView;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) gotoKingdomView
{
    if(self.kingdomView == nil)
    {
        NSLog(@"no kingdom view");
        KingdomView *kingdom = [self.storyboard instantiateViewControllerWithIdentifier:@"KingdomView"];
        self.kingdomView = kingdom;
    }
    
    kingdomView.kingdom_cards = kingdom_cards;
    [kingdomView refresh_cards];
    [self.tabBarController setSelectedIndex:1];
    
}

- (IBAction)create_game:(id)sender {
    GameOptions *options = [[GameOptions alloc] init];
    options.type        = @"custom";
    
    NSString *base = @"Basic";
    NSString *intrigue = @"Intrigue";
    NSString *seaside = @"Seaside";
    NSString *alchemy = @"Alchemy";
    NSString *prosperity = @"Prosperity";
    NSString *cornucopia = @"Cornucopia";
    NSString *hinterlands = @"Hinterlands";
    NSString *darkages = @"Darkages";
    NSString *promo = @"Promo";
    
    NSMutableArray *temp_sets = [[NSMutableArray alloc] init];
    
    if(_base.on)        {[temp_sets addObject:base];}
    if(_intrigue.on)    {[temp_sets addObject:intrigue];}
    if(_seaside.on)     {[temp_sets addObject:seaside];}
    if(_alchemy.on)     {[temp_sets addObject:alchemy];}
    if(_prosperity.on)  {[temp_sets addObject:prosperity];}
    if(_cornucopia.on)  {[temp_sets addObject:cornucopia];}
    if(_hinterlands.on) {[temp_sets addObject:hinterlands];}
    if(_darkages.on)    {[temp_sets addObject:darkages];}
    if(_promo.on)       {[temp_sets addObject:promo];}
    
    options.sets = temp_sets;
    
    Query *query = [[Query alloc] init];
    query.options = options;
    [query get_cards];
    kingdom_cards = query.cards;
//    for (int i =0; i < kingdom_cards.count; i++) {
//        Card *card = [kingdom_cards objectAtIndex:i];
//        NSLog(@"Name: %@", card.name);
//    }
    [self gotoKingdomView];
}

@end
