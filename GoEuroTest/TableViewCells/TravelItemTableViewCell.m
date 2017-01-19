//
//  ItemRequestTableViewCell.m
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "TravelItemTableViewCell.h"
#import "TravelModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TravelItemTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *travelDuration;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStops;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIView *departureDots;
@property (weak, nonatomic) IBOutlet UIView *arrivalDots;
@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;

@end

@implementation TravelItemTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

+ (NSString *)CellIdentifier {
    
    return NSStringFromClass([self class]);
}

+ (void)registerWithTableView:(UITableView *)tableView {
    
    [tableView registerNib:[UINib nibWithNibName:[TravelItemTableViewCell CellIdentifier] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[TravelItemTableViewCell CellIdentifier]];
}

+ (CGFloat)CellHeight {
    
    return 100.0f;
}

- (void)configureCellWithTravelItem:(TravelModel *)model {
    
    [self configurePriceLabel:model.priceInEuros];
    [self configureStopsLabel:model.numberOfStops];
    [self congigureTimeLabel:model];
    [self.logo sd_setImageWithURL:model.logoURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self.activityIndicator stopAnimating];
    }];
}

- (void)configurePriceLabel:(NSString *)priceInEuros {
    
    NSRange range = [priceInEuros rangeOfString:@"."];
    range.length = priceInEuros.length - range.location;
    NSDictionary *beforeDecimalAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:18],
                                               NSForegroundColorAttributeName : [UIColor blackColor] };
    NSDictionary *afterDecimalAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:14],
                                              NSForegroundColorAttributeName : [UIColor blackColor] };
    
    NSMutableAttributedString *attributedPriceString = [[NSMutableAttributedString alloc] initWithString:priceInEuros attributes:beforeDecimalAttributes];
    [attributedPriceString setAttributes:afterDecimalAttributes range:range];
    self.price.attributedText = attributedPriceString;
    
}

- (void)configureStopsLabel:(NSNumber *)stops {
    
    if(stops && [stops intValue]>0) {
        
        self.numberOfStops.text = [NSString stringWithFormat:@"%d stops",[stops intValue]];
        if([stops intValue] == 1) {
            
            self.numberOfStops.text = @"1 stop";
        }
    } else {
        
        self.numberOfStops.text = @"Non Stop";
    }
}

- (void) congigureTimeLabel:(TravelModel *)item {
    
    self.departureDots.layer.cornerRadius = self.departureDots.bounds.size.height/2;
    self.arrivalDots.layer.cornerRadius = self.arrivalDots.bounds.size.height/2;
    
    NSTimeInterval interval = [item.arrivalDate timeIntervalSinceDate:item.departureDate];
    int hours = (int)interval / 3600;
    int minutes = (interval - (hours*3600)) / 60;
    NSString *timeDiff = [NSString stringWithFormat:@"%d:%02dh", hours, minutes];
    
    self.travelDuration.text = timeDiff;
    self.departureTimeLabel.text = item.departureTime;
    self.arrivalTimeLabel.text = item.arrivalTime;
}

@end
