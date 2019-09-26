//
//  RPAMovieController.m
//  MovieSearchObjC1
//
//  Created by Lewis Jones on 04/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

#import "RPAMovieController.h"
#import "RPAMovie.h"
#import <UIKit/UIKit.h>

@implementation RPAMovieController

+ (instancetype)shared
{
    static RPAMovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        sharedInstance = [[RPAMovieController alloc] init];
    });
    return sharedInstance;
}

// MARK: - Properties

- (NSURL *)baseURL
{
    return [NSURL URLWithString: @"https://api.themoviedb.org/3/search/movie?"];
}
//let apiQuery = URLQueryItem(name: "api_key", value: "e8ead7c87b8ce8bec496e1904ad51b6f")
//let searchQuery = URLQueryItem(name: "query", value: searchText)
//components.queryItems = [apiQuery, searchQuery]

// MARK: - Fetch

- (void)fetchMoviesWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<RPAMovie *> *, NSError *))completion
{
    NSURL *url = [self baseURL];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    // Adding two query items: API Key and query item of the search term supplied by user
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:@"e8ead7c87b8ce8bec496e1904ad51b6f"], [NSURLQueryItem queryItemWithName:@"query" value:searchTerm]];
    NSURL *searchURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"There was a problem with the search url: %@", error);
            completion(nil, error); return;
        }
        
        if (!data) {
            NSLog(@"There was no data returned from task: %@", error);
            completion(nil, error); return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON is not a dictionary class: %@", error);
            completion(nil, error); return;
        }
        
        // Get the results array from the toplevel JSON
        NSArray *resultsArray = jsonDictionary[@"results"];
        NSMutableArray *moviesArray = [NSMutableArray array];
        
        for (NSDictionary *movieDict in resultsArray) {
            RPAMovie *movie = [[RPAMovie alloc] initWithDictionary:movieDict];
            [moviesArray addObject:movie];
        }
        completion(moviesArray, nil);
    }] resume];
}

// Fetching image

- (void)fetchPosterImage:(RPAMovie *)movie completion:(void (^)(UIImage *))completion
{
    if ([movie.posterPath isKindOfClass:[NSNull class]]) {
        completion(nil); return;
    }
    
    NSURL *posterImageBaseURL = [[NSURL alloc] initWithString:@"https://image.tmdb.org/t/p/w500"];
    
    NSURL *imageURL = [posterImageBaseURL URLByAppendingPathComponent:movie.posterPath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"There was a problem with the image url: %@", error);
            completion(nil); return;
        }
        
        if (!data) {
            NSLog(@"There was no data returned from image task: %@", error);
            completion(nil); return;
        }
        
        UIImage *posterImage = [[UIImage alloc] initWithData:data];
        completion(posterImage);
    }] resume];
}

@end



