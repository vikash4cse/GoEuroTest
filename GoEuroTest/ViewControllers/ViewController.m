//
//  ViewController.m
//  GoEuroTest
//
//  Created by Nagarro on 18/01/17.
//  Copyright © 2017 KV. All rights reserved.
//

#import "ViewController.h"
#import "TravelItemTableViewCell.h"
#import "HorizontalMenu.h"
#import "ProjectConstants.h"
#import "NSDate+Formatter.h"
#import "TravelManager.h"
#import "TravelModel.h"
#import "SVProgressHUD.h"
#import "GoEuroTest-Swift.h"

typedef enum : NSUInteger {
    SortingTypePriceAscending,
    SortingTypePriceDescending,
    SortingTypeDeparture,
    SortingTypeArrival,
    SortingTypeDuration
} SortingType;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, HorizontalMenuDelegate, TravelSortingViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *itemsTableView;
@property (nonatomic, weak) IBOutlet HorizontalMenu *horizontalMenu;
@property (nonatomic, weak) IBOutlet UILabel *travelLocation;
@property (nonatomic, weak) IBOutlet UILabel *travelDate;

@property (nonatomic, strong) NSArray *busList;
@property (nonatomic, strong) NSArray *trainList;
@property (nonatomic, strong) NSArray *flightList;

@property (nonatomic, assign) TravelType selectedTravelType;
@property (nonatomic, weak) IBOutlet TravelSortingView *sortingView;

@end

@implementation ViewController

#pragma mark UIViewController Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configureNavigationItems];
    
    self.selectedTravelType = TravelModeBus;
    
    [SVProgressHUD show];
    [self fetchDataForTravelMode:TravelModeBus];
    [self fetchDataForTravelMode:TravelModeTrain];
    [self fetchDataForTravelMode:TravelModeFlight];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [TravelItemTableViewCell registerWithTableView:self.itemsTableView];
    
    self.sortingView.delegate = self;
}

#pragma mark Private Methods

- (void)configureNavigationItems {
    
    self.travelLocation.text = kLocationString;
    self.travelDate.text =  [[NSDate date] formattedDate];
}

- (void)fetchDataForTravelMode:(TravelMode)travelMode {
    
    [[TravelManager sharedInstance] getTravelDataForTravelMode:travelMode onCompletionHandler:^(NSArray *travelData) {
        
        [self populateData:travelData toTravelMode:travelMode];
        [self reloadTableView];
    }];
}

- (void)populateData:(NSArray *)data toTravelMode:(TravelMode)travelMode {
    
    switch (travelMode) {
        case TravelModeTrain:
            self.trainList = [self sortedData:data forSortedType:SortingTypeDeparture];
            break;
            
        case TravelModeBus:
            self.busList = [self sortedData:data forSortedType:SortingTypeDeparture];
            break;
            
        case TravelModeFlight:
            self.flightList = [self sortedData:data forSortedType:SortingTypeDeparture];
            break;
            
        default:
            break;
    }
}

#pragma mark UITableViewDataSource and UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self selectedTravelList] count];
}

- (NSArray *)selectedTravelList {
    
    NSArray *selectedList;
    switch (self.selectedTravelType) {
            
        case TravelTypeBus :
            selectedList = self.busList;
            break;
            
        case TravelTypeTrain :
            selectedList = self.trainList;
            break;

        case TravelTypeFlight :
            selectedList = self.flightList;
            break;

        default:
            selectedList = nil;
    }
    return selectedList;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TravelItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TravelItemTableViewCell CellIdentifier] forIndexPath:indexPath];
    TravelModel *travelModal = [[self selectedTravelList] objectAtIndex:indexPath.row];
    [cell configureCellWithTravelItem:travelModal];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [TravelItemTableViewCell CellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertActionSheet = [UIAlertController
                             alertControllerWithTitle:@"Offer Details"
                             message:@"Offer details are not yet implemented!"
                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * _Nonnull action) {
                             
                             [tableView deselectRowAtIndexPath:indexPath animated:YES];
                         }];
    
    [alertActionSheet addAction:ok];
    [self presentViewController:alertActionSheet animated:YES completion:nil];
}

