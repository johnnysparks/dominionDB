//
//  KingdomView.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "CardDetailView.h"
#import "CardCell.h"

@interface KingdomView : UICollectionViewController {
    NSMutableArray *kingdom_cards;
    sqlite3 * db;
}

@property(nonatomic,retain) NSMutableArray *kingdom_cards;
@property NSInteger selected_index;
@property BOOL *custom;
@end
