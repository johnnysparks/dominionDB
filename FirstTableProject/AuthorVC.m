//
//  AuthorVC.m
//  FirstTableProject
//
//  Created by Kevin Languedoc on 12/5/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import "AuthorVC.h"
#import "Card.h"
#import <sqlite3.h>


@implementation AuthorVC
@synthesize theauthors;

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
    [self authorList];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.theauthors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AuthorsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int rowCount = indexPath.row;

    Card *author = [self.theauthors objectAtIndex:rowCount];
	cell.textLabel.text = author.name;
	cell.detailTextLabel.text = author.title;

    
    return cell;
}


-(NSMutableArray *) authorList{
    theauthors = [[NSMutableArray alloc] initWithCapacity:10];
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
                Card * author = [[Card alloc] init];
                author.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                author.title = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                author.genre = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                [theauthors addObject:author];
                author=nil;
            }
        }
        sqlite3_finalize(sqlStatement);
        
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        
        sqlite3_close(db);
        return theauthors;
    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   // if ([[segue identifier] isEqualToString:@"AuthorsDetail"]) {
        AuthorDetailView *detailViewController = [segue destinationViewController];
    Card *author = [[Card alloc]init];
        detailViewController.author = [self.authorList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    author = [self.authorList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    
    NSLog(@"test %@", author.name);
     NSLog(@"test %@", author.title);
    NSLog(@"test %@", author.genre);
        
  //  }
}

@end
