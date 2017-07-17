//
//  ViewController.h
//  currensyconverter
//
//  Created by Aleks on 05.07.17.
//  Copyright © 2017 Aleks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataProvider.h"

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *baseCurrencyPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *exchangeCurrencyPicker;

@property (nonatomic, strong) NSArray *pickerData;;
- (IBAction)onConverterPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *valInput;

@property BOOL numeric;
@property BOOL decimalNumeric;
@property int maxCharacters;
@end

