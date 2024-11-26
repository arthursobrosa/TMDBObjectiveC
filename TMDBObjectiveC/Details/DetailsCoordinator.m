//
//  DetailsCoordinator.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "DetailsCoordinator.h"
#import "DetailsViewController.h"

@implementation DetailsCoordinator

@synthesize childCoordinators = _childCoordinators;
@synthesize navigationController = _navigationController;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController movie:(Movie *)movie {
    self = [super init];
    if (self) {
        _childCoordinators = [[NSMutableArray alloc] init];
        _navigationController = navigationController;
        _movie = movie;
    }
    return  self;
}

- (void)start {
    DetailsViewController *viewController = [[DetailsViewController alloc] initWithMovie:self.movie];
    viewController.coordinator = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

/// to use in the future in case you want to dismiss details view controller without being from the native back button
- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
