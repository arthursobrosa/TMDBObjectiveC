//
//  DetailsView.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "DetailsView.h"

@interface DetailsView()

// MARK: - UI Properties

@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *genresLabel;
@property (strong, nonatomic) UILabel *ratingsLabel;
@property (strong, nonatomic) UILabel *overviewTitleLabel;
@property (strong, nonatomic) UILabel *overviewLabel;

@end

@implementation DetailsView

// MARK: - Properties

- (void)setMovie:(Movie *)newValue {
    if (_movie != newValue) {
        _movie = newValue;
        
        self.coverImageView.image = [_movie imageConverted];
        self.titleLabel.text = _movie.title;
        self.genresLabel.text = _movie.genres;
        self.ratingsLabel.text = [_movie ratingsFormatted];
        self.overviewLabel.text = _movie.overview;
    }
}

// MARK: - UI Properties

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.layer.cornerRadius = 8;
        _coverImageView.clipsToBounds = YES;
        _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle3];
        _titleLabel.textColor = [UIColor labelColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UILabel *)genresLabel {
    if (!_genresLabel) {
        _genresLabel = [[UILabel alloc] init];
        _genresLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        _genresLabel.textColor = [UIColor lightGrayColor];
        _genresLabel.numberOfLines = 2;
        _genresLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _genresLabel;
}

- (UILabel *)ratingsLabel {
    if (!_ratingsLabel) {
        _ratingsLabel = [[UILabel alloc] init];
        _ratingsLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        _ratingsLabel.textColor = [UIColor lightGrayColor];
        _ratingsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _ratingsLabel;
}

- (UILabel *)overviewTitleLabel {
    if (!_overviewTitleLabel) {
        _overviewTitleLabel = [[UILabel alloc] init];
        _overviewTitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _overviewTitleLabel.textColor = [UIColor labelColor];
        _overviewTitleLabel.text = @"Overview";
        _overviewTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _overviewTitleLabel;
}

- (UILabel *)overviewLabel {
    if (!_overviewLabel) {
        _overviewLabel = [[UILabel alloc] init];
        _overviewLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        _overviewLabel.textColor = [UIColor lightGrayColor];
        _overviewLabel.numberOfLines = -1;
        _overviewLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _overviewLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _overviewLabel;
}


// MARK: - Initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

// MARK: - Methods

- (void)setupUI {
    self.backgroundColor = [UIColor systemBackgroundColor];
    [self addSubview:self.coverImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.genresLabel];
    [self addSubview:self.ratingsLabel];
    [self addSubview:self.overviewTitleLabel];
    [self addSubview:self.overviewLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.coverImageView.heightAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.5],
        [self.coverImageView.widthAnchor constraintEqualToAnchor:self.coverImageView.heightAnchor multiplier:0.7],
        [self.coverImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
        [self.coverImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
        
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.coverImageView.centerYAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.coverImageView.trailingAnchor constant:8],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
        
        [self.genresLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:8],
        [self.genresLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.genresLabel.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor],
        
        [self.ratingsLabel.bottomAnchor constraintEqualToAnchor:self.coverImageView.bottomAnchor constant:-16],
        [self.ratingsLabel.leadingAnchor constraintEqualToAnchor:self.genresLabel.leadingAnchor],
        [self.ratingsLabel.trailingAnchor constraintEqualToAnchor:self.genresLabel.trailingAnchor],
        
        [self.overviewTitleLabel.topAnchor constraintEqualToAnchor:self.coverImageView.bottomAnchor constant:16],
        [self.overviewTitleLabel.leadingAnchor constraintEqualToAnchor:self.coverImageView.leadingAnchor],
        [self.overviewTitleLabel.trailingAnchor constraintEqualToAnchor:self.ratingsLabel.trailingAnchor],
        
        [self.overviewLabel.topAnchor constraintEqualToAnchor:self.overviewTitleLabel.bottomAnchor constant:8],
        [self.overviewLabel.leadingAnchor constraintEqualToAnchor:self.overviewTitleLabel.leadingAnchor],
        [self.overviewLabel.trailingAnchor constraintEqualToAnchor:self.overviewTitleLabel.trailingAnchor],
    ]];
}

@end
