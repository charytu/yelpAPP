//
//  YelpClient.h
//  Yelp
//
//  Created by Chary Tu on 6/22/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface YelpClient : BDBOAuth1RequestOperationManager
- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
