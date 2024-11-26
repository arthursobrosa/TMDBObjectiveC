//
//  Movie.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit//UIKit.h>

@interface Movie : NSObject <NSCoding>

// MARK: - Attributes

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * overview;
@property (strong, nonatomic) NSNumber * vote_average;
@property (strong, nonatomic) NSString * poster_path;
@property (strong, nonatomic) NSArray<NSNumber *> * genre_ids;

@property (strong, nonatomic) NSData * imageData;
@property (nonatomic, readonly) NSString * genres;

// MARK: - Initializer

- (instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview vote_average:(NSNumber *)vote_average posterPath:(NSString *)poster_path genre_ids:(NSArray<NSNumber *> *)genre_ids;

// MARK: - Methods

-(NSString *)ratingsFormatted;
-(UIImage *)imageConverted;

@end
