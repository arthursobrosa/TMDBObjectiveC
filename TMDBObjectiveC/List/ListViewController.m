//
//  ListViewController.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import "ListViewController.h"
#import "ListCell.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

// MARK: - View Model

@property (strong, nonatomic) ListViewModel * viewModel;

// MARK: - UI Properties

@property (strong, nonatomic) UITableView * tableView;

// MARK: - Properties

@property (strong, nonatomic) NSArray<Movie *> *movies;

@end

@implementation ListViewController

// MARK: - Properties

- (NSArray<Movie *> *)movies {
    if (!_movies) {
        _movies = @[];
    }
    return _movies;
}

// MARK: - UI Properties

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView registerClass:[ListCell class] forCellReuseIdentifier:ListCell.identifier];
    }
    return _tableView;
}

// MARK: - Initializer

- (instancetype)initWithViewModel:(ListViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

// MARK: - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.viewModel.onFetchMovies = ^(NSArray<Movie *> *movies) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.movies = movies;
        [strongSelf reloadTable];
    };
    
    [self setupUI];
    self.navigationItem.title = @"Movies";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel fetchMovies];
}

// MARK: - Methods

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

- (void)reloadTable {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.tableView reloadData];
    });
}

// MARK: - Table View DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Popular";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCell.identifier forIndexPath:indexPath];

    if (!cell) {
        NSAssert(NO, @"Could not dequeue list cell");
    }
    
    Movie *movie = self.movies[indexPath.row];
    cell.movie = movie;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Movie *movie = self.movies[indexPath.row];
    [self.coordinator showDetailsForMovie:movie];
}

@end
