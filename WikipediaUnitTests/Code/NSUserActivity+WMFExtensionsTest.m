#import <XCTest/XCTest.h>
#import "NSUserActivity+WMFExtensions.h"

@interface NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test : XCTestCase
@end

@implementation NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test

- (void)testURLWithoutWikipediaSchemeReturnsNil {
    NSURL *url = [NSURL URLWithString:@"http://www.foo.com"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testInvalidArticleURLReturnsNil {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testArticleURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/wiki/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org/wiki/Foo");
}

- (void)testExploreURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://explore"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeExplore);
}

- (void)testSavedURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://saved"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeSavedPages);
}

- (void)testSearchURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/w/index.php?search=dog"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString,
                          @"https://en.wikipedia.org/w/index.php?search=dog&title=Special:Search&fulltext=1");
}

- (void)testPlacesURLWithArticle {
    NSString *testURLString = @"http://www.test.com";
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"wikipedia";
    components.host = @"places";
    components.queryItems = @[[NSURLQueryItem queryItemWithName:@"WMFArticleURL" value:testURLString]];
    NSURL *url = components.URL;
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, testURLString);
}

- (void)testPlacesURLWithCoordinates {
    NSNumber *longitude = @(-5.1);
    NSNumber *latitude = @(77.1);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"wikipedia://places?lon=%.6f&lat=%.6f", longitude.doubleValue, latitude.doubleValue]];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqualWithAccuracy([(NSNumber *)activity.userInfo[@"WMFPlacesLongitude"] doubleValue], longitude.doubleValue, 1e-6);
    XCTAssertEqualWithAccuracy([(NSNumber *)activity.userInfo[@"WMFPlacesLatitude"] doubleValue], latitude.doubleValue, 1e-6);
}

- (void)testPlacesURLWithIncorrectComponents {
    NSArray<NSURL *> *urls = @[
        [NSURL URLWithString:@"wikipedia://places?lon=10.1"],
        [NSURL URLWithString:@"wikipedia://places?lat=10.1"],
        [NSURL URLWithString:@"wikipedia://places?lon=abc&lat=22"],
        [NSURL URLWithString:@"wikipedia://places?lon=5.0&lat=abc"],
        [NSURL URLWithString:@"wikipedia://places?lon=180.5&lat=22"],
        [NSURL URLWithString:@"wikipedia://places?lon=-180.5&lat=22"],
        [NSURL URLWithString:@"wikipedia://places?lon=5.0&lat=90.5"],
        [NSURL URLWithString:@"wikipedia://places?lon=5.0&lat=-90.5"]
    ];

    for (NSURL *url in urls) {
        NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

        XCTAssertNil(activity.userInfo[@"WMFPlacesLongitude"]);
        XCTAssertNil(activity.userInfo[@"WMFPlacesLatitude"]);
    }
}

@end
