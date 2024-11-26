//
//  Coordinator.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#include <UIKit/UIKit.h>

@protocol Coordinator <NSObject>

@property (strong, nonatomic) NSMutableArray<id<Coordinator>> * childCoordinators;
@property (strong, nonatomic) UINavigationController * navigationController;

- (void)start;

@end
