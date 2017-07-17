//
//  dataProvider.m
//  currensyconverter
//
//  Created by Aleks on 10.07.17.
//  Copyright © 2017 Aleks. All rights reserved.
//

#import "dataProvider.h"

@implementation dataProvider

+(NSString*)getData:(NSString*) baseCurrency targetCurrency:(NSString*)targetCurrency completion:(void(^)(NSString *rate, NSError *error))handler
{
    
    NSString *retVal;
    
    NSString *request = [NSString stringWithFormat:@"%@%@%@%@%@", server, @"?base=", baseCurrency, @"&symbols=",targetCurrency];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:request]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSString *val = [[responseDictionary valueForKey:@"rates"] valueForKey:targetCurrency];
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(val, nil);
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, error);
            });
        }
    }];
    [dataTask resume];
    
    return  retVal;
    
}

@end
