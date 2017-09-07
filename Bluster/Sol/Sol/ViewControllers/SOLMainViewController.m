//
//  SOLMainViewController.m
//  Sol
//
//  Created by Comyar Zaheri on 7/30/13.
//  Copyright (c) 2013 Comyar Zaheri. All rights reserved.
//

#import "SOLMainViewController.h"
#import "SOLPagingScrollView.h"
#import "SOLStateManager.h"
#import "SOLWeatherData.h"
#import "UIImage+ImageEffects.h"
#import "UIView+Screenshot.h"

/** Constants */
#define kMIN_TIME_SINCE_UPDATE          3600
#define kMAX_NUM_WEATHER_VIEWS          5
#define kLOCAL_WEATHER_VIEW_TAG         0
#define kDEFAULT_BACKGROUND_GRADIENT    @"gradient5"

#pragma mark - SOLMainViewController Class Extension

@interface SOLMainViewController ()

/// Redefinition of location manager
@property (strong, nonatomic) CLLocationManager     *locationManager;

/// Dictionary of all weather data being managed by the app
@property (strong, nonatomic) NSMutableDictionary   *weatherData;

/// Ordered-List of weather tags
@property (strong, nonatomic) NSMutableArray        *weatherTags;

/// Formats weather data timestamps
@property (strong, nonatomic) NSDateFormatter       *dateFormatter;

@property (assign, nonatomic) BOOL                  isScrolling;

/////////////////////////////////////////////////////////////////////////////
/// @name View Controllers
/////////////////////////////////////////////////////////////////////////////

/// View controller for changing settings
@property (strong, nonatomic) SOLSettingsViewController     *settingsViewController;
/// View controller for adding new locations
@property (strong, nonatomic) SOLAddLocationViewController  *addLocationViewController;

/////////////////////////////////////////////////////////////////////////////
/// @name Subviews
/////////////////////////////////////////////////////////////////////////////

/// Dark, semi-transparent view to sit above the homescreen
@property (strong, nonatomic) UIView              *darkenedBackgroundView;

/// Label displaying the Sol° logo
@property (strong, nonatomic) UILabel             *solLogoLabel;

/// Label displaying the name of the app
@property (strong, nonatomic) UILabel             *solTitleLabel;

/// Contains blurred screenshots of this controller's view when transitioning to another controller
@property (strong, nonatomic)  UIImageView        *blurredOverlayView;

/// Buton used to transition to the settings view controller
@property (strong, nonatomic) UIButton            *settingsButton;

/// Button used to transition to the add location view controller
@property (strong, nonatomic) UIButton            *addLocationButton;

/// Page control displaying the number of pages managed by the paging scroll view
@property (strong, nonatomic) UIPageControl       *pageControl;

/// Paging scroll view to manage weather views
@property (strong, nonatomic) SOLPagingScrollView *pagingScrollView;
//my label!!!
//////////////////////////////
/////////////////////////////
////////////////////////////
//@property (strong, nonatomic) UILabel             *quoteLabel;
@end

#pragma mark - SOLMainViewController Implementation

@implementation SOLMainViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        /// Initialize the weather data dictionary with saved data, if it exists
        NSDictionary *savedWeatherData = [SOLStateManager weatherData];
        if(savedWeatherData) {
            self.weatherData = [NSMutableDictionary dictionaryWithDictionary:savedWeatherData];
        } else {
            self.weatherData = [NSMutableDictionary dictionaryWithCapacity:5];
        }
        
        /// Initialize the weather tags array with saved data, if it exists
        NSArray *savedWeatherTags = [SOLStateManager weatherTags];
        if(savedWeatherTags) {
            self.weatherTags = [NSMutableArray arrayWithArray:savedWeatherTags];
        } else {
            self.weatherTags = [NSMutableArray arrayWithCapacity:4];
        }
        
        /// Configure Date Formatter
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"EEE MMM d, h:mm a"];
        
        /// Initialize and configure the location manager and start updating the user's current location
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        self.locationManager.distanceFilter = 3000;
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        
        /// Initialize other properties
        [self initializeViewControllers];
        [self initializeSubviews];
        [self initializeSettingsButton];
        [self initializeAddLocationButton];
        
        /// Hide add location button if we have reached the maximum number of views
        if([self.weatherData count] >= kMAX_NUM_WEATHER_VIEWS) {
            self.addLocationButton.hidden = YES;
        }
        
        /// The blurred overlay view should sit in front of all other subviews
        [self.view bringSubviewToFront:self.blurredOverlayView];
    }
    return self;
}

- (void)initializeViewControllers
{
    /// Initialize the add location view controller
    self.addLocationViewController = [[SOLAddLocationViewController alloc]init];
    self.addLocationViewController.delegate = self;
    
    /// Initialize the settings view controller
    self.settingsViewController = [[SOLSettingsViewController alloc]init];
    self.settingsViewController.delegate = self;
}


- (void)initializeSubviews
{
    
   
    
    /// Initialize the darkended background view
    self.darkenedBackgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.darkenedBackgroundView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    [self.view addSubview:self.darkenedBackgroundView];
    
    /// Initialize the Sol° logo label
    self.solLogoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.solLogoLabel.center = CGPointMake(self.view.center.x, 0.5 * self.view.center.y);
    self.solLogoLabel.font = [UIFont fontWithName:CLIMACONS_FONT size:200];
    self.solLogoLabel.backgroundColor = [UIColor clearColor];
    self.solLogoLabel.textColor = [UIColor whiteColor];
    self.solLogoLabel.textAlignment = NSTextAlignmentCenter;
    self.solLogoLabel.text = [NSString stringWithFormat:@"%c", ClimaconSun];
    [self.view addSubview:self.solLogoLabel];
    //////
    /////
    ////
    ///
    //
    
    /*self.quoteLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 64)];
    self.quoteLabel.center = CGPointMake(self.view.center.x, 0.5 * self.view.center.y);
    self.quoteLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100];
    self.quoteLabel.backgroundColor = [UIColor clearColor];
    self.quoteLabel.textColor = [UIColor whiteColor];
    self.quoteLabel.textAlignment = NSTextAlignmentCenter;
    //self.quoteLabel.text = [NSString stringWithFormat:@"%c", ClimaconSun];
    self.quoteLabel.text = @"hotdogs rule!";
    
    [self.view addSubview:self.quoteLabel];*/
    //
    ///
    ////
    /////
    //////
    ///////
    /// Initialize the Sol° title label
    self.solTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    self.solTitleLabel.center = self.view.center;
    self.solTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:64];
    self.solTitleLabel.backgroundColor = [UIColor clearColor];
    self.solTitleLabel.textColor = [UIColor whiteColor];
    self.solTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.solTitleLabel.text = @"Sol°";
    [self.view addSubview:self.solTitleLabel];

    /// Initialize the paging scroll wiew
    self.pagingScrollView = [[SOLPagingScrollView alloc]initWithFrame:self.view.bounds];
    self.pagingScrollView.delegate = self;
    [self.view addSubview:self.pagingScrollView];
    
    /// Initialize the page control
    self.pageControl = [[UIPageControl alloc]initWithFrame: CGRectMake(0, CGRectGetHeight(self.view.bounds) - 32,
                                                                       CGRectGetWidth(self.view.bounds), 32)];
    [self.pageControl setHidesForSinglePage:YES];
    [self.view addSubview:self.pageControl];
    
    /// Initialize the blurred overlay view
    self.blurredOverlayView = [[UIImageView alloc]initWithImage:[[UIImage alloc]init]];
    [self.blurredOverlayView setFrame:self.view.bounds];
    [self.view addSubview:self.blurredOverlayView];
}

