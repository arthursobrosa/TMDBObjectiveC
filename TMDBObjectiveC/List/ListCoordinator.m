//
//  ListCoordinator.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "ListCoordinator.h"
#import "ListViewModel.h"
#import "ListViewController.h"
#import "DetailsCoordinator.h"
#import "DetailsViewController.h"

@interface ListCoordinator()

-(void)childDidFinish:(id<Coordinator>)child;

@end

@implementation ListCoordinator

@synthesize childCoordinators = _childCoordinators;
@synthesize navigationController = _navigationController;

-(instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _childCoordinators = [[NSMutableArray alloc] init];
        _navigationController = navigationController;
    }
    return self;
}

- (void)start {
    self.navigationController.delegate = self;
    ListViewModel *viewModel = [[ListViewModel alloc] init];
    ListViewController *viewController = [[ListViewController alloc] initWithViewModel:viewModel];
    viewController.coordinator = self;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.navigationController pushViewController:viewController animated:NO];
}

- (void)showDetailsForMovie:(Movie *)movie {
    DetailsCoordinator *child = [[DetailsCoordinator alloc] initWithNavigationController:self.navigationController movie:movie];
    child.parentCoordinator = self;
    [self.childCoordinators addObject:child];
    [child start];
}

- (void)childDidFinish:(id<Coordinator>)child {
    for (NSInteger index = 0; index < self.childCoordinators.count; index++) {
        id<Coordinator> coordinator = self.childCoordinators[index];
        if (coordinator == (id<Coordinator>)child) {
            [self.childCoordinators removeObjectAtIndex:index];
            break;
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *fromVC = [navigationController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!fromVC) { return; }
    
    if ([navigationController.viewControllers containsObject:fromVC]) {
        return;
    }
    
    if ([fromVC isKindOfClass:[DetailsViewController class]]) {
        
        NSObject<Dismissing> *dismissingCoordinator = ((DetailsViewController *)fromVC).coordinator;
        
        id<Coordinator> coordinator = (id<Coordinator>)dismissingCoordinator;
        
        if ([coordinator conformsToProtocol:@protocol(Coordinator)]) {
            [self childDidFinish:coordinator];
        }
    }
}

@end
