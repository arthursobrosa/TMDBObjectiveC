//
//  ListViewModel.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import "ListViewModel.h"

@interface ListViewModel ()

// MARK: - Network service to fetch movies

@property (strong, nonatomic, readonly) NetworkService * networkService;

@end

@implementation ListViewModel

// MARK: - Initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkService = [[NetworkService alloc] init];
    }
    return self;
}

// MARK: - Methods

- (void)fetchMovies {
    [self.networkService fetchMovies:^(NSArray<Movie *> *movies) {
        self.onFetchMovies(movies);
    }];
}

@end
