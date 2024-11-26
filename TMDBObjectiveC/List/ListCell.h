//
//  ListCell.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface ListCell : UITableViewCell

// MARK: - ID

+ (NSString *)identifier;

// MARK: - Properties

@property (nonatomic, assign) Movie * movie;

@end
