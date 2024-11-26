//
//  NetworkService.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit//UIKit.h>
#import "NetworkService.h"

@implementation NetworkService

// MARK: - Properties

+ (NSString *)apiKey {
    static NSString *apiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        #warning insert your tmdb api key below
        apiKey = @"API_KEY_HERE";
    });
    return apiKey;
}

// MARK: - Methods

- (Movie *)decodeMovieFromDictionary:(NSDictionary *)dictionary {
    NSString *title = dictionary[@"title"];
    NSString *overview = dictionary[@"overview"];
    NSNumber *vote_average = dictionary[@"vote_average"];
    NSString *poster_path = dictionary[@"poster_path"];
    NSArray<NSNumber *> *genre_ids = dictionary[@"genre_ids"];
    Movie *movie = [[Movie alloc]
                    initWithTitle:title
                    overview:overview
                    vote_average:vote_average
                    posterPath:poster_path
                    genre_ids:genre_ids
    ];
    return movie;
}

- (NSDictionary *)decodeByProtocolsWithData:(NSData *)data {
    NSError *decodingError = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&decodingError];
    
    if (decodingError) {
        NSLog(@"Error decoding image data");
        return nil;
    }
    
    return jsonArray;
}

- (void)getDataFromURL:(NSURL *)url completion:(void (^)(NSData *))completion {
    if (!url) {
        NSLog(@"Invalid URL");
        completion(nil);
        return;
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Unknown error");
            completion(nil);
            return;
        }
        
        if (![response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSLog(@"Response invalid 1");
            completion(nil);
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode != 200) {
            NSLog(@"Response invalid 2");
            completion(nil);
            return;
        }
        
        completion(data);
        return;
    }];
    
    [dataTask resume];
}

- (void)fetchMovies:(void (^)(NSArray<Movie *> *))completion {
    NSString *prefix = @"https://api.themoviedb.org/3/movie/popular";
    NSString *key = [NSString stringWithFormat:@"?api_key=%@", NetworkService.apiKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", prefix, key];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self getDataFromURL:url completion:^(NSData *data) {
        if (!data) {
            NSLog(@"Invalid movie data");
            completion(@[]);
            return;
        }
        
        NSDictionary *jsonArray = [self decodeByProtocolsWithData:data];
        NSArray *results = jsonArray[@"results"];
        
        NSMutableArray *movies = [[NSMutableArray alloc] init];
        
        dispatch_group_t group = dispatch_group_create();
        
        for (NSDictionary *movieDict in results) {
            Movie *movie = [self decodeMovieFromDictionary:movieDict];

            dispatch_group_enter(group);
            
            [self getImageDataFromPosterPath:movie.poster_path completion:^(NSData *imageData) {
                movie.imageData = imageData;
                [movies addObject:movie];
                
                dispatch_group_leave(group);
            }];
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                completion([movies copy]);
            });
        }
    }];
}

- (void)getImageDataFromPosterPath:(NSString *)posterPath completion:(void (^)(NSData *))completion {
    if (!posterPath) {
        NSLog(@"Invalid poster path");
        completion(nil);
        return;
    }
    
    NSString *prefix = @"https://image.tmdb.org/t/p/w185";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", prefix, posterPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self getDataFromURL:url completion:^(NSData *data) {
        if (!data) {
            NSLog(@"Invalid movie data");
            completion(nil);
            return;
        }
        
        completion(data);
        return;
    }];
}

@end
