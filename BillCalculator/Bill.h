//
//  Bill.h
//  BillCalculator
//
//  Created by Dave Augerinos on 2017-02-17.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bill : NSObject

@property (strong, nonatomic) NSDecimalNumber *billAmount;
@property (strong, nonatomic) NSDecimalNumber *splitBillAmount;
@property (assign, nonatomic) NSDecimalNumber *people;
@property (strong, nonatomic) NSDecimalNumber *tipPercentage;
@property (strong, nonatomic) NSDecimalNumber *splitTipAmount;

- (instancetype)initWithBillAmount:(NSDecimalNumber *)billAmount andPeople:(NSDecimalNumber *)people andTipPercentage:(NSDecimalNumber *)tipPercentage;
- (NSDecimalNumber *)calculateSplitBillwithBillAmount:(NSDecimalNumber *)billAmount andPeople:(NSDecimalNumber *)people;
- (NSDecimalNumber *)calculateSplitTipWithTipPercentage:(NSDecimalNumber *)tipPercentage;

@end