- (void)reloadTableView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.itemsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [self.itemsTableView setContentOffset:CGPointZero animated:NO];
    });
}

#pragma mark HorizontalMenuDelegate

- (void)didSelectTravelType:(TravelType)travelType {

    self.selectedTravelType = travelType;
    [self reloadTableView];
}

- (NSArray *)sortedData:(NSArray *)data forSortedType:(SortingType)sortingType{
    
    switch (sortingType) {
            
        case SortingTypePriceAscending: {
            
            data = [data sortedArrayUsingComparator:^NSComparisonResult(TravelModel *modal1, TravelModel *modal2){
                return [modal1.priceAmount compare:modal2.priceAmount];
            }];
            break;
        }
            
        case SortingTypePriceDescending: {
            
            data = [data sortedArrayUsingComparator:^NSComparisonResult(TravelModel *modal1, TravelModel *modal2){
                return [modal2.priceAmount compare:modal1.priceAmount];
            }];
            break;
        }
            
        case SortingTypeDeparture: {
            data = [data sortedArrayUsingComparator:^NSComparisonResult(TravelModel *modal1, TravelModel *modal2){
                return [modal1.departureDate compare:modal2.departureDate];
            }];
            break;
        }
            
        case SortingTypeArrival: {
            
            data = [data sortedArrayUsingComparator:^NSComparisonResult(TravelModel *modal1, TravelModel *modal2){
                return [modal1.arrivalDate compare:modal2.arrivalDate];
            }];
            break;
        }
            
        case SortingTypeDuration: {
            
            data = [data sortedArrayUsingComparator:^NSComparisonResult(TravelModel *modal1, TravelModel *modal2){
                return [modal1.totalDuration compare:modal2.totalDuration];
            }];
            break;
        }
            
        default:
            break;
    }
    
    return data;
}

- (void)configureSortingActionSheet {
    
    UIAlertController *sortActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [sortActionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    [sortActionSheet addAction:[UIAlertAction actionWithTitle:@"Price Ascending" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.trainList = [self sortedData:self.trainList forSortedType:SortingTypePriceAscending];
        self.busList = [self sortedData:self.busList forSortedType:SortingTypePriceAscending];
        self.flightList = [self sortedData:self.flightList forSortedType:SortingTypePriceAscending];
        [self reloadTableView];
    }]];
    
    [sortActionSheet addAction:[UIAlertAction actionWithTitle:@"Price Descending" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.trainList = [self sortedData:self.trainList forSortedType:SortingTypePriceDescending];
        self.busList = [self sortedData:self.busList forSortedType:SortingTypePriceDescending];
        self.flightList = [self sortedData:self.flightList forSortedType:SortingTypePriceDescending];
        [self reloadTableView];
    }]];
    
    [sortActionSheet addAction:[UIAlertAction actionWithTitle:@"Departure" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.trainList = [self sortedData:self.trainList forSortedType:SortingTypeDeparture];
        self.busList = [self sortedData:self.busList forSortedType:SortingTypeDeparture];
        self.flightList = [self sortedData:self.flightList forSortedType:SortingTypeDeparture];
        [self reloadTableView];
    }]];
    
    [sortActionSheet addAction:[UIAlertAction actionWithTitle:@"Arrival" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.trainList = [self sortedData:self.trainList forSortedType:SortingTypeArrival];
        self.busList = [self sortedData:self.busList forSortedType:SortingTypeArrival];
        self.flightList = [self sortedData:self.flightList forSortedType:SortingTypeArrival];
        [self reloadTableView];
    }]];
    
    [sortActionSheet addAction:[UIAlertAction actionWithTitle:@"Duration" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.trainList = [self sortedData:self.trainList forSortedType:SortingTypeDuration];
        self.busList = [self sortedData:self.busList forSortedType:SortingTypeDuration];
        self.flightList = [self sortedData:self.flightList forSortedType:SortingTypeDuration];
        [self reloadTableView];
    }]];
    
    [self presentViewController:sortActionSheet animated:YES completion:nil];
}

#pragma mark TravelSortingViewDelegate

- (void)didSelecteSortingButton {
    
    [self configureSortingActionSheet];
}
@end
