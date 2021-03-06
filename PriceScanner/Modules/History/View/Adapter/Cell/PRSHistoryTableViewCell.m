//
//  PRSHistoryTableViewCell.m
//  PriceScanner
//
//  Created by Александр Чаусов on 07.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSHistoryTableViewCell.h"
#import "PRSHistoryTableCellModel.h"

#import "UILabel+Additions.h"


static CGFloat const mainContainerCornerRadius = 4.f;
static CGFloat const shadowRadius = 4.f;
static CGFloat const shadowOpacity = 0.15f;


@interface PRSHistoryTableViewCell()

@property (nonatomic, strong) IBOutlet UIView *shadowView;
@property (nonatomic, strong) IBOutlet UIView *mainContainerView;
@property (nonatomic, strong) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

@end


@implementation PRSHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureStyle];
    [self configureShadow];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    self.mainContainerView.backgroundColor = highlighted ? [[UIColor blackColor] colorWithAlphaComponent:shadowOpacity] : [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.mainContainerView.backgroundColor = selected ? [[UIColor blackColor] colorWithAlphaComponent:shadowOpacity] : [UIColor whiteColor];
}

#pragma mark - Interface Methods
- (void)configureWithModel:(PRSHistoryTableCellModel *)model {
    self.photoImageView.image = model.photo;
    [self.nameLabel setText:model.name withLineSpacing:@(2.f) letterSpacing:nil];
    self.priceLabel.attributedText = [self buildPriceStringWithPrice:model.price];
}

#pragma mark - Configure
- (void)configureStyle {
    self.mainContainerView.layer.cornerRadius = mainContainerCornerRadius;
    self.mainContainerView.layer.masksToBounds = YES;
    
    self.nameLabel.font = [UIFont systemFontOfSize:12.f weight:UIFontWeightMedium];
    self.nameLabel.textColor = [UIColor prsDarkBlueTextColor];
    
    self.priceLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightBlack];
    self.priceLabel.textColor = [UIColor prsBlackTextColor];
}

- (void)configureShadow {
    self.shadowView.layer.cornerRadius = mainContainerCornerRadius;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    self.shadowView.layer.shadowRadius = shadowRadius;
    self.shadowView.layer.shadowOpacity = shadowOpacity;
}

#pragma mark - Private Methods
/** Метод конфигурирует строку для лейбла с ценой товара */
- (NSAttributedString *)buildPriceStringWithPrice:(NSString *)price {
    NSString *priceString = [NSString stringWithFormat:@"Цена_шаблон".localized, price];
    UIFont *priceTitleFont = [UIFont systemFontOfSize:16.f weight:UIFontWeightLight];
    UIFont *priceValueFont = [UIFont systemFontOfSize:16.f weight:UIFontWeightBlack];
    UIColor *textColor = [UIColor prsBlackTextColor];
    
    NSMutableAttributedString *attributedPrice = [[NSMutableAttributedString alloc] initWithString:priceString
                                                                                        attributes:@{
                                                                                                     NSForegroundColorAttributeName: textColor,
                                                                                                     NSFontAttributeName: priceTitleFont
                                                                                                     }];
    [attributedPrice addAttributes:@{
                                     NSForegroundColorAttributeName: textColor,
                                     NSFontAttributeName: priceValueFont
                                     }
                             range:[priceString rangeOfString:price]];
    return [attributedPrice copy];
}

@end
