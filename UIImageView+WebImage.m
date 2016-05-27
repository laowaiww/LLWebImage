
//laowaiww

#import "UIImageView+WebImage.h"
#import "LLWebImageManager.h"

@implementation UIImageView (WebImage)

-(void)ll_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage
{
    // 在没有图片的时候,先显示占位图片
    self.image = placeholderImage;
    
    
    // 1.1 实例化管理对象
    LLWebImageManager *manager = [LLWebImageManager sharedManager];
    
    // 1.2 管理图片
    [manager setUpWebImageWithUrlString:urlString setUpImageBlock:^(UIImage *webImage) {
        
        // 设置图片: 显示网络图片.
        self.image = webImage;
        
    }];
}
@end
