//
//  ListCoordinator.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "Coordinator.h"
#import "ShowingDetails.h"

@interface ListCoordinator : NSObject <Coordinator, ShowingDetails, UINavigationControllerDelegate>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
