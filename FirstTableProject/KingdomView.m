//
//  KingdomView.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "KingdomView.h"
#import "Card.h"
#import <sqlite3.h>

@interface KingdomView ()

@end

@implementation KingdomView
@synthesize kingdom_cards;
@synthesize custom;
@synthesize selected_index;

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
    [self get_cards];
    custom = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selected_index = indexPath.row;
    NSLog(@"Selected index %d", selected_index);
    Card *card = [kingdom_cards objectAtIndex:selected_index];
    NSLog(@"Card Name %@", card.name);
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return kingdom_cards.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell *card_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    
    int row = [indexPath row];
    
    Card *card = kingdom_cards[row];
    
    card_cell.name.text = card.name;
    
    return card_cell;
}

-(NSMutableArray *) get_cards{
    kingdom_cards = [[NSMutableArray alloc] initWithCapacity:10];
    @try {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"dominion.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
            
        }
        
        const char *sql = "";
        
        if(!custom) {
            sql = "SELECT * FROM kingdom_cards ORDER BY RANDOM() LIMIT 10";
        } else {
            
        }
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        }else{
            
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                Card * card = [[Card alloc] init];
                
                const char *column_name               = (const char *)sqlite3_column_text(sqlStatement,1);
                const char *column_set                = (const char *)sqlite3_column_text(sqlStatement,2);
                const char *column_type_1             = (const char *)sqlite3_column_text(sqlStatement,3);
                const char *column_type_2             = (const char *)sqlite3_column_text(sqlStatement,4);
                const int  *column_cost_coins         = (const int  *)sqlite3_column_int(sqlStatement,5);
                const int  *column_cost_potions       = (const int  *)sqlite3_column_int(sqlStatement,6);
                const int  *column_add_coins          = (const int  *)sqlite3_column_int(sqlStatement,7);
                const int  *column_add_cards          = (const int  *)sqlite3_column_int(sqlStatement,8);
                const int  *column_add_actions        = (const int  *)sqlite3_column_int(sqlStatement,9);
                const int  *column_add_buys           = (const int  *)sqlite3_column_int(sqlStatement,10);
                const int  *column_add_victory_tokens = (const int  *)sqlite3_column_int(sqlStatement,11);
                const char *column_top_text           = (const char *)sqlite3_column_text(sqlStatement,12);
                const char *column_bottom_text        = (const char *)sqlite3_column_text(sqlStatement,13);
                const char *column_description        = (const char *)sqlite3_column_text(sqlStatement,14);
                
                
                if(column_name               != NULL) { card.name               = [NSString stringWithUTF8String:(char *) column_name]; }
                if(column_set                != NULL) { card.set                = [NSString stringWithUTF8String:(char *) column_set]; }
                if(column_type_1             != NULL) { card.type_1             = [NSString stringWithUTF8String:(char *) column_type_1]; }
                if(column_type_2             != NULL) { card.type_2             = [NSString stringWithUTF8String:(char *) column_type_2]; }
                if(column_cost_coins         != NULL) { card.cost_coins         = (int) column_cost_coins; }
                if(column_cost_potions       != NULL) { card.cost_potions       = (int) column_cost_potions; }
                if(column_add_coins          != NULL) { card.add_coins          = (int) column_add_coins; }
                if(column_add_cards          != NULL) { card.add_cards          = (int) column_add_cards; }
                if(column_add_actions        != NULL) { card.add_actions        = (int) column_add_actions; }
                if(column_add_buys           != NULL) { card.add_buys           = (int) column_add_buys; }
                if(column_add_victory_tokens != NULL) { card.add_victory_tokens = (int) column_add_victory_tokens; }
                if(column_top_text           != NULL) { card.top_text           = [NSString stringWithUTF8String:(char *) column_top_text]; }
                if(column_bottom_text        != NULL) { card.bottom_text        = [NSString stringWithUTF8String:(char *) column_bottom_text]; }
                if(column_description        != NULL) { card.description        = [NSString stringWithUTF8String:(char *) column_description]; }
                
                [kingdom_cards addObject:card];
                card=nil;
            }
        }
        sqlite3_finalize(sqlStatement);
        
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        
        sqlite3_close(db);
        return kingdom_cards;
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CardCell *cell = (CardCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    int i = indexPath.row%10;
    
    CardDetailView *detailViewController = [segue destinationViewController];
    detailViewController.card = [kingdom_cards objectAtIndex:i];
 
}

@end
