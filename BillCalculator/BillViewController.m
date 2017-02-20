//
//  BillViewController.m
//  BillCalculator
//
//  Created by Dave Augerinos on 2017-02-17.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "BillViewController.h"
#import "Bill.h"

@interface BillViewController ()

@property (weak, nonatomic) IBOutlet UILabel *viewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *billAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitBillAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitTipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *peopleTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UILabel *splitBillAmountValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitTipAmountValueLabel;
@property (strong, nonatomic) Bill *bill;
@property (strong, nonatomic) NSDecimalNumber *billAmount;
@property (strong, nonatomic) NSDecimalNumber *people;
@property (strong, nonatomic) NSDecimalNumber *tipPercentage;
@property (strong, nonatomic) NSDecimalNumber *splitBillAmount;
@property (strong, nonatomic) NSDecimalNumber *splitTipAmount;

@end

@implementation BillViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Set delegates
    self.billAmountTextField.delegate = self;
    self.peopleTextField.delegate = self;
    self.tipPercentageTextField.delegate = self;
    
    // Initial default values and related initial bill
    self.billAmount = [[NSDecimalNumber alloc] initWithFloat:0.00];
    self.people = [[NSDecimalNumber alloc] initWithInt:1];
    self.tipPercentage = [[NSDecimalNumber alloc] initWithFloat:0.15];
    self.bill = [[Bill alloc] initWithBillAmount:self.billAmount andPeople:self.people andTipPercentage:self.tipPercentage];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)adjustPeople:(UISlider *)sender {

    self.peopleTextField.text = [NSString stringWithFormat:@"%.f", [sender value]];
    [self calculateSplitBill];
}

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.f", [sender value]];
    [self calculateSplitBill];
}

- (void)calculateSplitBill {
    
    NSDecimalNumber *inputedBillNumber = [[NSDecimalNumber alloc] initWithString: self.billAmountTextField.text];
    NSDecimalNumber *inputedPeopleNumber = [[NSDecimalNumber alloc] initWithString:self.peopleTextField.text];
    NSDecimalNumber *inputedTipNumber = [[NSDecimalNumber alloc] initWithString: self.tipPercentageTextField.text];
    
    if([inputedBillNumber isEqual:[NSDecimalNumber notANumber]] || [inputedPeopleNumber isEqual:[NSDecimalNumber notANumber]] || [inputedTipNumber isEqual:[NSDecimalNumber notANumber]]) {
        
        self.splitBillAmountValueLabel.text = @"$ 0.00";
        self.splitTipAmountValueLabel.text = @"$ 0.00";
        
        return;
    }
    
    else {
        // Split bill amount
        self.billAmount = [[NSDecimalNumber alloc] initWithString:self.billAmountTextField.text];
        self.people = [[NSDecimalNumber alloc] initWithString:self.peopleTextField.text];
        self.splitBillAmount = [self.bill calculateSplitBillwithBillAmount:self.billAmount andPeople:self.people];
        
        // Split tip amount
        self.tipPercentage = [[NSDecimalNumber alloc] initWithString:self.tipPercentageTextField.text];
        NSDecimalNumber *hundred = [[NSDecimalNumber alloc] initWithString:@"100"];
        self.tipPercentage = [self.tipPercentage decimalNumberByDividingBy:hundred];
        self.splitTipAmount = [self.bill calculateSplitTipWithTipPercentage:self.tipPercentage];
    
        NSNumberFormatter *formatDollars = [[NSNumberFormatter alloc] init];
        [formatDollars setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        self.splitBillAmountValueLabel.text = [formatDollars stringFromNumber:self.splitBillAmount];
        self.splitTipAmountValueLabel.text = [formatDollars stringFromNumber:self.splitTipAmount];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calculateSplitBill) name:UITextFieldTextDidChangeNotification object:nil];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
    
    [self calculateSplitBill];
    
    return NO;
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.billAmountTextField resignFirstResponder];
    [self.peopleTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
}

@end
