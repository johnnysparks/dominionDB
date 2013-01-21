//
//  KingdomView.m
//  DominionDB
//
//  Created by Brandon Dusseau on 12/25/12.
//  Copyright (c) 2012 Malechite. All rights reserved.
//

#import "KingdomView.h"
#import "Card.h"
#import "Query.h"
#import "DominionVars.h"

@interface KingdomView ()

@end

@implementation KingdomView
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
    DominionVars *dominion = [DominionVars sharedVars];
    if(!dominion.loaded) {
        [self get_cards];
        dominion.loaded = true;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DominionVars *dominion = [DominionVars sharedVars];
    selected_index = indexPath.row;
    NSLog(@"Selected index %d", selected_index);
    Card *card = [dominion.kingdom_cards objectAtIndex:selected_index];
    NSLog(@"Card Name %@", card.name);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DominionVars *dominion = [DominionVars sharedVars];
    return dominion.kingdom_cards.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DominionVars *dominion = [DominionVars sharedVars];
    CardCell *card_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    int row = [indexPath row];
    Card *card = dominion.kingdom_cards[row];
    card_cell.name.text = card.name;
    card_cell.set.text = card.set;
    card_cell.coins.text = [NSString stringWithFormat:@"%d", card.cost_coins];
    card_cell.id = card.id;
    card_cell.card_index = indexPath;
    return card_cell;
}


- (IBAction)refresh_cards:(id)sender {
    DominionVars *dominion = [DominionVars sharedVars];
    dominion.kingdom_cards = nil;
    NSLog(@"Refresh Cards");
    [self get_cards];
    [self.collectionView reloadData];
}

-(void) get_cards{
    DominionVars *dominion = [DominionVars sharedVars];
    Query *query = [[Query alloc] init];
    if(dominion.kingdom_cards == nil) {
        dominion.query_type = @"custom";
        [query get_cards];
        dominion.kingdom_cards = query.cards;
    }
    if(dominion.kingdom_cards.count > 0) {
        Card *card = dominion.kingdom_cards[0];
        NSLog(@"%@", card.name);
    }    
}

- (IBAction)replace:(id)sender {
    DominionVars *dominion = [DominionVars sharedVars];
    Query *query = [[Query alloc] init];
    dominion.query_type = @"replace";
    [query get_cards];
    
    int i = dominion.replace_index.row%10;
    [dominion.kingdom_cards replaceObjectAtIndex:i withObject:query.cards[0]];
    [self.collectionView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DominionVars *dominion = [DominionVars sharedVars];
    CardCell *cell = (CardCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    int i = indexPath.row%10;
    
    CardDetailView *detailViewController = [segue destinationViewController];
    detailViewController.card = [dominion.kingdom_cards objectAtIndex:i];
 
}

@end