- (void)initializeAddLocationButton
{
    self.addLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *plusLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [plusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:40]];
    [plusLabel setTextAlignment:NSTextAlignmentCenter];
    [plusLabel setTextColor:[UIColor whiteColor]];
    [plusLabel setText:@"+"];
    [self.addLocationButton addSubview:plusLabel];
    [self.addLocationButton setFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 44, CGRectGetHeight(self.view.bounds) - 54, 44, 44)];
    [self.addLocationButton setShowsTouchWhenHighlighted:YES];
    [self.addLocationButton addTarget:self action:@selector(addLocationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addLocationButton];
}

- (void)initializeSettingsButton
{
    self.settingsButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [self.settingsButton setTintColor:[UIColor whiteColor]];
    [self.settingsButton setFrame:CGRectMake(4, CGRectGetHeight(self.view.bounds) - 48, 44, 44)];
    [self.settingsButton setShowsTouchWhenHighlighted:YES];
    [self.settingsButton addTarget:self action:@selector(settingsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingsButton];
}

- (void)initializeLocalWeatherView
{
    SOLWeatherView *localWeatherView = [[SOLWeatherView alloc]initWithFrame:self.view.bounds];
    localWeatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kDEFAULT_BACKGROUND_GRADIENT]];
    localWeatherView.local = YES;
    localWeatherView.delegate = self;
    localWeatherView.tag = kLOCAL_WEATHER_VIEW_TAG;
    [self.pagingScrollView addSubview:localWeatherView];
    self.pageControl.numberOfPages += 1;
    
    SOLWeatherData *localWeatherData = [self.weatherData objectForKey:[NSNumber numberWithInteger:kLOCAL_WEATHER_VIEW_TAG]];
    if(localWeatherData) {
        [self updateWeatherView:localWeatherView withData:localWeatherData];
    }
}

- (void)initializeNonlocalWeatherViews
{
    for(NSNumber *tagNumber in self.weatherTags) {
        /// Initialize a new weather view for all weather data not belonging to the local weather view
        SOLWeatherData *weatherData = [self.weatherData objectForKey:tagNumber];
        if(weatherData) {
            SOLWeatherView *weatherView = [[SOLWeatherView alloc]initWithFrame:self.view.bounds];
            weatherView.delegate = self;
            weatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient5.png"]];
            weatherView.tag = tagNumber.integerValue;
            weatherView.local = NO;
            self.pageControl.numberOfPages += 1;
            [self.pagingScrollView addSubview:weatherView isLaunch:YES];
            [self updateWeatherView:weatherView withData:weatherData];
        }
    }
}

#pragma mark Using a SOLMainViewController

- (void)showBlurredOverlayView:(BOOL)show
{
    if(show) {
        /// Take a screen shot of this controller's view
        [self.view screenshotAsyncWithCompletion: ^ (UIImage *image) {
            /// Blur the screen shot
            UIImage *blurred = [image applyBlurWithRadius:16.0
                                                   tintColor:[UIColor colorWithWhite:0.5 alpha:0.2]
                                       saturationDeltaFactor:2.0
                                                   maskImage:nil];
            /// Set the blurred overlay view's image with the blurred screenshot
            self.blurredOverlayView.image = blurred;
            
            [UIView animateWithDuration:0.3 animations: ^ {
                self.blurredOverlayView.alpha = 1.0;
            }];
        }];
    }
    
    /// Fade the blurred overlay view out
    [UIView animateWithDuration:0.3 animations: ^ {
        self.blurredOverlayView.alpha = 0.0;
    }];
}

#pragma mark Updating Weather Data

- (void)updateWeatherData
{
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.local == NO) {
            
            /// Only update non local weather data
            SOLWeatherData *weatherData = [self.weatherData objectForKey:[NSNumber numberWithInteger:weatherView.tag]];
            
            /// Only update if the minimum time for updates has passed
            if([[NSDate date]timeIntervalSinceDate:weatherData.timestamp] >= kMIN_TIME_SINCE_UPDATE || !weatherView.hasData) {
                
                /// If the weather view is already showing data, we need to move the activity indicator
                if(weatherView.hasData) {
                    weatherView.activityIndicator.center = CGPointMake(weatherView.center.x, 1.8 * weatherView.center.y);
                }
                [weatherView.activityIndicator startAnimating];
                
                /// Make the data download request, Block based
                [[SOLWundergroundDownloader sharedDownloader]dataForPlacemark:weatherData.placemark
                                                                      withTag:weatherView.tag
                                                                   completion: ^ (SOLWeatherData *data, NSError *error) {
                    if (data) {
                        // Success
                        [self downloadDidFinishWithData:data withTag:weatherView.tag];
                    } else {
                        // Failure
                        [self downloadDidFailForWeatherViewWithTag:weatherView.tag];
                    }
                }];
                
            }
        }
    }
}

- (void)downloadDidFailForWeatherViewWithTag:(NSInteger)tag
{
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.tag == tag) {
            
            /// If the weather view doesn't have any data, show a failure message
            if(!weatherView.hasData) {
                weatherView.conditionIconLabel.text = @"☹";
                weatherView.conditionDescriptionLabel.text = @"Update Failed";
                weatherView.locationLabel.text = @"Check your network connection";
            }
            
            /// Stop the weather view's activity indicator
            [weatherView.activityIndicator stopAnimating];
        }
    }
}

