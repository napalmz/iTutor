//
//  iTutorViewController.m
//  iTutor
//
//  Created by Willy Baessato on 08/10/13.
//  Copyright (c) 2013 Willy Baessato. All rights reserved.
//

#import "iTutorViewController.h"

@interface iTutorViewController ()

@end

@implementation iTutorViewController

CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;

double tutorValue = 130; // Default
double metriAuto  = 0; // Default
double metriTutor = 0; // Default

@synthesize tutorLabel, speedLabel, activityIndicator, mapView, mySlider, metriRes;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    [mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    MKUserLocation *userLocation = mapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 50, 50);
    [mapView setRegion:region animated:NO];
    metriRes.text = [NSString stringWithFormat:@"0"];
    tutorLabel.text = [NSString stringWithFormat:@"%.f km/h",tutorValue];
    speedLabel.text = [NSString stringWithFormat:@"-- km/h"];
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [activityIndicator startAnimating];
    [locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    int calcMs = currentLocation.speed;
    double calcKmh;
    int metriDiff;

    // solve the -1 problem
    if(calcMs == -1) {
        calcKmh = 0;
    } else {
        calcKmh = calcMs * 3.6;
    }
    
    if (currentLocation != nil) {
        speedLabel.text = [NSString stringWithFormat:@"%.f km/h",calcKmh];
        metriAuto = metriAuto + calcMs;
        metriTutor = metriTutor + (tutorValue / 3.6);
        metriDiff = metriTutor - metriAuto;
        if (metriDiff < 0) {
            metriRes.textColor = [UIColor redColor];
        } else {
            metriRes.textColor = [UIColor greenColor];
        }
        metriRes.text = [NSString stringWithFormat:@"%.f metri", metriTutor - metriAuto];
        
    }
}

- (IBAction)stopCurrentLocation:(id)sender {
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    [activityIndicator stopAnimating];
    speedLabel.text = [NSString stringWithFormat:@"-- km/h"];
    metriRes.text = [NSString stringWithFormat:@"0"];
    metriRes.textColor = [UIColor clearColor];
    metriAuto  = 0;
    metriTutor = 0;
}

- (IBAction)sliderChanged:(id)sender {
    tutorValue = lroundf(mySlider.value);
    [mySlider setValue:tutorValue animated:YES];
    tutorLabel.text = [NSString stringWithFormat:@"%.f km/h",tutorValue];
}
@end
