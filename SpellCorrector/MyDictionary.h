//
//  MyDictionary.h
//  SpellCorrector
//
//  Created by Jeremy Bringetto on 3/16/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDictionary : NSObject

-(void)loadTheWords;
-(NSArray *)arrayOfCharacters:(NSString*)word;
-(NSInteger)scoreAWord:(NSString*)word;
@property (nonatomic) NSMutableDictionary *wordsByPrefix;


@end
