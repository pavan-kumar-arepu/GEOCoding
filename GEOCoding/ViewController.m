//
//  ViewController.m
//  GEOCoding
//
//  Created by Pavankumar Arepu on 20/02/2016.
//  Copyright © 2016 ppam. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>


@interface ViewController ()

{
    CLLocationCoordinate2D coords;
    MKMapItem *mapItem;
    NSDictionary *options;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    /*
//    Forward GeoCoding
    
    [geocoder geocodeAddressString:@"IL  62468, Toledo, New Jersy,United States"
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"Geocode failed with error: %@", error);
                         return;
                     }
                     
                     if(placemarks && placemarks.count > 0)
                     {
                         CLPlacemark *placemark = placemarks[0];
                         CLLocation *location = placemark.location;
                          coords = location.coordinate;
                         
                         NSLog(@"\nLatitude = %f, \nLongitude = %f", 
                               coords.latitude, coords.longitude);
                     }
                 }
     ];
    
    */

    
    //Reverse GeoCoding
    
    
    CLLocation *newLocation = [[CLLocation alloc]
                               initWithLatitude:40.74835
                               longitude:-73.984911];
    
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks,
                                       NSError *error) {
                       
                       if (error) {
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       
                       if (placemarks && placemarks.count > 0)
                       {
                           CLPlacemark *placemark = placemarks[0];
                           
                           NSDictionary *addressDictionary =
                           placemark.addressDictionary;
                           
                           NSString *address = [addressDictionary
                                                objectForKey:
                                                (NSString *)kABPersonAddressStreetKey];
                           NSString *city = [addressDictionary
                                             objectForKey:
                                             (NSString *)kABPersonAddressCityKey];
                           NSString *state = [addressDictionary 
                                              objectForKey:
                                              (NSString *)kABPersonAddressStateKey];
                           NSString *zip = [addressDictionary 
                                            objectForKey:
                                            (NSString *)kABPersonAddressZIPKey];
                           
                           NSLog(@"My New Address: \nAddress: %@ \nCity: %@ \nState:%@ \nZip:%@", address,city, state, zip);
                       }
                   }];
    
    
    
    
     coords = CLLocationCoordinate2DMake(40.74835, -73.984911);
    
     NSDictionary *address = @{
                              (NSString *)kABPersonAddressStreetKey: @"350 5th Avenue",
                              (NSString *)kABPersonAddressCityKey: @"New York",
                              (NSString *)kABPersonAddressStateKey: @"NY",
                              (NSString *)kABPersonAddressZIPKey: @"10118",
                              (NSString *)kABPersonAddressCountryCodeKey: @"US"
                              };
    
    MKPlacemark *place = [[MKPlacemark alloc] 
                          initWithCoordinate:coords addressDictionary:address];
 
    mapItem = [[MKMapItem alloc]  initWithPlacemark:place];
    
   //MKMapItem *item = [MKMapItem mapItemForCurrentLocation];
    
    
    
   options = @{
                              MKLaunchOptionsDirectionsModeKey:
                                  MKLaunchOptionsDirectionsModeDriving,
                              MKLaunchOptionsMapTypeKey:
                                  [NSNumber numberWithInteger:MKMapTypeSatellite],
                              MKLaunchOptionsShowsTrafficKey:@YES
                            };
    
      //[mapItem openInMapsWithLaunchOptions:options];

    
    mapItem.name = @"Empire State Building";
    mapItem.phoneNumber = @"+12127363100";
    mapItem.url = [NSURL URLWithString:@"http://www.esbnyc.com/"];
 


    
//    NSArray *mapItems = @[mapItem];
//    [MKMapItem openMapsWithItems:mapItems launchOptions:options];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openiOSMapsWithMapItem:(id)sender
{
    [mapItem openInMapsWithLaunchOptions:options];

}
@end
