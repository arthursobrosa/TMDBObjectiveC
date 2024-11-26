//
//  ListViewController.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "ListViewModel.h"
#import "ShowingDetails.h"

@interface ListViewController : UIViewController

// MARK: - Coordinator for navigation

@property (weak, nonatomic) NSObject<ShowingDetails> *coordinator;

// MARK: - Initializer

- (instancetype)initWithViewModel:(ListViewModel *)viewModel;

@end
