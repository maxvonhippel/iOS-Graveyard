//
//  WebSearchViewController.h
//  cutlery
//
//  Created by Max von Hippel on 8/25/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Knife.h"

@interface WebSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) Knife* curKnife;

@property (nonatomic) NSString* wikiSearch;

@property (nonatomic) NSString* knifeCenterSearch;

- (IBAction)back:(id)sender;

@end
