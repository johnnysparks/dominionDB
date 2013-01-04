//
//  AppDelegate.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "ListView.h"
#import "Card.h"
#import "Query.h"
#import "DominionVars.h"


@implementation ListView
@synthesize kingdom_cards;
@synthesize card_search;

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
    [self get_cards];
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
    Card *card = [self.kingdom_cards objectAtIndex:rowCount];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        card = [search_results objectAtIndex:rowCount];
    }
    
    cell.textLabel.text = card.name;
    cell.detailTextLabel.text = card.set;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"showCardDetails" sender: self];
        [card_search resignFirstResponder];
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@", searchText];
    //[NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@ OR SELF.set contains[cd] %@", searchText, searchText];
    
    search_results = [kingdom_cards filteredArrayUsingPredicate:resultPredicate];
}


-(NSMutableArray *) get_cards{
    DominionVars *dominion = [DominionVars sharedVars];
    Query *query = [[Query alloc] init];
    dominion.query_type = @"list";
    [query get_cards];
    kingdom_cards = query.cards;
    return kingdom_cards;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    CardDetailView *detailViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = nil;
    
    if ([self.searchDisplayController isActive]) {
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        detailViewController.card = [search_results objectAtIndex:indexPath.row];
        
    } else {
        detailViewController.card = [self.kingdom_cards objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
        
}

@end
