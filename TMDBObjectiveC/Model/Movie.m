//
//  Movie.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface Movie()

-(NSString *)getGenreWithID:(NSNumber *)identifier;

@end

@implementation Movie

// MARK: - Properties

- (NSString *)genres {
    NSString *allGenresString = [[NSString alloc] init];
    allGenresString = @"";
    
    for (NSNumber *genreID in self.genre_ids) {
        if ([allGenresString isEqual: @""]) {
            allGenresString = [self getGenreWithID:genreID];
        } else {
            NSString *genre = [self getGenreWithID:genreID];
            NSString *wholeString = [NSString stringWithFormat:@"%@, %@", allGenresString, genre];
            allGenresString = wholeString;
        }
    }
    
    return allGenresString;
}

// MARK: - Initializer

- (instancetype)initWithTitle:(NSString *)title
                     overview:(NSString *)overview
                 vote_average:(NSNumber *)vote_average
                   posterPath:(NSString *)poster_path
                    genre_ids:(NSArray<NSNumber *> *)genre_ids {
    
    self = [super init];
    if (title) { _title = title; }
    if (overview) { _overview = overview; }
    if (vote_average) { _vote_average = vote_average; }
    if (poster_path) { _poster_path = poster_path; }
    if (genre_ids) { _genre_ids = genre_ids; }
    return self;
}

// MARK: - Codable methods

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.overview forKey:@"overview"];
    [coder encodeObject:self.vote_average forKey:@"vote_average"];
    [coder encodeObject:self.poster_path forKey:@"poster_path"];
    [coder encodeObject:self.genre_ids forKey:@"genre_ids"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NSString *title = [coder decodeObjectForKey:@"title"];
    NSString *overview = [coder decodeObjectForKey:@"overview"];
    NSNumber *vote_average = [coder decodeObjectForKey:@"vote_average"];
    NSString *poster_path = [coder decodeObjectForKey:@"poster_path"];
    NSArray<NSNumber *> *genre_ids = [coder decodeObjectForKey:@"genre_ids"];
    return [self
            initWithTitle:title
            overview:overview
            vote_average:vote_average
            posterPath:poster_path
            genre_ids:genre_ids
    ];
}

// MARK: - Other methods

- (NSString *)ratingsFormatted {
    double doubleVoteAverage = [self.vote_average doubleValue];
    NSString *voteAverage = [NSString stringWithFormat:@"%.1f", doubleVoteAverage];
    return [NSString stringWithFormat:@"☆ %@", voteAverage];
}

- (UIImage *)imageConverted {
    if (self.imageData) {
        return [UIImage imageWithData:self.imageData];
    } else {
        return [UIImage imageNamed:@"emptyPoster"];
    }
}

- (NSString *)getGenreWithID:(NSNumber *)identifier {
    int intID = [identifier intValue];
    
    switch (intID) {
    case 28:
        return @"Action";
    case 12:
        return @"Adventure";
    case 16:
        return @"Animation";
    case 35:
        return @"Comedy";
    case 80:
        return @"Crime";
    case 99:
        return @"Documentary";
    case 18:
        return @"Drama";
    case 10751:
        return @"Family";
    case 14:
        return @"Fantasy";
    case 36:
        return @"History";
    case 27:
        return @"Horror";
    case 10402:
        return @"Music";
    case 9648:
        return @"Mystery";
    case 10749:
        return @"Romance";
    case 878:
        return @"Science Fiction";
    case 10770:
        return @"TV Movie";
    case 53:
        return @"Thriller";
    case 10752:
        return @"War";
    case 37:
        return @"Western";
    default:
        return @"";
    }
}

@end
