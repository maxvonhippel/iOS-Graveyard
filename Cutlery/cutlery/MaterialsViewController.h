//
//  MaterialsViewController.h
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Knife.h"
#import "SwitchBladeView.h"

@interface MaterialsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *materialPicker;
@property (weak, nonatomic) IBOutlet UIImageView *knifeImage;
@property (strong, nonatomic) NSArray* materialTypes;
@property (weak, nonatomic) IBOutlet SwitchBladeView *renderBladeView;
@property (weak, nonatomic) IBOutlet UISwitch *ownItSwitch;

@property (nonatomic) Knife* curKnife;

- (IBAction)save:(id)sender;

@end
