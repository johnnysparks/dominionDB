//
//  ListView.h
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDetailView.h"


@interface ListView : UITableViewController{
    NSMutableArray *kingdom_cards;
    NSArray *search_results;
}
@property(nonatomic,retain) NSMutableArray *kingdom_cards;
@property(nonatomic, strong)CardDetailView *details;

-(NSMutableArray *) get_cards;
@end
 