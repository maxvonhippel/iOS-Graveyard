//
//  FinalViewController.h
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Knife.h"
#import "handle.h"

@interface FinalViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) Knife* curKnife;
@property (weak, nonatomic) IBOutlet UIPickerView *handleMaterialPicker;
@property (strong, nonatomic) NSArray* handleMaterialArray;
@property (weak, nonatomic) IBOutlet handle *handleRenderView;

- (IBAction)save:(id)sender;

@end
