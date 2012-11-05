//
//  RootViewController.m
//  ShareWokaholicModified
//
//  Created by Haifa Carina Baluyos on 11/5/12.
//  Copyright (c) 2012 NMG Resources, Inc. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize facebook;

- (void) postButtonClicked: (id) sender {
    NSLog(@"postButtonClicked");
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![facebook isSessionValid]) {
        NSLog(@"START sSessionValid");
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes",
                                @"read_stream",@"user_about_me", @"publish_stream", @"user_photos",
                                nil];
        [facebook authorize:permissions];
        NSLog(@"PERMISSION DONE");
        [permissions release];
        UIImage *image = [UIImage imageNamed:@"spongebob.png"];
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        image, @"source",
                                        @"caption desc", @"message",
                                        nil];
        [facebook requestWithGraphPath:@"/me/photos"
                             andParams:params1 andHttpMethod:@"POST" andDelegate:self];
        NSLog(@"REQUEST DONE");
    }
    NSLog(@"END sSessionValid");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    facebook = [[Facebook alloc] initWithAppId:@"473718806005934" andDelegate:self];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postButton.frame = CGRectMake(40, 40, 200, 40);
    [postButton setTitle:@"Post" forState:UIControlStateNormal];
    [postButton addTarget:self action:@selector(postButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:postButton];
    NSLog(@"oyeah");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Facebook Methods
// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"Pre iOS 4.2 support");
    return [facebook handleOpenURL:url];
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"For iOS 4.2+ support ");
    return [facebook handleOpenURL:url];
}

- (void)fbDidLogin {
    NSLog(@"fbDidLogin ");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    UIImage *image = [UIImage imageNamed:@"spongebob.png"];
    NSLog(@"PLEASE WOOOOORK! T___T ");
    NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    image, @"source",
                                    @"Yeheeey!", @"message",
                                    nil];
    [facebook requestWithGraphPath:@"/me/photos"
                         andParams:params1 andHttpMethod:@"POST" andDelegate:self];
    NSLog(@"YEY! IT WORKED! T___T ");
    
}
- (void) fbDidLogout {
    NSLog(@"fbDidLogout ");
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}

-(void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"Request didLoad: %@ ", [request url ]);
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    if ([result isKindOfClass:[NSDictionary class]]){
        
    }
    if ([result isKindOfClass:[NSData class]]) {
    }
    NSLog(@"request returns %@",result);
}



@end