- (void)downloadDidFinishWithData:(SOLWeatherData *)data withTag:(NSInteger)tag
{
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.tag == tag) {
            [self.weatherData setObject:data forKey:[NSNumber numberWithInt:(int)tag]];
            
            /// Update the weather view with the downloaded data
            [self updateWeatherView:weatherView withData:data];
            [weatherView.activityIndicator stopAnimating];
        }
    }
    
    /// Save the downloaded data
    [SOLStateManager setWeatherData:self.weatherData];
    if([self.weatherData count] >= kMAX_NUM_WEATHER_VIEWS) {
        self.addLocationButton.hidden = YES;
    }
}

- (void)updateWeatherView:(SOLWeatherView *)weatherView withData:(SOLWeatherData *)data
{
    if(!data) {
        return;
    }
    
    weatherView.hasData = YES;
    
    /// Set the update time
    weatherView.updatedLabel.text = [NSString stringWithFormat:@"Updated %@", [self.dateFormatter stringFromDate:data.timestamp]];
    
    /// Set the current condition icon and description
    weatherView.conditionIconLabel.text         = data.currentSnapshot.icon;
    weatherView.conditionDescriptionLabel.text  = data.currentSnapshot.conditionDescription;
    
    /// Only show the country name if not the United States
    NSString *city      = data.placemark.locality;
    NSString *state     = data.placemark.administrativeArea;
    NSString *country   = data.placemark.country;
    if([[country lowercaseString] isEqualToString:@"united states"]) {
        weatherView.locationLabel.text = [NSString stringWithFormat:@"%@, %@", city, state];
    } else {
        weatherView.locationLabel.text = [NSString stringWithFormat:@"%@, %@", city, country];
    }
    
    SOLTemperature currentTemperature   = data.currentSnapshot.currentTemperature;
    SOLTemperature highTemperature      = data.currentSnapshot.highTemperature;
    SOLTemperature lowTemperature       = data.currentSnapshot.lowTemperature;
    
    NSCalendar *gregorian1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps1 = [gregorian1 components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    int weekday1 = (int)[comps1 weekday];
    
    
    /// Set the temperature labels depending on the current scale set in the settings
    if([SOLStateManager temperatureScale] == SOLFahrenheitScale) {
        weatherView.currentTemperatureLabel.text = [NSString stringWithFormat:@"%.0f°", currentTemperature.fahrenheit];
        //weatherView.currentTemperatureLabel.text = [NSString stringWithFormat:@"%.0f°", currentTemperature.fahrenheit];
        weatherView.hiloTemperatureLabel.text = [NSString stringWithFormat:@"H %.0f  L %.0f", highTemperature.fahrenheit, lowTemperature.fahrenheit];
         CGFloat fahrenheit = MIN(MAX(0, currentTemperature.fahrenheit), 99);
        NSString *quoteINT = [NSString stringWithFormat:@"%d", (int)floor(fahrenheit / 10.0)];
         NSScanner *scanner = [NSScanner scannerWithString:quoteINT];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        [scanner scanCharactersFromSet:numbers intoString:&quoteINT];
        int number = (int)[quoteINT integerValue];
        NSLog(@"%d number whuuut", number);
        
        
        
        
        if (number == 0) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"JESUS: I am the Way, the Truth, and the Life.  Cold comes to the Land through snow.";
            }
            else if (weekday1 == 2) {
                weatherView.quoteLabel.text = @"JESUS: A new command I give you: Warm one another. As I have warmed you, so you must warm one another.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"JESUS: Let the one among you who is without jacket be the first to borrow a wind-breaker.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"JESUS: And know that I am with you always; yes, to the bottom of the thermometer.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"JESUS: Therefore do not be anxious about tomorrow, for tomorrow will be just as cold.  Sufficient for the day is its own wind chill.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"JESUS: Blessed are those who hunger and thirst for some sunlight, for they shall be satisfied come summer.";
            }
            else {
                weatherView.quoteLabel.text = @"JESUS: The cold cometh not, but for to chill, and to annoy, and to freeze.";
            }
        }
        else if (number == 1) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"BIG: Excellence is my presence. Never tense, never hesitant.  Gotta move to stay warm.";
            }
            else if (weekday1 == 2) {
              weatherView.quoteLabel.text = @"BIG: And every day without rain you get, ya gotta work hard for it.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"BIG: I’m living everyday like a hustle. Keeps me warm to juggle, catching balls in the cold is a struggle.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"BIG: I don’t wanna be cold no mo’…sometimes I hear my Mom with extra organic hot chocolate knocking at my front do’.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"BIG: Biggie Smalls is the illest. Your style is played out, I got the flu 'cause it's cold out, no dollah billahs.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"BIG: And snow banks know they soft like a Twinkie fillin’, I'm snow castle buildin'.";
            }
            else {
               weatherView.quoteLabel.text = @"BIG: Stay far from cold. If ya heart’s in it for understanding bayesian weather statistics the sky’s the limit.";
            }
        }
        else if (number == 2) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"YOGI BERRA: You can observe a lot of ice just by looking.";
            }
            else if (weekday1 == 2) {
             weatherView.quoteLabel.text = @"YOGI BERRA: A snowflake ain't worth a bunch of water and a dust particle anymore.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"YOGI BERRA: Weather statistics are ninety percent statistics and the other half are the basic mathematics of physics.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"YOGI BERRA: The forecast ain't what it used to be.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"YOGI BERRA: If you come to a fork in the road, be glad it is warm enough for you to be out walking.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"YOGI BERRA: Rain, snow, and other falling chunks of water ain't over 'till they over.";
            }
            else {
                weatherView.quoteLabel.text = @"YOGI BERRA: I just want to thank everyone who made this forecast necessary.";
            }
            
            
        }
        else if (number == 3) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"GHANDI: Where there is a mild chill there is you.";
            }
            else if (weekday1 == 2) {
              weatherView.quoteLabel.text = @"GHANDI: Where there is heat there is life.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"GHANDI: A rainy day for a rainy day only ends up making the whole world wet.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"GHANDI: You must be the warmth you wish to see in the world.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"GHANDI: Happiness is what you think, what you say, and what you do when you are in Anchorage, Alaska.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"GHANDI: Umbrellas are the key of the morning and the bolt of the evening.";
            }
            else {
                weatherView.quoteLabel.text = @"GHANDI: No storm can hurt me without my permission.";
            }
        }
        else if (number == 4) {
            if (weekday1 == 1) {
           weatherView.quoteLabel.text = @"MUHAMMAD ALI: I hated every minute of winter, but I said, 'Don't quit. Suffer now and live the rest of your year as a champion.'";
            }
            else if (weekday1 == 2) {
                weatherView.quoteLabel.text = @"MUHAMMAD ALI: Spring is the greatest, I said that even before I knew it was.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"MUHAMMAD ALI: He who is not courageous enough to wear a man scarf will accomplish nothing in life.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"MUHAMMAD ALI: A man who views the world the same at fifty as he did at twenty has wasted thirty summers of his life.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"MUHAMMAD ALI: It's the repetition of affirmations that leads to belief. And once that belief becomes a deep conviction, things begin to happen.  Like the seasons.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"MUHAMMAD ALI: Hating places because of their temperature is wrong. It's just plain wrong.";
            }
            else {
                weatherView.quoteLabel.text = @"MUHAMMAD ALI: Float like a cumulus cloud, sting like an anvil lightning!";
            }
        }
        else if (number == 5) {
            if (weekday1 == 1) {
                weatherView.quoteLabel.text = @"MALCOM X: The future belongs to those who prepare for it today... carry a sweater in your backpack.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"MALCOM X: You're not to be so blind with warmth that you can't face the coming winter.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"MALCOM X: Nobody can give you tropical weather. Nobody can give you beautiful skies or mild winds or anything.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"MALCOM X: Wind never takes a back step - only in the face of more wind.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"MALCOM X: Time is on the side of the people today; it's against the winter.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"MALCOM X: You can't separate warmth from summer because no one can be warm consistantly unless he has his summer.";
            }
            else {
                weatherView.quoteLabel.text = @"MALCOM X: Without statistical neural network weather forcasting models, you're not going anywhere in this world.";
            }
            
        }
        else if (number == 6) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"SINATRA: Dare to wear the light sweater-shirt.";
            }
            else if (weekday1 == 2) {
                weatherView.quoteLabel.text = @"SINATRA: A man doesn't know what happiness is until winter. By then it's too late.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"SINATRA: Hell hath no fury like an Arizona town with a record high forecast.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"SINATRA: The best revenge is living somewhere warm and windy.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"SINATRA: Forecasting is the enemy of logic.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"SINATRA: The big lesson in life, baby, is never be scared of anyone or anything or any class D weather vortex.";
            }
            else {
               weatherView.quoteLabel.text = @"SINATRA: Chaos Theory may be a puzzle, but I like the way the parts fit.";
            }
            
        }
        else if (number == 7) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"ALEX THE GREAT: There is nothing impossible to him who will try, especially with this mild, comfortable weather.";
            }
            else if (weekday1 == 2) {
               weatherView.quoteLabel.text = @"ALEX THE GREAT: Know ye not that the end and object of conquest is to avoid standing in the rain?";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"ALEX THE GREAT: Holy shadows of the clouds, I’m not to blame for your cruel and bitter fate.  Don't rain on me.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"ALEX THE GREAT: If I were not Alexander, I should wish to be Nate Silver- huge props, man!";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"ALEX THE GREAT: There is nothing impossible to him who will try, especially with this mild, comfortable weather.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"ALEX THE GREAT: So would I, if I were an anchorman.";
            }
            else {
                weatherView.quoteLabel.text = @"ALEX THE GREAT: Rain and snow alone make me conscious that I am mortal.";
            }
            
        }
        else if (number == 8) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"FREUD: Time spent with cats is never wasted- and in this heat that time is probably spent lying under a window.";
            }
            else if (weekday1 == 2) {
               weatherView.quoteLabel.text = @"FREUD: Summer is the opiate of the masses.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"FREUD: I cannot think of any need in childhood as strong as the need for an umbrella's protection.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"FREUD: Hurricanes and typhoons are the cornerstones of our weather themed movies.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"FREUD: One is very crazy when hallucinating from hypothermia or heat stroke.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"FREUD: We are never so defensless against suffering as when we get heat stroke while hiking alone in the Sahara.";
            }
            else {
                weatherView.quoteLabel.text = @"FREUD: Civilization began the first time an angry person used an umbrella instead of holding a smaller wet person over their head.";
            }
        }
        else if (number == 9) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"DARWIN: How paramount the future is to the present when one is surrounded by heat waves.";
            }
            else if (weekday1 == 2) {
                weatherView.quoteLabel.text = @"DARWIN: A man's raincoats are one of the best measures of his worth.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"DARWIN: I have tried lately to read the weather forecast, and found it so intolerably dull that it nauseated me.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"DARWIN: Man is descended from a hairy, tailed quadruped, probably arboreal in its habits, and warmer than I am.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"DARWIN: I love fools' experiments. Like weather forecasting.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"DARWIN: I am turned into a sort of machine for observing facts and grinding out silly conclusions.  This is called forecasting.";
            }
            else {
                weatherView.quoteLabel.text = @"DARWIN: Clouds tend to increase at a greater rate than the speed at which I run for cover from rain.";
            }
        }
        else if (number == 10) {
            if (weekday1 == 1) {
           weatherView.quoteLabel.text = @"PRES. W.H. HARRISON: To Englishmen, blistering heat is a topic, not an activity.";
            }
            else if (weekday1 == 2) {
                weatherView.quoteLabel.text = @"PRES. W.H. HARRISON: There is nothing more corrupting, nothing more destructive of the noblest and finest feelings of our nature, than hurricanes.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"PRES. W.H. HARRISON: The only legitimate right to rain is an express grant of power from the umbrellas.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"PRES. W.H. HARRISON: I contend that the strongest of all hot summers is that which is most hot and summer-ish.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"PRES. W.H. HARRISON: Sir, I wish to understand the true principles of clouds. I wish them carried away. I ask nothing more.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"PRES. W.H. HARRISON: The chains of heat, once fastened upon a nation, months might pass before they cool down.";
            }
            else {
                weatherView.quoteLabel.text = @"PRES. W.H. HARRISON: Our citizens must be content with the exerercise beneath the heat with which the sun clothes them.";
            }
            
        }
        else {
            
            weatherView.quoteLabel.text = @"BUDDHA: Three things cannot be long hidden: the sun, the moon, and the truth.  The truth is that this weather is too much for me.";
        }
       
        
        
    } else {
        
        
        weatherView.currentTemperatureLabel.text = [NSString stringWithFormat:@"%.0f°", currentTemperature.celsius];
        weatherView.hiloTemperatureLabel.text = [NSString stringWithFormat:@"H %.0f  L %.0f", highTemperature.celsius, lowTemperature.celsius];
        CGFloat celcius = MIN(MAX(0, currentTemperature.celsius), 99);
        NSString *quoteINTC = [NSString stringWithFormat:@"%d", (int)floor(celcius / 10.0)];
        NSScanner *scannerC = [NSScanner scannerWithString:quoteINTC];
        NSCharacterSet *numbersC = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        [scannerC scanCharactersFromSet:numbersC intoString:&quoteINTC];
        int numberC = (int)[quoteINTC integerValue];
        NSLog(@"%d number whuuut CCC", numberC);
        if (numberC == 0) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"PABLO PICASSO: Action is the fundamental key to staying warm.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"PABLO PICASSO: The purpose of rain is washing the dust of daily life off our souls.";
            }
            else if (weekday1 == 3) {
            weatherView.quoteLabel.text = @"PABLO PICASSO: It takes a long time to become young.  It takes about a minute to get wet in the rain.";
            }
            else if (weekday1 == 4) {
            weatherView.quoteLabel.text = @"PABLO PICASSO: Good clouds rain; great clouds make lightning storms with vorpal tunnels to Vorg.";
            }
            else if (weekday1 == 5) {
             weatherView.quoteLabel.text = @"PABLO PICASSO: Computers are useless. They can only give you answers.  Like the forecast (see below).";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"PABLO PICASSO: Rain exists, but it has to find us picnicking.";
            }
            else {
               weatherView.quoteLabel.text = @"PABLO PICASSO: Combination lightning strikes and whirlpool shark rides are the greatest refreshment in life.";
            }
            
        }
        else if (numberC == 1) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"MATSUO BASHÔ: Summer grasses... All that remains.... Of summer.";
            }
            else if (weekday1 == 2) {
             weatherView.quoteLabel.text = @"MATSUO BASHÔ: The moon is brighter since the sun burned.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"MATSUO BASHÔ: There is nothing you can see that is not a cloud; there is nothing you can think that is not a forecast.";
            }
            else if (weekday1 == 4) {
               weatherView.quoteLabel.text = @"MATSUO BASHÔ: Seek not to follow in the footsteps of clouds; seek to forecast what they sought.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"MATSUO BASHÔ: The summer grasses... For many brave warriors... The aftermath of autumn.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"MATSUO BASHÔ: Asagao ni ware wa meshi kû otoko kana!";
            }
            else {
             weatherView.quoteLabel.text = @"MATSUO BASHÔ: He who shivers... makes wind his master.";
            }
        }
        else if (numberC == 2) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"NIELS BOHR: Prediction is very difficult, especially if it's about the future.  Look below for your weather prediction.";
            }
            else if (weekday1 == 2) {
               weatherView.quoteLabel.text = @"NIELS BOHR: We must be clear that when it comes to forecasting, language can be used only as in poetry.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"NIELS BOHR: The great extension of our experience in recent years has [...] shaken the foundation on which [...] forecasting was based.";
            }
            else if (weekday1 == 4) {
               weatherView.quoteLabel.text = @"NIELS BOHR: Isolated material particles are abstractions.  Gadzillions of those particles are snow storms.";
            }
            else if (weekday1 == 5) {
              weatherView.quoteLabel.text = @"NIELS BOHR: We are all agreed that your theory is crazy. The question that divides us is whether it is crazy enough to be a weather forecast.";
            }
            else if (weekday1 == 6) {
               weatherView.quoteLabel.text = @"NIELS BOHR: How wonderful that we have met with a paradox. Now we have some hope of making a forecast.";
            }
            else {
              weatherView.quoteLabel.text = @"NIELS BOHR: It is the hallmark of any deep truth that its negation is also a deep truth.  For some deep truths, see the forecasts below.";
            }
        }
        else if (numberC == 3) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"BLACKBEARD: Let's jump on board, and take their winter gear.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"BLACKBEARD: Only the devil and I know the whereabouts of a coming storm cloud.... oh yeah, and the Bluster weather app for iOS.";
            }
            else if (weekday1 == 3) {
            weatherView.quoteLabel.text = @"BLACKBEARD: Darnnation sieze you all if it snows!";
            }
            else if (weekday1 == 4) {
            weatherView.quoteLabel.text = @"BLACKBEARD: Darn you snow, where are you?  And from whence came you?  And when will you come back?  I miss you!";
            }
            else {
            weatherView.quoteLabel.text = @"BLACKBEARD: Let's jump on board, and take their winter gear.";
            }
        }
        else if (numberC == 4) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"STEINBECK: The final weapon is the marino wool, all else is supplemental.";
            }
            else if (weekday1 == 2) {
             weatherView.quoteLabel.text = @"STEINBECK: A sad soul can kill quicker than a germ.  A tornado can kill quicker than a sad soul.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"STEINBECK: A forecast is like marriage. The certain way to be wrong is to think you control it.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"STEINBECK: Many a cloud conglomeration continues long after movement in clouds and extra-terrestrial dust vortexes have ceased.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"STEINBECK: Clouds are like rabbits. You get a couple and learn how to handle them, and pretty soon you have a thunder storm.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"STEINBECK: Power does not corrupt. Water corrupts... it currupts various types of metals through rust.";
            }
            else {
               weatherView.quoteLabel.text = @"STEINBECK: We spend our time searching for forecasts and hate it when we get them.";
            }
            }
        else if (numberC == 5) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"A.R. WALLACE: In my solitude I have pondered much on the incomprehensible subjects of heat, cold, umbrellas and scarves.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"A.R. WALLACE: I should like to take some one cloud type to study thoroughly, principally with a view to get rained on.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"A.R. WALLACE: There is, however, one natural feature of this country, the interest and grandeur of which may be fully appreciated in a single walk: it is the bank of low hanging eastbound clouds.";
            }
            else if (weekday1 == 3) {
            weatherView.quoteLabel.text = @"A.R. WALLACE: Singapore is rich in beetles, and before I leave I think I shall have a beautiful collection of them.  Depending on the weather, of course.";
            }
            else if (weekday1 == 4) {
            weatherView.quoteLabel.text = @"A.R. WALLACE: To give English entomologists some idea of the collecting here, I will give a sketch of one good day's work.  I shall use waterproof paper in case of rain.";
            }
            else if (weekday1 == 5) {
            weatherView.quoteLabel.text = @"A.R. WALLACE: The lean and hungry forecasters on reddit were my greatest enemies, and kept me constantly on the watch for slipup or mistake.";
            }
            else if (weekday1 == 6) {
             weatherView.quoteLabel.text = @"A.R. WALLACE: During my stay at Rurúkan my curiosity was satisfied by experiencing a pretty sharp earthquake-shock.";
            }
            else {
            weatherView.quoteLabel.text = @"A.R. WALLACE: We find a curious series of correspondences, both in mind and in environment, which led Darwin and myself, alone among our contemporaries, to reach identically the same weather forecast.";
            }
            
        }
        else if (numberC == 6) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"TUPAC: I didn't choose the long-sleeved T-shirt life, the long-sleeved T-Shirt life chose me.";
            }
            else if (weekday1 == 2) {
             weatherView.quoteLabel.text = @"TUPAC: My mama always used to tell me: 'If you can't find somethin' to live for, you best find an umbrella to stand under.";
            }
            else if (weekday1 == 3) {
              weatherView.quoteLabel.text = @"TUPAC: All I'm trying to do is survive and make good out of the dirty, nasty, unbelievable weather.";
            }
            else if (weekday1 == 4) {
            weatherView.quoteLabel.text = @"TUPAC: It seems like every time you come up something happens to bring you back down- like for example it rains.";
            }
            else if (weekday1 == 5) {
             weatherView.quoteLabel.text = @"TUPAC: I don't have no fear of hail. My only fear is coming back reincarnated.";
            }
            else if (weekday1 == 6) {
             weatherView.quoteLabel.text = @"TUPAC: Is it a crime, to hide, from ugly weather?";
            }
            else {
            weatherView.quoteLabel.text = @"TUPAC: I just spent 11 and a half months in Alaska, got hypothermic five times, and was wrongly accused of throwing snowballs.";
            }
            
        }
        else if (numberC == 7) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"BRAM STOKER: There are darknesses in life and there are lights, and today is one of the lights, the light of all lights (until night time, when it will not be light).";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"BRAM STOKER: Listen to them, the rain-drops of the night. What music they make!";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"BRAM STOKER: There is a reason why all weather systems are as they are.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"BRAM STOKER: Remember my friend, that knowledge is stronger than forecast, and we should not trust the weaker.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"BRAM STOKER: Whirlpools have their own calms.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"BRAM STOKER: No man knows till he has suffered from the icy roads how sweet and dear to his heart and eye the summer slushy roads can be.";
            }
            else {
               weatherView.quoteLabel.text = @"BRAM STOKER: How good and thoughtful he is; the world seems full of good weather--even if there are storms in it.";
            }
            
        }
        else if (numberC == 8) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"ARISTOTLE: It is the mark of a cold-hearted mind to be able to survive warm weather without accepting it.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"ARISTOTLE: Knowing the weather is the beginning of all wisdom.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"ARISTOTLE: What is a forecaster? A single soul dwelling around many computers.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"ARISTOTLE: Hope is a waking dream.  I hope it will snow.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"ARISTOTLE: Happiness depends upon the ski conditions.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"ARISTOTLE: Happiness is the meaning and the purpose of life, the whole aim and end of human existence.  Sunny days and skate parks make me happy.";
            }
            else {
                weatherView.quoteLabel.text = @"ARISTOTLE: No beautiful sky has ever existed without a touch of madness.";
            }
            
        }
        else if (numberC == 9) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"WODEHOUSE: Warm weather, sir, in my opinion, is dangerous.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"WODEHOUSE: I could see that, if not actually disgruntled, he was far from being gruntled about the rain.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"WODEHOUSE: Forecasters are like mulligatawny soup in a cheap restaurant. It is best not to question them.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"WODEHOUSE: Flowers are happy things.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"WODEHOUSE: The cloud looked as if it had been poured into the sky and had forgotten to say 'when.'";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"WODEHOUSE: Sudden success in forecasting is like the sudden acquisition of wealth. It is apt to unsettle and deteriorate the character.";
            }
            else {
                weatherView.quoteLabel.text = @"WODEHOUSE: The cloud was white and shaken, like a dry martini.";
            }
        }
        else if (numberC == 10) {
            if (weekday1 == 1) {
            weatherView.quoteLabel.text = @"CHURCHILL: If you're driving through Miami, keep driving.";
            }
            else if (weekday1 == 2) {
            weatherView.quoteLabel.text = @"CHURCHILL: There is no such thing as a good rain.";
            }
            else if (weekday1 == 3) {
                weatherView.quoteLabel.text = @"CHURCHILL: The inherent vice of latitude is the unequal sharing of heat; the inherent virtue of longitude is the equal sharing of disease vectors.";
            }
            else if (weekday1 == 4) {
                weatherView.quoteLabel.text = @"CHURCHILL: A forecaster is one who can’t change his mind and won’t change the subject.";
            }
            else if (weekday1 == 5) {
                weatherView.quoteLabel.text = @"CHURCHILL: Madam, I may be cold, but in the morning I will be warm and far away and this town will still have four feet of snow.";
            }
            else if (weekday1 == 6) {
                weatherView.quoteLabel.text = @"NANCY ASTOR: Sir, if you were my husband, I would forecast our seperation.  CHURCHILL: If I were your husband I would check the Bluster iOS app every day for that forecast.";
            }
            else {
                weatherView.quoteLabel.text = @"CHURCHILL: Forecasts will be kind to me for I intend to write them.";
            }
        }
        else {
            
            weatherView.quoteLabel.text = @"SUN TZU: The supreme art of sunscreen is to subdue the enemy without fighting.";
        }

        
        
    }
    
    SOLWeatherSnapshot *forecastDayOneSnapshot      = [data.forecastSnapshots objectAtIndex:0];
    SOLWeatherSnapshot *forecastDayTwoSnapshot      = [data.forecastSnapshots objectAtIndex:1];
    SOLWeatherSnapshot *forecastDayThreeSnapshot    = [data.forecastSnapshots objectAtIndex:2];
    
    /// Set the weather view's forcast day labels
    weatherView.forecastDayOneLabel.text    = [forecastDayOneSnapshot.dayOfWeek substringWithRange:NSMakeRange(0, 3)];
    weatherView.forecastDayTwoLabel.text    = [forecastDayTwoSnapshot.dayOfWeek substringWithRange:NSMakeRange(0, 3)];
    weatherView.forecastDayThreeLabel.text  = [forecastDayThreeSnapshot.dayOfWeek substringWithRange:NSMakeRange(0, 3)];
    
    /// Set the weather view's forecast icons
    weatherView.forecastIconOneLabel.text   = forecastDayOneSnapshot.icon;
    weatherView.forecastIconTwoLabel.text   = forecastDayTwoSnapshot.icon;
    weatherView.forecastIconThreeLabel.text = forecastDayThreeSnapshot.icon;
    
    /// Set the weather view's background color
    CGFloat fahrenheit = MIN(MAX(0, currentTemperature.fahrenheit), 99);
    NSString *gradientImageName = [NSString stringWithFormat:@"gradient%d.png", (int)floor(fahrenheit / 10.0)];
    weatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:gradientImageName]];
    
    
    /*UIImage* image = [UIImage imageNamed:gradientImageName];
    UIColor *dominantColor = [self getDominantColor:image];
    NSLog(@"%@ dominant", dominantColor);
    if (dominantColor == [UIColor colorWithWhite:1 alpha:1]) {
        UIColor *newColor = [UIColor blackColor];
        NSLog(@"%@ newColor", newColor);
        [weatherView.forecastDayOneLabel setTextColor:newColor];
        [weatherView.forecastDayTwoLabel setTextColor:newColor];
        [weatherView.forecastDayThreeLabel setTextColor:newColor];
        [weatherView.forecastIconOneLabel setTextColor:newColor];
        [weatherView.forecastIconTwoLabel setTextColor:newColor];
        [weatherView.forecastIconThreeLabel setTextColor:newColor];
        [weatherView.quoteLabel setTextColor:newColor];
        
        
    }
    else {
        const CGFloat *componentColors = CGColorGetComponents(dominantColor.CGColor);
        UIColor *newColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                                   green:(1.0 - componentColors[1])
                                                    blue:(1.0 - componentColors[2])
                                                   alpha:componentColors[3]];
        NSLog(@"%@ newColor", newColor);
        [weatherView.forecastDayOneLabel setTextColor:newColor];
        [weatherView.forecastDayTwoLabel setTextColor:newColor];
        [weatherView.forecastDayThreeLabel setTextColor:newColor];
        [weatherView.forecastIconOneLabel setTextColor:newColor];
        [weatherView.forecastIconTwoLabel setTextColor:newColor];
        [weatherView.forecastIconThreeLabel setTextColor:newColor];
        [weatherView.quoteLabel setTextColor:newColor];
    }*/

}
struct pixel {
    unsigned char r, g, b, a;
};
- (UIColor*) getDominantColor:(UIImage*)image
{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    
    
    // Allocate a buffer big enough to hold all the pixels
    
    struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
    if (pixels != nil)
    {
        
        CGContextRef context = CGBitmapContextCreate(
                                                     (void*) pixels,
                                                     image.size.width,
                                                     image.size.height,
                                                     8,
                                                     image.size.width * 4,
                                                     CGImageGetColorSpace(image.CGImage),
                                                     (CGBitmapInfo)kCGImageAlphaPremultipliedLast
                                                     );
        //CGBitmapInfo bitmapInfo = (CGBitmapInfo) kCGImageAlphaPremultipliedLast;
        
        if (context != NULL)
        {
            // Draw the image in the bitmap
            
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
            
            // Now that we have the image drawn in our own buffer, we can loop over the pixels to
            // process it. This simple case simply counts all pixels that have a pure red component.
            
            // There are probably more efficient and interesting ways to do this. But the important
            // part is that the pixels buffer can be read directly.
            
            NSUInteger numberOfPixels = image.size.width * image.size.height;
            for (int i=0; i<numberOfPixels; i++) {
                red += pixels[i].r;
                green += pixels[i].g;
                blue += pixels[i].b;
            }
            
            
            red /= numberOfPixels;
            green /= numberOfPixels;
            blue/= numberOfPixels;
            
            
            CGContextRelease(context);
        }
        
        free(pixels);
    }
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
    
}

