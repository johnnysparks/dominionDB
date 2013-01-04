//
//  RandomizerView.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/27/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "RandomizerView.h"
#import "Query.h"
#import "Card.h"
#import "DominionVars.h"

@interface RandomizerView ()

@end

@implementation RandomizerView

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
    DominionVars *dominion = [DominionVars sharedVars];
    _base.on        = dominion.base;
    _intrigue.on    = dominion.intrigue;
    _seaside.on     = dominion.seaside;
    _alchemy.on     = dominion.alchemy;
    _prosperity.on  = dominion.prosperity;
    _cornucopia.on  = dominion.cornucopia;
    _hinterlands.on = dominion.hinterlands;
    _darkages.on    = dominion.darkages;
    _promo.on       = dominion.promo;
    
	// Do any additional setup after loading the view.
}

- (IBAction)trigger:(UISwitch *)sender {
    DominionVars *dominion = [DominionVars sharedVars];
    dominion.base        = _base.on;
    dominion.intrigue    = _intrigue.on;
    dominion.seaside     = _seaside.on;
    dominion.alchemy     = _alchemy.on;
    dominion.prosperity  = _prosperity.on;
    dominion.cornucopia  = _cornucopia.on;
    dominion.hinterlands = _hinterlands.on;
    dominion.darkages    = _darkages.on;
    dominion.promo       = _promo.on;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DominionVars *dominion = [DominionVars sharedVars];
    
    dominion.query_type = @"custom";
    
    Query *query = [[Query alloc] init];
    [query get_cards];
    dominion.kingdom_cards = query.cards;
    
}

@end
