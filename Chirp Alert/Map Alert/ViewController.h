//
//  ViewController.h
//  Map Alert
//
//  Created by Max von Hippel on 4/4/14.
//  Copyright (c) 2014 Max von Hippel Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate> {
    IBOutlet UILabel *scaleLabel;
    
    
    
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UILabel *scaleLabel;
- (IBAction)updateDistanceToAnnotation:(id)sender;
@end
