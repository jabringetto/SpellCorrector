//
//  SpellCorrectorTests.m
//  SpellCorrectorTests
//
//  Created by Jeremy Bringetto on 3/17/17.
//  Copyright © 2017 Jeremy Bringetto. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SpellChecker.h"

@interface SpellCorrectorTests : XCTestCase

@property (nonatomic) SpellChecker *sc;

@end

@implementation SpellCorrectorTests

- (void)setUp 
{
    [super setUp];
    _sc = [[SpellChecker alloc]init];
    _sc.testMode = YES;
    [_sc launchTheConsole];
    
}
-(void)testCapitalizationFix
{
    
    NSString *s1 = @"inSIDE";
    NSString *s2 = @"jEreMY";
    NSString *s3 = @"huNTer";
    
    NSString *r1 = [_sc receiveConsoleInput:s1];
    XCTAssertTrue([r1 isEqualToString:@"inside"]);
    
    NSString *r2 = [_sc receiveConsoleInput:s2];
    XCTAssertTrue([r2 isEqualToString:@"jeremy"]);
    
    NSString *r3 = [_sc receiveConsoleInput:s3];
    XCTAssertTrue([r3 isEqualToString:@"hunter"]);
}
-(void)testRepeatedCharactersFix
{
    NSString *s1 = @"jjoobbb";
    NSString *s2 = @"devvvelopper";
    
    NSString *r1 = [_sc receiveConsoleInput:s1];
    XCTAssertTrue([r1 isEqualToString:@"job"]);
    
    NSString *r2 = [_sc receiveConsoleInput:s2];
    XCTAssertTrue([r2 isEqualToString:@"developer"]);
}
-(void)testIncorrectVowellFix
{
    NSString *s1 = @"weke";
    NSString *s2 = @"jarumy";
    
    NSString *r1 = [_sc receiveConsoleInput:s1];
    XCTAssertTrue([r1 isEqualToString:@"woke"]);
    
    NSString *r2 = [_sc receiveConsoleInput:s2];
    XCTAssertTrue([r2 isEqualToString:@"jeremy"]);
}
-(void)testComboFix
{
    NSString *s1 = @"CUNsperrICY";
    
    NSString *r1 = [_sc receiveConsoleInput:s1];
    XCTAssertTrue([r1 isEqualToString:@"conspiracy"]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _sc = nil;
    [super tearDown];
}


@end
