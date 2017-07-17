//
//  ViewController.m
//  currensyconverter
//
//  Created by Aleks on 05.07.17.
//  Copyright © 2017 Aleks. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerData = @[@"RUB", @"USD", @"EUR"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  
        NSString *fulltext = [textField.text stringByAppendingString:string];
        NSString *charactersSetString = @"0123456789";
        
        // For decimal keyboard, allow "dot" and "comma" characters.
        if(self.decimalNumeric) {
            charactersSetString = [charactersSetString stringByAppendingString:@".,"];
        }
        
        NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:charactersSetString];
        NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:fulltext];
        
        // If typed character is out of Set, ignore it.
        BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
        if(!stringIsValid) {
            return NO;
        }
        
            NSString *currentText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            // Change the "," (appears in other locale keyboards, such as russian) key ot "."
            //currentText = [currentText stringByReplacingOccurrencesOfString:@"," withString:@"."];
            
            // Check the statements of decimal value.
            if([fulltext isEqualToString:@","]) {
                textField.text = @"0,";
                return NO;
            }
            
            if([fulltext rangeOfString:@",,"].location != NSNotFound) {
                textField.text = [fulltext stringByReplacingOccurrencesOfString:@",," withString:@","];
                return NO;
            }
            
            // If second dot is typed, ignore it.
            NSArray *dots = [fulltext componentsSeparatedByString:@","];
            if(dots.count > 2) {
                textField.text = currentText;
                return NO;
            }
            
            // If first character is zero and second character is > 0, replace first with second. 05 => 5;
            if(fulltext.length == 2) {
                if([[fulltext substringToIndex:1] isEqualToString:@"0"] && ![fulltext isEqualToString:@"0,"]) {
                    textField.text = [fulltext substringWithRange:NSMakeRange(1, 1)];
                    return NO;
                }
    }
    
    // Check the max characters typed.
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return returnKey;
}
- (IBAction)onConverterPressed:(id)sender {
    
    NSString *baseCurr = self.pickerData[[self.baseCurrencyPicker selectedRowInComponent:0]];
    NSString *exchangeCurr = self.pickerData[[self.exchangeCurrencyPicker selectedRowInComponent:0]];
    
    if([baseCurr isEqualToString:exchangeCurr])
    {
        [self.resultLabel setText:self.valInput.text];
    }
    else
    {
        [dataProvider getData:baseCurr targetCurrency:exchangeCurr completion:^(NSString *rate, NSError *error){
        
            
            
            if(error){
                
            }
            else{
             
                NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
                [frm setPositiveFormat:@"0.##"];
                
                double result =  [self.valInput.text doubleValue] * [rate doubleValue];
                self.resultLabel.text = [frm stringFromNumber: [NSNumber numberWithDouble:result]];
            }
        
        }];
    }
    
}
@end
