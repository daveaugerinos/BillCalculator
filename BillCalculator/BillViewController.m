//
//  BillViewController.m
//  BillCalculator
//
//  Created by Dave Augerinos on 2017-02-17.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "BillViewController.h"
#import "Tipper.h"

@interface BillViewController ()

@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountDollarLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (strong, nonatomic) Tipper *tipper;

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.billAmountTextField.delegate = self;
    self.tipPercentageTextField.delegate = self;
    
    NSDecimalNumber *initialBillAmount = [[NSDecimalNumber alloc] initWithFloat:0.00];
    NSDecimalNumber *initialTipPercentage = [[NSDecimalNumber alloc] initWithFloat:0.15];

    self.tipper = [[Tipper alloc] initWithBillAmount:initialBillAmount TipPercentage: initialTipPercentage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTipButton:(UIButton *)sender {
    [self calculateTip];
}

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.f", [sender value]];
    [self calculateTip];
}

- (void)calculateTip {
    
    NSDecimalNumber *tipAmount = [[NSDecimalNumber alloc] initWithString:@"0"];
    NSDecimalNumber *billAmount = [[NSDecimalNumber alloc] initWithString:@"0"];
    NSDecimalNumber *tipPercentage = [[NSDecimalNumber alloc] initWithString:@"15"];
    NSDecimalNumber *hundred = [[NSDecimalNumber alloc] initWithString:@"100"];
    
    NSCharacterSet* invalid = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if([self.billAmountTextField.text rangeOfCharacterFromSet:invalid].location == NSNotFound && [self.tipPercentageTextField.text rangeOfCharacterFromSet:invalid].location == NSNotFound) {
        
        if(![self.billAmountTextField.text isEqualToString:@""] && ![self.tipPercentageTextField.text isEqualToString:@""]) {
            
            billAmount = [[NSDecimalNumber alloc] initWithString:self.billAmountTextField.text];
            tipPercentage = [[NSDecimalNumber alloc] initWithString:self.tipPercentageTextField.text];
            tipPercentage = [tipPercentage decimalNumberByDividingBy:hundred];
            tipAmount = [self.tipper calculateTipWithBillAmount:billAmount andTipPercentage:tipPercentage];
        }
        
        else {
            tipAmount = [self.tipper calculateTipWithBillAmount:billAmount andTipPercentage:tipPercentage];
        }
        
        NSNumberFormatter *formatDollars = [[NSNumberFormatter alloc] init];
        [formatDollars setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        self.tipAmountLabel.text = [formatDollars stringFromNumber:tipAmount];
    }
    
    else {
        self.tipAmountLabel.text = @"$0.00";
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calculateTip) name:UITextFieldTextDidChangeNotification object:nil];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
    
    [self calculateTip];
    
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
    [self.tipPercentageTextField resignFirstResponder];
}

@end
