//
//  main.m
//  SpellCorrector
//
//  Created by Jeremy Bringetto on 3/16/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpellChecker.h"


int main(int argc, const char * argv[]) 
{
    @autoreleasepool 
    {
        SpellChecker *sc = [[SpellChecker alloc]init];
        [sc launchTheConsole];
    }
    return 0;
}
