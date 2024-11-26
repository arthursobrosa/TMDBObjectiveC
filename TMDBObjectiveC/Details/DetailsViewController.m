//
//  DetailsViewController.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit//UIKit.h>
#import "DetailsViewController.h"
#import "DetailsView.h"

@interface DetailsViewController()

@property (strong, nonatomic) DetailsView *detailsView;

@end

@implementation DetailsViewController

// MARK: - UI Properties

- (UIView *)detailsView {
    if (!_detailsView) {
        _detailsView = [[DetailsView alloc] init];
        _detailsView.movie = self.movie;
        _detailsView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _detailsView;
}

// MARK: - Initializer

- (instancetype)initWithMovie:(Movie *)movie {
    self = [super init];
    if (self) {
        _movie = movie;
    }
    return self;
}

// MARK: - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navigationItem.title = @"Details";
}

// MARK: - Methods

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self.view addSubview:self.detailsView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.detailsView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.detailsView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.detailsView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.detailsView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

@end
