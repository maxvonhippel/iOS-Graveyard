//
//  MaterialsViewController.m
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "MaterialsViewController.h"

@interface MaterialsViewController ()

@end

@implementation MaterialsViewController
@synthesize materialPicker, knifeImage, curKnife, materialTypes, renderBladeView, ownItSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    materialTypes = [[NSArray alloc] initWithObjects:@"carbon steel", @"stainless steel", @"tool steel", @"alloy steel", @"steel", @"cobalt alloy", @"titanium alloy", @"carbon fiber", @"obsidian", @"ceramic", @"glass", @"plastic", @"copper", @"damascus", @"damasteel", nil];
    materialPicker.delegate = self;
    materialPicker.dataSource = self;
    [materialPicker reloadAllComponents];
    
    renderBladeView.curKnife = curKnife;
    renderBladeView.backgroundColor = [UIColor darkGrayColor];
    
    renderBladeView.curKnife.bladeMaterial = [materialTypes objectAtIndex:[materialPicker selectedRowInComponent:0]];
    [renderBladeView setNeedsDisplay];

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

- (IBAction)save:(id)sender {
    if ([materialPicker selectedRowInComponent:0] < [materialTypes count])
        curKnife.bladeMaterial = [materialTypes objectAtIndex:[materialPicker selectedRowInComponent:0]];
    else curKnife.bladeMaterial = [materialTypes objectAtIndex:0];
    // go to next view controller
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    MaterialsViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"FinalViewController"];
    curKnife.ownIt = ownItSwitch.isOn;
    vc.curKnife = curKnife;
    [self presentViewController:vc animated:YES completion:nil];
}

// ======== blade picker view stuff ===========
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    // fix this redundancy later
    return [materialTypes count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // carbon steel, stainless steel, tool steel, alloy steel, steel, cobalt alloy, titanium alloy, carbon fiber, obsidian, ceramic, glass, plastic, copper, damascus, damasteel
    if (row < 0 || row > [materialTypes count])
        return NULL;
    return materialTypes[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // update the blade view
    renderBladeView.curKnife.bladeMaterial = [materialTypes objectAtIndex:[materialPicker selectedRowInComponent:0]];
    [renderBladeView setNeedsDisplay];
    
}


@end