#pragma mark CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    /// Only add the local weather view if location services authorized
    if(status == kCLAuthorizationStatusAuthorizedAlways) {
        [self initializeLocalWeatherView];
        [self initializeNonlocalWeatherViews];
        [self updateWeatherData];
    } else if(status != kCLAuthorizationStatusNotDetermined) {
        [self initializeNonlocalWeatherViews];
        [self updateWeatherData];
    } else if(status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        /// If location services are disabled and no saved weather data is found, show the add location view controller
        if([self.pagingScrollView.subviews count] == 0) {
            [self presentViewController:self.addLocationViewController animated:YES completion:nil];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    /// Download new weather data for the local weather view
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.local == YES) {
            SOLWeatherData *weatherData = [self.weatherData objectForKey:[NSNumber numberWithInteger:weatherView.tag]];
            
            /// Only update weather data if the time since last update has exceeded the minimum time
            if([[NSDate date]timeIntervalSinceDate:weatherData.timestamp] >= kMIN_TIME_SINCE_UPDATE || !weatherView.hasData) {
                /// If the weather view has data, move the activity indicator to not overall with any labels
                if(weatherView.hasData) {
                    weatherView.activityIndicator.center = CGPointMake(weatherView.center.x, 1.8 * weatherView.center.y);
                }
                [weatherView.activityIndicator startAnimating];
                
                /// Initiate download request
                [[SOLWundergroundDownloader sharedDownloader]dataForLocation:[locations lastObject] withTag:weatherView.tag completion:^(SOLWeatherData *data, NSError *error) {
                    
                    if (data) {
                        // Success
                        [self downloadDidFinishWithData:data withTag:weatherView.tag];
                    } else {
                        // Failure
                        [self downloadDidFailForWeatherViewWithTag:weatherView.tag];
                    }
                }];
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    /// If the local weather view has no data and a location could not be determined, show a failure message
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.local == YES && !weatherView.hasData) {
            weatherView.conditionIconLabel.text = @"☹";
            weatherView.conditionDescriptionLabel.text = @"Update Failed";
            weatherView.locationLabel.text = @"Check your network connection";
        }
    }
}

