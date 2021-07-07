//
//  CameraViewController.m
//  Instagram
//
//  Created by Santy Mendoza on 7/7/21.
//

#import "CameraViewController.h"
#import "Post.h"

@interface CameraViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionField;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(imageTapped:)];
    [self.postImage addGestureRecognizer:singleTap];   
}


- (void)imageTapped:(UITapGestureRecognizer *)recognizer
{
    // Do any additional setup after loading the view.
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    self.selectedImage = originalImage;
    self.postImage.image  = originalImage;
    //    [Post postUserImage:originalImage withCaption:self.captionField.text withCompletion:nil];
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
    //close compose tab
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)postButtonPressed:(id)sender {
    [Post postUserImage:self.selectedImage withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"successfully uploaded an image!");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else{
            NSLog(@"did not post image!");
        }
    }];

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
