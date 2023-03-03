//
//  UIImage+ResourceLoad.m
//  ChindlePointRead
//
//  Created by 朱𣇈丹 on 2023/3/3.
//

#import "UIImage+ResourceLoad.h"

@implementation UIImage (ResourceLoad)

+ (UIImage *)mainResourceImageNamed:(NSString *)name {
    
    NSString *bundleName = @"PointReadResource.bundle";
    
    UIImage *image = nil;
    
    //判断多少
    NSInteger times = tesDeviceRender();
    
    NSString *image_name;
    
    if(times == 2) {
        
        image_name = [NSString stringWithFormat:@"%@@2x.png", name];

    }else{
        
        image_name = [NSString stringWithFormat:@"%@@3x.png", name];
    }
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    
    NSString *image_path = [bundlePath stringByAppendingPathComponent:image_name];;
    
    image = [[UIImage alloc] initWithContentsOfFile:image_path];
    
    return image;
    
}

@end
