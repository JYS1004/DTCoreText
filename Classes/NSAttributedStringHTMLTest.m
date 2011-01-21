//
//  NSAttributedStringHTMLTest.m
//  CoreTextExtensions
//
//  Created by Claus Broch on 11/01/11.
//  Copyright 2011 Drobnik.com. All rights reserved.
//

#import "NSAttributedStringHTMLTest.h"
#import "NSAttributedString+HTML.h"

@implementation NSAttributedStringHTMLTest

- (void)testParagraphs
{
	NSString *html = @"Prefix<p>One\ntwo\n<br>three</p><p>New Paragraph</p>Suffix";
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data documentAttributes:NULL];
	NSData *dump = [[string string] dataUsingEncoding:NSUTF8StringEncoding];
	NSString *resultOnIOS = [dump description];
	
	NSString *resultOnMac = @"<50726566 69780a4f 6e652074 776f20e2 80a87468 7265650a 4e657720 50617261 67726170 680a5375 66666978>";
	
	STAssertEqualObjects(resultOnIOS, resultOnMac, @"Output on Paragraph Test differs");
}


- (void)testHeaderParagraphs
{
	NSString *html = @"Prefix<h1>One</h1><h2>One</h2><h3>One</h3><h4>One</h4><h5>One</h5><p>New Paragraph</p>Suffix";
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data documentAttributes:NULL];
	NSData *dump = [[string string] dataUsingEncoding:NSUTF8StringEncoding];
	NSString *resultOnIOS = [dump description];
	
	NSString *resultOnMac = @"<50726566 69780a4f 6e650a4f 6e650a4f 6e650a4f 6e650a4f 6e650a4e 65772050 61726167 72617068 0a537566 666978>";
	
	STAssertEqualObjects(resultOnIOS, resultOnMac, @"Output on Paragraph Test differs");
}


- (void)testListParagraphs
{
	NSString *html = @"<p>Before</p><ul><li>One</li><li>Two</li></ul><p>After</p>";	
	
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data documentAttributes:NULL];
	NSData *dump = [[string string] dataUsingEncoding:NSUTF8StringEncoding];
	NSString *resultOnIOS = [dump description];
	
	NSString *resultOnMac = @"<4265666f 72650a09 e280a209 4f6e650a 09e280a2 0954776f 0a416674 65720a>";
	
	STAssertEqualObjects(resultOnIOS, resultOnMac, @"Output on List Test differs");
}

- (void)testImageParagraphs
{
	NSString *html = @"<p>Before</p><img src=\"Oliver.jpg\"><h1>Header</h2><p>after</p><p>Some inline <img src=\"Oliver.jpg\"> text.</p>";	
	
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data documentAttributes:NULL];
	NSData *dump = [[string string] dataUsingEncoding:NSUTF8StringEncoding];
	NSString *resultOnIOS = [dump description];
	
	NSString *resultOnMac = @"<4265666f 72650aef bfbc0a48 65616465 720a6166 7465720a 536f6d65 20696e6c 696e6520 efbfbc20 74657874 2e0a>";
	
	STAssertEqualObjects(resultOnIOS, resultOnMac, @"Output on List Test differs");
}

- (void)testSpaceNormalization
{
	NSString *html = @"<p>Now there is some <b>bold</b>\ntext and  spaces\n    should be normalized.</p>";	
	
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data documentAttributes:NULL];
	NSData *dump = [[string string] dataUsingEncoding:NSUTF8StringEncoding];
	NSString *resultOnIOS = [dump description];
	
	NSString *resultOnMac = @"<4e6f7720 74686572 65206973 20736f6d 6520626f 6c642074 65787420 616e6420 73706163 65732073 686f756c 64206265 206e6f72 6d616c69 7a65642e 0a>";
	
	STAssertEqualObjects(resultOnIOS, resultOnMac, @"Output on List Test differs");
}

- (void)testSpaceAndNewlines
{
	NSString *html = @"<a>bla</a>\nfollows\n<font color=\"blue\">NSString</font> <font color=\"purple\">*</font>str <font color=\"#000000\">=</font> @<font color=\"#E40000\">\"The Quick Brown Fox Brown\"</font>;";
	
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data documentAttributes:NULL];
	NSData *dump = [[string string] dataUsingEncoding:NSUTF8StringEncoding];
	NSString *resultOnIOS = [dump description];
	
	NSString *resultOnMac = @"<626c6120 666f6c6c 6f777320 4e535374 72696e67 202a7374 72203d20 40225468 65205175 69636b20 42726f77 6e20466f 78204272 6f776e22 3b>";
	
	STAssertEqualObjects(resultOnIOS, resultOnMac, @"Output on List Test differs");
}






@end
