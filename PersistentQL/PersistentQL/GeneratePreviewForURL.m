#include "shared.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
 Generate a preview for file
 
 This function's job is to create preview for designated file
 ----------------------------------------------------------------------------- */

//-----------------------------------------------------------------------------
OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    
    NSLog(@"Hello from peristent quicklook by csaby :)");
    NSURL *nsurl = (__bridge NSURL *)url;

     NSString* tempDir = NSTemporaryDirectory();
     NSString* tempDirFolder = [tempDir stringByAppendingPathComponent:@"TestPersist"];
     NSString *source = nsurl.path;
     NSString *theFileName = [[source lastPathComponent] stringByDeletingPathExtension];
     NSString *destination = [tempDirFolder stringByAppendingPathComponent:theFileName];
     NSError *error;
     NSFileManager *fileManager = [NSFileManager defaultManager];

     //create temp folder
     BOOL fileOK = [[NSFileManager defaultManager] createDirectoryAtPath:tempDirFolder withIntermediateDirectories:NO attributes:nil error:&error ];
     if ( !fileOK )
         NSLog(@"createDirectoryAtPath %@", [error localizedDescription]);
     
     //copy file
     if ([fileManager copyItemAtPath:source toPath:destination error:&error]){
         NSLog(@"Copy Success from: %@, to %@", source, destination);
     }
     else{
         NSLog(@"Copy error: %@", error);
     }
     
     //network test
     NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://www.google.com"]];
     NSLog(@"URL: %@", URLString);

  return noErr;
}

//-----------------------------------------------------------------------------
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
  // Implement only if supported
}


