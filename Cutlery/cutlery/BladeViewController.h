//
//  BladeViewController.h
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Knife.h"
#import "SwitchBladeView.h"

@interface BladeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *bladePicker;
@property (weak, nonatomic) IBOutlet UISwitch *tangSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UISlider *lengthSlider;
@property (strong, nonatomic) NSArray* bladeArray;
@property (weak, nonatomic) IBOutlet SwitchBladeView *bladeRenderView;

// the actual knife
@property (nonatomic) Knife* curKnife;

-(void)adjustLabelForSlider:(id)slider;

- (IBAction)next:(id)sender;


@end
