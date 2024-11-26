//
//  DetailsCoordinator.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "Coordinator.h"
#import "Movie.h"
#import "Dismissing.h"

@interface DetailsCoordinator : NSObject<Coordinator, Dismissing>

@property (weak, nonatomic) NSObject<Coordinator> *parentCoordinator;
@property (strong, nonatomic) Movie *movie;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController movie:(Movie *)movie;

@end
