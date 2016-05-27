//laowaiww

#import "LLWebImageDownloadOperation.h"
#import "NSString+SandBoxPath.h"

@implementation LLWebImageDownloadOperation


+(instancetype)downloadWebImageWithUrlString:(NSString *)urlString CompletionHandle:(completionBlock)completionHandle
{
    LLWebImageDownloadOperation *op = [[self alloc] init];
    
    // 确定操作中图片的下载地址.
    op.urlString = urlString;
    
    // 确定图片下载完成之后的block回调.
    op.block = completionHandle;
    
    return op;
}

// 操作一旦取消,这个时候操作有一个属性: cancelled 就是 YES ,在实际开发中,通过这个 BOOL 值的改变来判断操作是否已经取消.

-(void)main
{
    @autoreleasepool {
        
        NSLog(@"开始下载图片...");
        
        // 下载图片
        
        if (self.isCancelled) {
            
            return;
        }
       
        NSURL *url = [NSURL URLWithString:self.urlString];
        
        [NSThread sleepForTimeInterval:2];
        
        // 下载方法,是最耗时的. 在实际开发中,一般不会像下面一样调用同步的下载方法.
        // 实际下载过程是可以监测到的: ---- 网络第五天会学,通过频繁的调用代理方法,来拼接下载完毕的数据.一般在持续下载的代理方法中判断 isCancelled, 取消操作;
        
        
        if (self.isCancelled) {
            
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if (self.isCancelled) {
            
            return;
        }
        
        if (data) {
            
            // 存入沙盒...
            
            NSString *filePath = [self.urlString sandBoxfilePath];
        
            NSLog(@"filePath:%@",filePath);
            
            // [data writeToFile:filePath atomically:YES];
            
        }
        
        if (self.isCancelled) {
            
            return;
        }
        
        self.image = [UIImage imageWithData:data];
        
        if (self.isCancelled) {
            
            return;
        }
        
        // 在主线程执行图片下载完毕之后的回调.
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.block) {
                self.block(self);
            }
        });
    }
}

@end
