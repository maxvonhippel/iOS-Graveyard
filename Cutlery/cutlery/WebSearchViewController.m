//
//  WebSearchViewController.m
//  cutlery
//
//  Created by Max von Hippel on 8/25/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "WebSearchViewController.h"
#import "SavedKniveViewController.h"

@interface WebSearchViewController ()

@end

@implementation WebSearchViewController
@synthesize webView, navigationBar, curKnife, wikiSearch, knifeCenterSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // if there is only one word in the search, we get this scheme:
    // https://www.google.com/?gws_rd=ssl#q= word &tbm=shop
    // if there are multiple words, we get this scheme:
    // https://www.google.com/?gws_rd=ssl#tbm=shop&q= word+otherword+etc
    NSString* searchString;
    if (!curKnife)
        return;
    if (!wikiSearch && !knifeCenterSearch) {
        searchString = [NSString stringWithFormat:@"https://www.google.com/?gws_rd=ssl#tbm=shop&q=%@+%@", [curKnife.brand stringByReplacingOccurrencesOfString:@" " withString:@"+"], [curKnife.name stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    } else if (!wikiSearch) {
        // http://www.knifecenter.com/kc_new/store_store.html?usrsearch=straight
        searchString = [NSString stringWithFormat:@"https://www.knifecenter.com/kc_new/store_store.html?usrsearch=%@", [knifeCenterSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    } else {
        searchString = [NSString stringWithFormat:@"https://en.wikipedia.org/wiki/%@", [wikiSearch stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
        
    }
    // now we turn that string into a URL
    NSURL* searchURL = [[NSURL alloc] initWithString:searchString];
    // and finally, we need to search safari for that URL
    navigationBar.topItem.title = curKnife.name;
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:searchURL];
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"window.location"];
    // http://www.knifecenter.com/kc_new/store_store.html?usrsearch=straight
    [webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    
    
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    SavedKniveViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"SavedKniveViewController"];
    vc.curKnife = curKnife;
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
