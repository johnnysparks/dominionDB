//
//  AuthorVC.m
//  FirstTableProject
//
//  Created by Kevin Languedoc on 12/5/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import "ListView.h"
#import "Card.h"
#import <sqlite3.h>


@implementation ListView
@synthesize kingdom_cards;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self card_list];
    [super viewDidLoad];

   }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [search_results count];
        
    } else {
        return [self.kingdom_cards count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int rowCount = indexPath.row;

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        Card *card = [search_results objectAtIndex:rowCount];
        cell.textLabel.text = card.name;
        cell.detailTextLabel.text = card.set;
    } else {
        Card *card = [self.kingdom_cards objectAtIndex:rowCount];
        cell.textLabel.text = card.name;
        cell.detailTextLabel.text = card.set;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"showCardDetails" sender: self];
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@", searchText];
    //[NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@ OR SELF.set contains[cd] %@", searchText, searchText];
    
    search_results = [kingdom_cards filteredArrayUsingPredicate:resultPredicate];
}


-(NSMutableArray *) card_list{
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
        
        
        const char *sql = "SELECT * FROM kingdom_cards";
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

    CardDetailView *detailViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = nil;
    
    if ([self.searchDisplayController isActive]) {
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        detailViewController.card = [search_results objectAtIndex:indexPath.row];
        
    } else {
        detailViewController.card = [self.card_list objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
        
}

@end
