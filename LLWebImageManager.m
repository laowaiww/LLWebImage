
//laowaiww

#import "LLWebImageManager.h"
#import "NSString+SandBoxPath.h"

@interface LLWebImageManager ()

@property (nonatomic, strong) NSOperationQueue *queue;

// 缓存: 内存缓存/操作缓存

// 内存缓存
@property (nonatomic, strong) NSMutableDictionary *images;

// 操作缓存
@property (nonatomic, strong) NSMutableDictionary *operations;

@end


@implementation LLWebImageManager

-(void)setUpWebImageWithUrlString:(NSString *)urlString setUpImageBlock:(setUpImageBlock)setUpImageHandle
{
    // setUpImageHandle : 就是外接调用传过来的block,这个block用来显示图片.
    
    
    // 0.0 先检测缓存中是否存在图片.
    
    // 0.1 检查内存缓存
    UIImage *image = self.images[urlString];
    
    if (image) { // 内存缓存中有图片. 直接显示
        
        NSLog(@"直接显示内存缓存中的图片...");
        if (setUpImageHandle) {
            setUpImageHandle(image);
        }
        
        return;
    }
    
    // 0.2 检查沙盒缓存
    UIImage *sandBoxImage = [UIImage imageWithContentsOfFile:[urlString sandBoxfilePath]];
    
    if (sandBoxImage) {
        
        NSLog(@"从沙盒缓存中取出图片");
        
        // 1. 显示图片
        if (setUpImageHandle) {
            setUpImageHandle(sandBoxImage);
        }
        
        // 2. 添加到内存缓存中
        [self.images setObject:sandBoxImage forKey:urlString];
        
        return;
    }

    // 1.0 创建操作之前,先检查操作是否已经存在.
    LLWebImageDownloadOperation *op = [self.operations objectForKey:urlString];
    
    if (op) { // op 存在,说明正在下载图片.
        
        NSLog(@"图片正在下载,请耐心等待...");
        
        return;
    }
    
    // 1.1 创建下载图片的操作.
    op = [LLWebImageDownloadOperation downloadWebImageWithUrlString:urlString CompletionHandle:^(LLWebImageDownloadOperation *downloadOp) {
        
        // comletionHandle : 这个block用来做什么?
        
        // 1. 图片下载完毕之后直接显示图片.
        if (setUpImageHandle) {
            setUpImageHandle(downloadOp.image);
        }
        
        // 2. 移除操作缓存中的操作
        [self.operations removeObjectForKey:urlString];
        
        // 3. 将图片添加到内存缓存中.
        if (downloadOp.image) {
            [self.images setObject:downloadOp.image forKey:urlString];
        }
        
    }];
    
    // 1.2 异步执行操作(添加操作到操作队列中).
    [self.queue addOperation:op];
    
    // 1.3 将操作添加到操作缓存中.
    [self.operations setObject:op forKey:urlString];
}

+(instancetype)sharedManager
{
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

-(NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(NSMutableDictionary *)images
{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

-(NSMutableDictionary *)operations
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}
@end