#pragma mark AddLocationButton Methods

- (void)addLocationButtonPressed
{

    /// Only show the blurred overlay view if weather views have been added
    if([self.pagingScrollView.subviews count] > 0) {
        [self showBlurredOverlayView:YES];
    } else {
        
        /// Fade out the logo and app name when there are no weather views
        [UIView animateWithDuration:0.3 animations: ^ {
            self.solLogoLabel.alpha = 0.0;
            self.solTitleLabel.alpha = 0.0;
        }];
    }
    
    /// Transition to the add location view controller
    [self presentViewController:self.addLocationViewController animated:NO completion:nil];
}

#pragma mark SOLAddLocationViewControllerDelegate Methods

- (void)didAddLocationWithPlacemark:(CLPlacemark *)placemark
{
    
    /// Get cached weather data for the added placemark if it exists
    SOLWeatherData *weatherData = [self.weatherData objectForKey:[NSNumber numberWithInteger:placemark.locality.hash]];
    
    /// Only add a location if it is does not already exist
    if(!weatherData) {
        
        /// Create a weather view for the newly added location
        SOLWeatherView *weatherView = [[SOLWeatherView alloc]initWithFrame:self.view.bounds];
        weatherView.delegate = self;
        weatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kDEFAULT_BACKGROUND_GRADIENT]];
        [weatherView setLocal:NO];
        [weatherView setTag:placemark.locality.hash];
        [weatherView.activityIndicator startAnimating];

        self.pageControl.numberOfPages += 1;
        [self.pagingScrollView addSubview:weatherView isLaunch:NO];
        [self.weatherTags addObject:[NSNumber numberWithInteger:weatherView.tag]];
        [SOLStateManager setWeatherTags:self.weatherTags];
        
        /// Download weather data for the newly created weather view
        [[SOLWundergroundDownloader sharedDownloader]dataForPlacemark:placemark withTag:weatherView.tag completion:^(SOLWeatherData *data, NSError *error) {
            if (data) {
                // Success
                [self downloadDidFinishWithData:data withTag:weatherView.tag];
            } else {
                // Failure
                [self downloadDidFailForWeatherViewWithTag:weatherView.tag];
            }
        }];
    }
    
    /// Hide the add location button if the number of weather views is greater than or equal to the max
    if([self.pagingScrollView.subviews count] >= kMAX_NUM_WEATHER_VIEWS) {
        self.addLocationButton.hidden = YES;
    }
}

