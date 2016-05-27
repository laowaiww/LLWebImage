
//laowaiww

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LLWebImageDownloadOperation;

typedef void(^completionBlock)(LLWebImageDownloadOperation *downloadOp);

@interface LLWebImageDownloadOperation : NSOperation

// 下载图片

// 下载好的网络图片
@property (nonatomic, strong) UIImage *image;

// 图片下载地址
@property (nonatomic, copy) NSString *urlString;

// 图片下载完成之后的 block 回调
@property (nonatomic, copy) completionBlock block;



/**
 *  自定义操作的实例化方法.
 *
 *  @param urlString        图片下载地址
 *  @param completionHandle 操作完成之后的回调.
 *
 *  @return 图片下载操作
 */
+(instancetype)downloadWebImageWithUrlString:(NSString *)urlString CompletionHandle:(completionBlock)completionHandle;

@end
