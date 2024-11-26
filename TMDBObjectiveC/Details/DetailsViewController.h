//
//  DetailsViewController.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "Dismissing.h"

@interface DetailsViewController : UIViewController

// MARK: - Coordinator for navigation

@property (weak, nonatomic) NSObject<Dismissing> *coordinator;

// MARK: - Properties

@property (strong, nonatomic) Movie *movie;

// MARK: - Initializer

- (instancetype)initWithMovie:(Movie *)movie;

@end
