//
//  ViewController.m
//  GDORK
//
//  Created by Max von Hippel on 8/17/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize allWordsSearchBar, mostWordsSearchBar, allURLSearchBar, mostURLSearchBar, allTitleSearchBar, mostTitleSearchBar, siteSearchBar, filetypeSearchBar, startDatePicker, endDatePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    allWordsSearchBar.delegate = self;
    mostWordsSearchBar.delegate = self;
    allURLSearchBar.delegate = self;
    mostURLSearchBar.delegate = self;
    allTitleSearchBar.delegate = self;
    mostTitleSearchBar.delegate = self;
    siteSearchBar.delegate = self;
    filetypeSearchBar.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender {
    // first, we construct the NSString
    NSMutableArray* operatorArray = [[NSMutableArray alloc] init];
    NSMutableArray* operandArray = [[NSMutableArray alloc] initWithObjects:allWordsSearchBar, mostWordsSearchBar, allURLSearchBar, mostURLSearchBar, allTitleSearchBar, mostTitleSearchBar, siteSearchBar, filetypeSearchBar, nil];
    NSArray* typeArray = [[NSArray alloc] initWithObjects:@"Allintext", @"Intext", @"Allinurl", @"Inurl", @"Allintitle", @"Intitle", @"Site", @"filetype", nil];
    // loop over operands and add resulting strings to operator
    int i = 0;
    for (UISearchBar* operand in operandArray) {
        NSString* contents = operand.text;
        if ([contents length] != 0) {
            // construct the string
            [operatorArray addObject:[NSString stringWithFormat:@"%@:%@", [typeArray objectAtIndex:i], contents]];
        }
        ++i;
    }
    // then deal with dates
    
    NSDate *endDate = endDatePicker.date;
    NSDate *startDate = startDatePicker.date;
    
    if (endDate != NULL && startDate != NULL) {
        /*
        // using code from: http://stackoverflow.com/a/22830318/1586231
        NSUInteger julianDayFor01012000 = 2451545;
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        NSDateComponents *comp = [[NSDateComponents alloc] init];
        comp.year = 2000;
        comp.month = 1;
        comp.day = 1;
        NSDate *ref = [cal dateFromComponents:comp];
        
        NSDateComponents* startDiff = [cal components:NSCalendarUnitDay fromDate:ref toDate:startDate options:0];
        NSDateComponents* endDiff = [cal components:NSCalendarUnitDay fromDate:ref toDate:endDate options:0];
        
        NSInteger startJulianDays = startDiff.day + julianDayFor01012000;
        NSInteger endJulianDays = endDiff.day + julianDayFor01012000;
        
        NSLog(@"start: %ld end: %ld", (long)startJulianDays, (long)endJulianDays);
        
        if (startJulianDays < endJulianDays) {
            [operatorArray addObject:[NSString stringWithFormat:@"Daterange:%ld-%ld", (long)startJulianDays, (long)endJulianDays]];
        }
         */
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        [fmt setDateFormat:@"g"];
        NSInteger startJulianDays = [[fmt stringFromDate:startDate] integerValue];
        NSInteger endJulianDays = [[fmt stringFromDate:endDate] integerValue];
        NSLog(@"%ld - %ld", (long)startJulianDays, (long)endJulianDays);
        
        if (startJulianDays < endJulianDays)
            [operatorArray addObject:[NSString stringWithFormat:@"daterange:%ld-%ld", (long)startJulianDays, (long)endJulianDays]];
    }
    
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    ResultViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    // set the vc's webview's url
    vc.webURl = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/search?q=%@", [operatorArray componentsJoinedByString:@"+"]]];
    NSLog([NSString stringWithFormat:@"https://www.google.com/search?q=%@", [operatorArray componentsJoinedByString:@"+"]]);
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    // You can write search code Here
}

@end
