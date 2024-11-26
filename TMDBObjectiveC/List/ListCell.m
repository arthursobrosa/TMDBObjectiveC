//
//  ListCell.m
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"

@interface ListCell ()

// MARK: - UI Properties

@property (strong, nonatomic) UIImageView * coverImageView;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * overviewLabel;
@property (strong, nonatomic) UILabel * ratingsLabel;

@end

@implementation ListCell

// MARK: - ID

+ (NSString *)identifier {
    static NSString *identifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        identifier = @"listCell";
    });
    return identifier;
}

// MARK: - Properties

- (void)setMovie:(Movie *)newValue {
    if (_movie != newValue) {
        _movie = newValue;
        
        self.coverImageView.image = [_movie imageConverted];
        self.titleLabel.text = _movie.title;
        self.overviewLabel.text = _movie.overview;
        self.ratingsLabel.text = [_movie ratingsFormatted];
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
        _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _titleLabel.textColor = [UIColor labelColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UILabel *)overviewLabel {
    if (!_overviewLabel) {
        _overviewLabel = [[UILabel alloc] init];
        _overviewLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _overviewLabel.textColor = [UIColor grayColor];
        _overviewLabel.numberOfLines = 4;
        _overviewLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _overviewLabel;
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

// MARK: - Initializer

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

// MARK: - Methods

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.overviewLabel];
    [self.contentView addSubview:self.ratingsLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.coverImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [self.coverImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.coverImageView.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.22],
        [self.coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8],
        [self.coverImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8],
        
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.coverImageView.topAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.coverImageView.trailingAnchor constant:8],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
        
        [self.overviewLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:8],
        [self.overviewLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.overviewLabel.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor],
        
        [self.ratingsLabel.bottomAnchor constraintEqualToAnchor:self.coverImageView.bottomAnchor constant:-4],
        [self.ratingsLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.ratingsLabel.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor],
    ]];
}

@end
