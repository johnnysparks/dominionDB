//
//  RandomizerView.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/27/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KingdomView.h"

@interface RandomizerView : UIViewController {
    NSMutableArray *kingdom_cards;
    KingdomView *kingdomView;
}

@property (nonatomic, retain) KingdomView *kingdomView;
@property(nonatomic,retain) NSMutableArray *kingdom_cards;
@property (weak, nonatomic) IBOutlet UISwitch *base;
@property (weak, nonatomic) IBOutlet UISwitch *intrigue;
@property (weak, nonatomic) IBOutlet UISwitch *seaside;
@property (weak, nonatomic) IBOutlet UISwitch *alchemy;
@property (weak, nonatomic) IBOutlet UISwitch *prosperity;
@property (weak, nonatomic) IBOutlet UISwitch *cornucopia;
@property (weak, nonatomic) IBOutlet UISwitch *hinterlands;
@property (weak, nonatomic) IBOutlet UISwitch *darkages;
@property (weak, nonatomic) IBOutlet UISwitch *promo;

@end
