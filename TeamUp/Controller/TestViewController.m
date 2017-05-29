//
//  TestViewController.m
//  TeamUp
//
//  Created by Hung_mobilefolk on 5/24/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

#import "TestViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>


NSString * const kTextFieldAndTextView = @"TextFieldAndTextView";
NSString * const kSelectors = @"Selectors";
NSString * const kOthes = @"Others";
NSString * const kDates = @"Dates";
NSString * const kPredicates = @"BasicPredicates";
NSString * const kBlogExample = @"BlogPredicates";
NSString * const kMultivalued = @"Multivalued";
NSString * const kMultivaluedOnlyReorder = @"MultivaluedOnlyReorder";
NSString * const kMultivaluedOnlyInsert = @"MultivaluedOnlyInsert";
NSString * const kMultivaluedOnlyDelete = @"MultivaluedOnlyDelete";
NSString * const kValidations= @"Validations";
NSString * const kFormatters = @"Formatters";


@interface TestViewController ()

@end

@implementation TestViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
//        [self initializeForm];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
//        [self initializeForm];
    }
    return self;
}
#pragma mark - Helper

-(void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Real examples"];
    [form addFormSection:section];
    
    // NativeEventFormViewController
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"realExamples" rowType:XLFormRowDescriptorTypeButton title:@"iOS Calendar Event Form"];
    row.action.formSegueIdentifier = @"NativeEventNavigationViewControllerSegue";
    [section addFormRow:row];
    
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"This form is actually an example"];
    section.footerTitle = @"ExamplesFormViewController.h, Select an option to view another example";
    [form addFormSection:section];
    
    
    // TextFieldAndTextView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextFieldAndTextView rowType:XLFormRowDescriptorTypeButton title:@"Text Fields"];
    [section addFormRow:row];
    
    // Selectors
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectors rowType:XLFormRowDescriptorTypeButton title:@"Selectors"];
    row.action.formSegueIdentifier = @"SelectorsFormViewControllerSegue";
    [section addFormRow:row];
    
    // Dates
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDates rowType:XLFormRowDescriptorTypeButton title:@"Date & Time"];
    [section addFormRow:row];
    
    // NSFormatters
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kFormatters rowType:XLFormRowDescriptorTypeButton title:@"NSFormatter Support"];
    [section addFormRow:row];
    
    // Others
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kOthes rowType:XLFormRowDescriptorTypeButton title:@"Other Rows"];
    row.action.formSegueIdentifier = @"OthersFormViewControllerSegue";
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Multivalued example"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivalued rowType:XLFormRowDescriptorTypeButton title:@"Multivalued Sections"];
    [section addFormRow:row];
    
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivaluedOnlyReorder rowType:XLFormRowDescriptorTypeButton title:@"Multivalued Only Reorder"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivaluedOnlyInsert rowType:XLFormRowDescriptorTypeButton title:@"Multivalued Only Insert"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivaluedOnlyDelete rowType:XLFormRowDescriptorTypeButton title:@"Multivalued Only Delete"];
    [section addFormRow:row];
    
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"UI Customization"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivalued rowType:XLFormRowDescriptorTypeButton title:@"UI Customization"];
    [section addFormRow:row];
    
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Custom Rows"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivalued rowType:XLFormRowDescriptorTypeButton title:@"Custom Rows"];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Accessory View"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMultivalued rowType:XLFormRowDescriptorTypeButton title:@"Accessory Views"];
    [section addFormRow:row];
    
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Validation Examples"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidations rowType:XLFormRowDescriptorTypeButton title:@"Validation Examples"];
    row.action.formSegueIdentifier = @"ValidationExamplesFormViewControllerSegue";
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Using Predicates"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPredicates rowType:XLFormRowDescriptorTypeButton title:@"Very basic predicates"];
    row.action.formSegueIdentifier = @"BasicPredicateViewControllerSegue";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPredicates rowType:XLFormRowDescriptorTypeButton title:@"Blog Example Hide predicates"];
    row.action.formSegueIdentifier = @"BlogExampleViewSegue";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPredicates rowType:XLFormRowDescriptorTypeButton title:@"Another example"];
    row.action.formSegueIdentifier = @"PredicateFormViewControllerSegue";
    [section addFormRow:row];
    
    self.form = form;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)registerWithPhoneClick:(id)sender {
    
    NSLog(@"start with phone ");
    
    [[FIRPhoneAuthProvider provider]
     verifyPhoneNumber:@"+84982296766"
     completion:^(NSString *_Nullable verificationID,
                  NSError *_Nullable error) {
         if (error) {
             
             NSLog(@"get error is %@",error);
             
             // Verification code not sent.
         } else {
             // Successful.
             
             NSLog(@"successful");
             
             // Show the Screen to enter the Code.
             // Developer may want to save that verificationID along with other app states in case
             // the app is terminated before the user gets the SMS verification code.
         }
     }];
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

@end
