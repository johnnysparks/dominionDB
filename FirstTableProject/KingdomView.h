//
//  KingdomView.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDetailView.h"
#import "CardCell.h"

@interface KingdomView : UICollectionViewController {
    NSMutableArray *kingdom_cards;
}

- (void) refresh_cards;
@property(nonatomic,retain) NSMutableArray *kingdom_cards;
@property NSInteger selected_index;
@end
