//
//  Card.h
//  DominionDB
//
//  Created by Kevin Languedoc on 12/5/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject{
    NSString *name;
    NSString *title;
    NSString *genre;
}

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *genre;

@end
