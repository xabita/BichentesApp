//
//  ViewController.m
//  BichentesApp
//
//  Created by Elizabeth Martínez Gómez on 07/05/16.
//  Copyright © 2016 Elizabeth Martínez Gómez. All rights reserved.
//

#import "imgController.h"

@interface imgController ()

@end


typedef enum {
    CurrentImageCategoryFondo = 0,
    CurrentImageCategoryPers
}CurrentImageCategory;


@implementation imgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
     if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentImageCategory"] == CurrentImageCategoryFondo)
    {
        imageF= [info objectForKey:UIImagePickerControllerOriginalImage];
        [imgFondo setImage:imageF];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentImageCategory"] == CurrentImageCategoryPers)
    {
        imagePers= [info objectForKey:UIImagePickerControllerOriginalImage];
        [imgPersonaje setImage:imagePers];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnGuardar:(UIButton *)sender {
    UIImageWriteToSavedPhotosAlbum([self captureView:self.view], nil, nil, nil);
}


- (UIImage*)captureView:(UIView *)viewContenedor
{
  //  CGRect rect = [[UIScreen mainScreen] bounds];
    CGRect rect = [[self viewContenedor] bounds];
    rect.origin.x += 20.0f;
    rect.origin.y += 20.0f;
    [[self view] setBounds:rect];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [viewContenedor.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (IBAction)btnFondo:(UIButton *)sender {
    // Set current category to userDefaults
    [[NSUserDefaults standardUserDefaults] setInteger:CurrentImageCategoryFondo forKey:@"currentImageCategory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    picker2= [[UIImagePickerController alloc] init];
    picker2.delegate =self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: picker2 animated:YES completion:nil];
}

- (IBAction)btnPersonaje:(UIButton *)sender {
    
    // Set current category to userDefaults
    [[NSUserDefaults standardUserDefaults] setInteger:CurrentImageCategoryPers forKey:@"currentImageCategory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    pickerP2= [[UIImagePickerController alloc] init];
    pickerP2.delegate =self;
    [pickerP2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: pickerP2 animated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([textField.text length] == 0) {
        return NO;
    }
    [textField resignFirstResponder];
    return YES;
}


@end
