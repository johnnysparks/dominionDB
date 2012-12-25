//
//  AuthorDetailView.m
//  FirstTableProject
//
//  Created by Kevin Languedoc on 10/14/12.
//  Copyright (c) 2012 kCodebook. All rights reserved.
//

#import "AuthorDetailView.h"

@interface AuthorDetailView ()

@end

@implementation AuthorDetailView
@synthesize author;

@synthesize authorName;
@synthesize authorTitle;
@synthesize authorGenre;

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
    author = (Card*)self.author;
    authorName.text=author.name;
    authorTitle.text=author.title;
    authorGenre.text=author.genre;
    
    NSLog(@"test %@", author.name);
    NSLog(@"test %@", author.title);
    NSLog(@"test %@", author.genre);
	}



- (void)viewDidUnload
{
    [self setAuthorName:nil];
    [self setAuthorTitle:nil];
    [self setAuthorGenre:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