- (void)dismissAddLocationViewController
{
    [self showBlurredOverlayView:NO];
    [UIView animateWithDuration:0.3 animations: ^ {
        self.solLogoLabel.alpha   = 1.0;
        self.solTitleLabel.alpha  = 1.0;
    }];
    [self.addLocationViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark SettingsButton Methods

- (void)settingsButtonPressed
{
    
    /// Prepare the data (location name, tag) needed by the settings view controller
    NSMutableArray *locations = [[NSMutableArray alloc]initWithCapacity:4];
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.tag != kLOCAL_WEATHER_VIEW_TAG) {
            NSArray *locationMetaData = @[weatherView.locationLabel.text, [NSNumber numberWithInteger:weatherView.tag]];
            [locations addObject:locationMetaData];
        }
    }
    
    self.settingsViewController.locations = locations;
    
    /// Transition to the settings view controller
    [self presentViewController:self.settingsViewController animated:YES completion:nil];
    
    /// Only show the blurred overlay view if weather views have been added
    if([self.pagingScrollView.subviews count] > 0) {
        [self showBlurredOverlayView:YES];
    } else {
        
        /// Fade out the logo and app name when there are no weather views
        [UIView animateWithDuration:0.3 animations: ^ {
            self.solLogoLabel.alpha = 0.0;
            self.solTitleLabel.alpha = 0.0;
        }];
    }
}

