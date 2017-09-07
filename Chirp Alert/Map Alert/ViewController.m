//
//  ViewController.m
//  Map Alert
//
//  Created by Max von Hippel on 4/4/14.
//  Copyright (c) 2014 Max von Hippel Development. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize scaleLabel, mapView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    [self updateDistanceToAnnotation];
    [NSTimer scheduledTimerWithTimeInterval:900.0 target:self
                                   selector:@selector(updateDistanceToAnnotation) userInfo:nil repeats:YES];
    

   
    
}
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
    //set frame size
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 2000000, 2000000);
	[mv setRegion:region animated:YES];
	[mv selectAnnotation:mp animated:YES];
    
}
/*- (void)mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated {
    
    MKCoordinateSpan span = mapView.region.span;
    
    NSString * scaleString = [NSString stringWithFormat:@" 1 = ~111 km -> %f = ~ %f", span.latitudeDelta, span.latitudeDelta*16.5671642];
    
    NSLog(@"%@", scaleString);
    //self.scaleLabel.text = scaleString;
    
    
    NSArray *listItems = [scaleString componentsSeparatedByString:@" "];
    NSString *lastWordString = [NSString stringWithFormat:@"%@", listItems.lastObject];
    //self.scaleLabel.text = lastWordString;
    //TEST INT
    int kmScaleInteger = [lastWordString intValue];
    self.scaleLabel.text = [NSString stringWithFormat:@"%d km", kmScaleInteger];
  
    
}*/

-(void)updateDistanceToAnnotation
{
    
    
    if (mapView.userLocation.location == nil)
    {
        scaleLabel.text = @"User location unknown";
        return;
    }
    
    CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:9.939685974729212 longitude:-84.1810147847774];
    
    
    
    
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:mapView.userLocation.coordinate.latitude
                                longitude:mapView.userLocation.coordinate.longitude];
    
    CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    
    [scaleLabel setText: [NSString stringWithFormat:@"Distance to point %4.0f m.", distance]];
    if (distance < 100) {
        NSDate *alertTime = [[NSDate date]
                             dateByAddingTimeInterval:10];
        UIApplication* app = [UIApplication sharedApplication];
        UILocalNotification* notifyAlarm = [[UILocalNotification alloc]
                                            init];
        if (notifyAlarm)
        {
            notifyAlarm.fireDate = alertTime;
            notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
            notifyAlarm.repeatInterval = 0;
            //notifyAlarm.soundName = @"bell_tree.mp3";
            notifyAlarm.alertBody = @"You are in a self-identified danger zone.";
            [app scheduleLocalNotification:notifyAlarm];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDistanceToAnnotation:(id)sender {
    if (mapView.userLocation.location == nil)
    {
        scaleLabel.text = @"User location unknown";
        return;
    }
    
    CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:9.939685974729212 longitude:-84.1810147847774];
    
    
    
    
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:mapView.userLocation.coordinate.latitude
                                longitude:mapView.userLocation.coordinate.longitude];
    
    CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    
    [scaleLabel setText: [NSString stringWithFormat:@"Distance to point %4.0f m.", distance]];
    if (distance < 100) {
        NSDate *alertTime = [[NSDate date]
                             dateByAddingTimeInterval:10];
        UIApplication* app = [UIApplication sharedApplication];
        UILocalNotification* notifyAlarm = [[UILocalNotification alloc]
                                            init];
        if (notifyAlarm)
        {
            notifyAlarm.fireDate = alertTime;
            notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
            notifyAlarm.repeatInterval = 0;
            //notifyAlarm.soundName = @"bell_tree.mp3";
            notifyAlarm.alertBody = @"You are in a self-identified danger zone.";
            [app scheduleLocalNotification:notifyAlarm];
        }

    }
}
@end
