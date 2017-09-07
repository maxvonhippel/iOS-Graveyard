//
//  BladeViewController.m
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "BladeViewController.h"
#import "MaterialsViewController.h"

@interface BladeViewController ()

@end

@implementation BladeViewController
@synthesize bladePicker, tangSwitch, lengthLabel, lengthSlider, curKnife, bladeArray, bladeRenderView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // set up blade array
    bladeArray = [[NSArray alloc] initWithObjects:@"sheep foot", @"skinner", @"pruner", @"utility", @"razor", @"spear-point", @"muskrat", @"drop-point", @"bowie", @"machete", @"saw", @"multitool", @"punch", @"pen", @"talon", @"tanto", @"khukri", @"straight", @"needle-point", @"spear-point", @"gut-hook", @"cleaver", @"combat", @"throwing", @"chef", @"fillet", nil];
    // Do any additional setup after loading the view.
    // set up the blade picker
    bladePicker.delegate = self;
    bladePicker.dataSource = self;
    [bladePicker reloadAllComponents];
    // set up the length slider
    [lengthSlider addTarget:self action:@selector(adjustLabelForSlider:) forControlEvents:UIControlEventValueChanged];
    // set up the label
    [self adjustLabelForSlider:lengthSlider];
    // set up the render view
    bladeRenderView.backgroundColor = [UIColor darkGrayColor];
    bladeRenderView.curKnife = curKnife;
    bladeRenderView.curKnife.blade = [bladeArray objectAtIndex:[bladePicker selectedRowInComponent:0]];
    [bladeRenderView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ======== blade picker view stuff ===========
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    // fix this redundancy later
    return [bladeArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // sheep foot, skinner, pruner, utility, razor, spear, muskrat, drop point, bowie, machete, saw, multitool, punch, pen, talon, tanto, kukri, straight, needle point, spear point, gut hook, cleaver, combad, skinner, throwing, chef, fillet
    if (row < 0 || row > [bladeArray count])
        return NULL;
    return bladeArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // update the blade view
    bladeRenderView.curKnife.blade = [bladeArray objectAtIndex:[bladePicker selectedRowInComponent:0]];
    [bladeRenderView setNeedsDisplay];

}

// -------------------------------------------- slider -----------------------------

-(void)adjustLabelForSlider:(UISlider*)slider {
    // change the label accordingly
    float inches = slider.value;
    // inches to cm
    float cms = inches * 2.54;
    // print to uilabel
    lengthLabel.text = [NSString stringWithFormat:@"%.2f in, %.f cm", inches, cms];
}

// -------------------------------------------- IBActions -----------------------------

- (IBAction)next:(id)sender {
    // next step: bladeMaterial, handleMaterial, knifeImage
    // but first: modify the current knife before sending it onward
    curKnife.blade = [bladeArray objectAtIndex:[bladePicker selectedRowInComponent:0]];
    curKnife.bladeLength = lengthSlider.value;
    curKnife.fullTang = tangSwitch.isOn;
    // next, get the next view controller, set its knife, and present it
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    MaterialsViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MaterialsViewController"];
    vc.curKnife = curKnife;
    [self presentViewController:vc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
