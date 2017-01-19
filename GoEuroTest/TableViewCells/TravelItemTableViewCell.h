//
//  ItemRequestTableViewCell.h
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TravelModel;

@interface TravelItemTableViewCell : UITableViewCell

+ (void)registerWithTableView:(UITableView *)tableView;
+ (NSString *)CellIdentifier;
+ (CGFloat)CellHeight;

- (void)configureCellWithTravelItem:(TravelModel *)model;

@end
