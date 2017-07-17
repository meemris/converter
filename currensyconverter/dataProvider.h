//
//  dataProvider.h
//  currensyconverter
//
//  Created by Aleks on 10.07.17.
//  Copyright © 2017 Aleks. All rights reserved.
//

#import <Foundation/Foundation.h>

#define server @"http://api.fixer.io/latest"

@interface dataProvider : NSObject

+(NSString*)getData:(NSString*) baseCurrency targetCurrency:(NSString*)targetCurrency completion:(void(^)(NSString *rate, NSError *error))handler;

@end
