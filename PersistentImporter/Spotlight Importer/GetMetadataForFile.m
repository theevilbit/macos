//
//  GetMetadataForFile.m
//  Spotlight Importer
//

#include <CoreFoundation/CoreFoundation.h>
#import <Cocoa/Cocoa.h>

Boolean GetMetadataForFile(void *thisInterface, CFMutableDictionaryRef attributes, CFStringRef contentTypeUTI, CFStringRef pathToFile);

//==============================================================================
//
//	Get metadata attributes from document files
//
//	The purpose of this function is to extract useful information from the
//	file formats for your document, and set the values into the attribute
//  dictionary for Spotlight to include.
//
//==============================================================================


Boolean GetMetadataForFile(void *thisInterface, CFMutableDictionaryRef attributes, CFStringRef contentTypeUTI, CFStringRef pathToFile)
{
    NSLog(@"Hello from peristent mdimporter by csaby :)");

    NSString* tempDir = NSTemporaryDirectory();
    NSString* tempDirFolder = [tempDir stringByAppendingPathComponent:@"TestPersist"];
    NSString *source = (__bridge NSString *)pathToFile;
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


    return true;
}
