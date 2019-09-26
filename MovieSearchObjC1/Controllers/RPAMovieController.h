//
//  RPAMovieController.h
//  MovieSearchObjC1
//
//  Created by Lewis Jones on 04/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RPAMovie;

NS_ASSUME_NONNULL_BEGIN

@interface RPAMovieController : NSObject

+ (RPAMovieController *)shared;

- (void)fetchMoviesWithSearchTerm:(NSString *)searchTerm completion:(void(^) (NSArray<RPAMovie *> *movies,  NSError  * _Nullable error))completion;
- (void)fetchPosterImage: (RPAMovie *)movie completion:(void(^)(UIImage * _Nullable movieImage))completion;
@end

NS_ASSUME_NONNULL_END
