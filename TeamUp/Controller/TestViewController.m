//
//  TestViewController.m
//  TeamUp
//
//  Created by Hung_mobilefolk on 5/24/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

#import "TestViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>

@interface TestViewController ()

@end

@implementation TestViewController

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
