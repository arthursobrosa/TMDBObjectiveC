//
//  NetworkService.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface NetworkService : NSObject

+ (NSString *)apiKey;

- (void)fetchMovies:(void (^)(NSArray<Movie *> *movies))completion;

@end
