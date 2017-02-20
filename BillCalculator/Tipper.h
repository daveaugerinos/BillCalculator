//
//  Tipper.h
//  BillCalculator
//
//  Created by Dave Augerinos on 2017-02-17.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tipper : NSObject

@property (strong, nonatomic) NSDecimalNumber *billAmount;
@property (strong, nonatomic) NSDecimalNumber *tipPercentage;

- (instancetype)initWithBillAmount:(NSDecimalNumber *)billAmount TipPercentage:(NSDecimalNumber *)tipPercentage;
- (NSDecimalNumber *)calculateTipWithBillAmount:(NSDecimalNumber*)billAmount andTipPercentage:(NSDecimalNumber *)tipPercentage;

@end
