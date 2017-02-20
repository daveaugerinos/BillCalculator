//
//  Bill.m
//  BillCalculator
//
//  Created by Dave Augerinos on 2017-02-17.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "Bill.h"

@implementation Bill



- (instancetype)initWithBillAmount:(NSDecimalNumber *)billAmount andPeople:(NSDecimalNumber *)people andTipPercentage:(NSDecimalNumber *)tipPercentage{
    self = [super init];
    if (self) {
        self.billAmount = billAmount;
        self.people = people;
        self.tipPercentage = tipPercentage;
        self.splitBillAmount = [self calculateSplitBillwithBillAmount:billAmount andPeople:people];
        self.splitTipAmount = [self calculateSplitTipWithTipPercentage:self.tipPercentage];
    }
    return self;
}

- (NSDecimalNumber *)calculateSplitBillwithBillAmount:(NSDecimalNumber *)billAmount andPeople:(NSDecimalNumber *)people {
    
    self.billAmount = billAmount;
    self.people = people;
    self.splitBillAmount = [self.billAmount decimalNumberByDividingBy:self.people];

    return self.splitBillAmount;
}


- (NSDecimalNumber *)calculateSplitTipWithTipPercentage:(NSDecimalNumber *)tipPercentage {
  
    self.tipPercentage = tipPercentage;
    self.splitTipAmount = [self.splitBillAmount decimalNumberByMultiplyingBy: self.tipPercentage];
    
    return self.splitTipAmount;
}

@end
