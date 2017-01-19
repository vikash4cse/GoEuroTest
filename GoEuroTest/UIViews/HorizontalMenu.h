//
//  HorizontalMenu.h
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TravelTypeTrain,
    TravelTypeBus,
    TravelTypeFlight
} TravelType;

@protocol HorizontalMenuDelegate <NSObject>

@optional
    - (void)didSelectTravelType:(TravelType)travelType;

@end

@interface HorizontalMenu : UIView

@property (nonatomic, weak) IBOutlet id<HorizontalMenuDelegate> delegate;

@end
