//
//  RPAMovie.h
//  MovieSearchObjC1
//
//  Created by Lewis Jones on 04/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPAMovie : NSObject


@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSNumber *rating;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, nullable, readonly) NSString *posterPath;

- (instancetype)initWithTitle:(NSString *)title rating:(NSNumber *)rating overview:(NSString *)overview posterPath:(NSString *)posterPath;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