#pragma mark SOLSettingsViewControllerDelegate Methods

- (void)didMoveWeatherViewAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex
{
    
    NSNumber *weatherTag = [self.weatherTags objectAtIndex:sourceIndex];
    [self.weatherTags removeObjectAtIndex:sourceIndex];
    [self.weatherTags insertObject:weatherTag atIndex:destinationIndex];
    
    /// Save the weather tags
    [SOLStateManager setWeatherTags:self.weatherTags];
    
    /// If there is a local weather view, we must increment the sourceIndex and destinationIndex to
    // compensate. Checking for the local weather view's data is a simple way of checking for the local weather view
    if([self.weatherData objectForKey:[NSNumber numberWithInteger:kLOCAL_WEATHER_VIEW_TAG]]) {
        sourceIndex +=1 ;
        destinationIndex += 1;
    }
    
    /// Move the weather view
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.tag == weatherTag.integerValue) {
            [self.pagingScrollView removeSubview:weatherView];
            [self.pagingScrollView insertSubview:weatherView atIndex:destinationIndex];
            break;
        }
    }
}

- (void)didRemoveWeatherViewWithTag:(NSInteger)tag
{
    
    /// Find the weather view to remove
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        if(weatherView.tag == tag) {
            [self.pagingScrollView removeSubview:weatherView];
            self.pageControl.numberOfPages -= 1;
        }
    }
    
    /// Remove the associated data for the view from our saved weather data
    [self.weatherData removeObjectForKey:[NSNumber numberWithInteger:tag]];
    
    /// Remove the associated tag for the view from our saved tag data
    [self.weatherTags removeObject:[NSNumber numberWithInteger:tag]];
    
    /// Show the add location button if the remaining number of weather views is below the max
    if([self.weatherData count] < kMAX_NUM_WEATHER_VIEWS) {
        self.addLocationButton.hidden = NO;
    }
    
    /// Save data
    [SOLStateManager setWeatherData:self.weatherData];
    [SOLStateManager setWeatherTags:self.weatherTags];
}

