
//laowaiww

#import <Foundation/Foundation.h>
#import "LLWebImageDownloadOperation.h"

typedef void(^setUpImageBlock)(UIImage *webImage);

@interface LLWebImageManager : NSObject

// 操作管理类: 协调 UIImageView 的显示 和 图片的缓存; 一般对应管理类来说,只有一个对象比较好.
// 如果有多个对象,每一个对象都需要管理图片缓存: 相当于 一个对象管理一张图片.
// 如果将管理类做成一个单例对象: 相当于一个对象管理多张图片.


// 单例方法.
+(instancetype)sharedManager;


// 提供一个管理图片的方法.
-(void)setUpWebImageWithUrlString:(NSString *)urlString setUpImageBlock:(setUpImageBlock)setUpImageHandle;


@end
