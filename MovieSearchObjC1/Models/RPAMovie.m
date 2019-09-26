//
//  RPAMovie.m
//  MovieSearchObjC1
//
//  Created by Lewis Jones on 04/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

#import "RPAMovie.h"

@implementation RPAMovie

- (instancetype)initWithTitle:(NSString *)title rating:(NSNumber *)rating overview:(NSString *)overview posterPath:(NSString *)posterPath
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _rating = rating;
        _overview = [overview copy];
        _posterPath = posterPath;
    }
    return self;
}

// initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[[RPAMovie titleKey]];
    NSNumber *rating = dictionary[[RPAMovie ratingKey]];
    NSString *overview = dictionary[[RPAMovie overviewKey]];
    NSString *posterPath = dictionary[[RPAMovie posterPathKey]];
    
    return [self initWithTitle:title rating:rating overview:overview posterPath:posterPath];
}

// MARK: - Keys for dictionary
+ (NSString *)titleKey
{
    return @"title";
}

+ (NSString *)ratingKey
{
    return @"vote_average";
}

+ (NSString *)overviewKey
{
    return @"overview";
}

+ (NSString *)posterPathKey
{
    return @"poster_path";
}

@end


