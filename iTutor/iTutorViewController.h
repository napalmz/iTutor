//
//  iTutorViewController.h
//  iTutor
//
//  Created by Willy Baessato on 08/10/13.
//  Copyright (c) 2013 Willy Baessato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface iTutorViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *metriRes;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *tutorLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)stopCurrentLocation:(id)sender;
- (IBAction)getCurrentLocation:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
