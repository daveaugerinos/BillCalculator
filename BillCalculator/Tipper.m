//
//  Tipper.m
//  BillCalculator
//
//  Created by Dave Augerinos on 2017-02-17.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "Tipper.h"

@implementation Tipper

- (instancetype)initWithBillAmount:(NSDecimalNumber *)billAmount TipPercentage:(NSDecimalNumber *)tipPercentage {
    self = [super init];
    if (self) {
        self.billAmount = [[NSDecimalNumber alloc] initWithString:@"0"];
        self.tipPercentage = [[NSDecimalNumber alloc] initWithString:@"0.15"];
    }
    return self;
}

- (NSDecimalNumber *)calculateTipWithBillAmount:(NSDecimalNumber*)billAmount andTipPercentage:(NSDecimalNumber *)tipPercentage {
    
    self.billAmount = billAmount;
    self.tipPercentage = tipPercentage;
    
    return [self.billAmount decimalNumberByMultiplyingBy: self.tipPercentage];
}

@end
