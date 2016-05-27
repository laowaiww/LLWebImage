
//laowaiww

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

/**
 *  一句话下载并且显示图片;
 *
 *  @param urlString        图片下载地址
 *  @param placeholderImage 占位图片
 */
-(void)ll_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

@end
