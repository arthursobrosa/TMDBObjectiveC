//
//  ListViewModel.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <Foundation/Foundation.h>
#import "NetworkService.h"

@interface ListViewModel : NSObject

// MARK: - Call back to connect with VC

@property (nonatomic, copy) void (^onFetchMovies)(NSArray<Movie *> *movies);

// MARK: - Methods

- (void)fetchMovies;

@end
