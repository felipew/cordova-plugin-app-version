#import "AppVersion.h"
#import <Cordova/CDVPluginResult.h>

@implementation AppVersion

- (void)getVersionNumber:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = command.callbackId;
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (version == nil) { // using cordova shouldn't fall here
      NSLog(@"CFBundleShortVersionString was nil, attempting CFBundleVersion");
      version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
      if (version == nil) {
        NSLog(@"CFBundleVersion was also nil, giving up");
        // not calling error callback here to maintain backward compatibility
      }
    }

    CDVPluginResult* pluginResult = nil;

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:version];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void) getBuildNumber: (CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    NSString* buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if( buildVersion == nil ) {
        // well, we dont have one, what a shame :(
        NSLog(@"Didn't find build number.. :(");
    }
    
    CDVPluginResult* pluginResult = nil;
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:buildVersion];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

@end