- (void)didChangeTemperatureScale:(SOLTemperatureScale)scale
{
    
    /// Iterate through all weather views and update their temperature scales
    for(SOLWeatherView *weatherView in self.pagingScrollView.subviews) {
        SOLWeatherData *weatherData = [self.weatherData objectForKey:[NSNumber numberWithInteger:weatherView.tag]];
        [self updateWeatherView:weatherView withData:weatherData];
    }
}

- (void)dismissSettingsViewController
{
    
    /// Hid the blurred overlay
    [self showBlurredOverlayView:NO];
    
    /// Show the Sol° logo
    [UIView animateWithDuration:0.3 animations: ^ {
        self.solLogoLabel.alpha   = 1.0;
        self.solTitleLabel.alpha  = 1.0;
    }];
    
    /// Dismiss the settings view controller
    [self.settingsViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isScrolling = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isScrolling = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.isScrolling = YES;
    
    /// Update the current page for the page control
    float fractionalPage = self.pagingScrollView.contentOffset.x / self.pagingScrollView.frame.size.width;
    self.pageControl.currentPage = lround(fractionalPage);
}

#pragma mark SOLWeatherViewDelegate Methods

- (BOOL)shouldPanWeatherView
{
    /// Only allow weather views to pan if not currently scrolling
    return !self.isScrolling;
}

- (void)didBeginPanningWeatherView
{
    /// Keep the paging scroll view from scrolling if a weather view is panning
    self.pagingScrollView.scrollEnabled = NO;
}

- (void)didFinishPanningWeatherView
{
    /// Allow the paging scroll view to scroll if a weather view finished panning
    self.pagingScrollView.scrollEnabled = YES;
}

@end
