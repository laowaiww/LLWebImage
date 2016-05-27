
//laowaiww

#import "NSString+SandBoxPath.h"

@implementation NSString (SandBoxPath)

-(NSString *)sandBoxfilePath
{
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    filePath = [filePath stringByAppendingPathComponent:self.lastPathComponent];
    
    return filePath;
}


@end
