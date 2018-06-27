//
// Created by Dominik Ostrowski on 27.06.2018.
// Copyright (c) 2018 Dominik Ostrowski. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ReadRequester.h"
#import "RequestFactory.h"
#import "CompletionHandlerBlock.h"

SPEC_BEGIN(ReadRequesterTests)

describe(@"ReadRequesterTests", ^{

	__block id mockDataTask;
	__block id mockRequest;
	__block id mockRequestFactory;
	__block id mockSession;
	
	NSString *testUser = @"userro";
	NSNumber *offset = @44;
	NSNumber *size = @54;

	__block ReadRequester *sut;

	beforeEach(^{
		mockDataTask = NSURLSessionDataTask.mock;
		mockRequest = NSURLRequest.mock;
		mockRequestFactory = [KWMock mockForProtocol:@protocol(RequestFactory)];
		mockSession = NSURLSession.mock;

		sut = [ReadRequester.alloc initWithRequestFactory:mockRequestFactory
											   andSession:mockSession];
	});

	context(@"-makeRequestForPostsForUser:withOffset:size:successBlock:failureBlock:", ^{
		it(@"should create data task with proper request", ^{
			[mockRequestFactory stub:@selector(createReadRequestForUser:withOffset:size:) andReturn:mockRequest withArguments:testUser, offset, size];
			
			[[mockSession should] receive:@selector(dataTaskWithRequest:completionHandler:) withArguments:mockRequest, kw_any()];
			
			[sut makeRequestForPostsForUser:testUser
								 withOffset:offset
									   size:size
							   successBlock:nil
							   failureBlock:nil];
		});
		
		it(@"should resume task after creation", ^{
			[mockRequestFactory stub:@selector(createReadRequestForUser:withOffset:size:)];
			[mockSession stub:@selector(dataTaskWithRequest:completionHandler:) andReturn:mockDataTask];
			
			[[mockDataTask should] receive:@selector(resume)];
			
			[sut makeRequestForPostsForUser:testUser
								 withOffset:offset
									   size:size
							   successBlock:nil
							   failureBlock:nil];
		});
		
		context(@"completionHandler", ^{
			
			__block CompletionHandlerBlock capturedBlock;
			__block CompletionSuccessBlock successBlock;
			__block CompletionFailureBlock failureBlock;
			
			beforeEach(^{
				[mockRequestFactory stub:@selector(createReadRequestForUser:withOffset:size:)];
				[mockSession stub:@selector(dataTaskWithRequest:completionHandler:) withBlock:^id(NSArray *params) {
					capturedBlock = (CompletionHandlerBlock)params[1];
					return nil;
				}];
				successBlock = ^(NSDictionary *responseBody, NSData *data, NSURLResponse *response) {
					fail(@"unexpected success block call");
				};
				failureBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
					fail(@"unexpected failure block call");
				};
				
				[sut makeRequestForPostsForUser:testUser
									 withOffset:offset
										   size:size
								   successBlock:^(NSDictionary *responseBody, NSData *data, NSURLResponse *response) {
									   successBlock(responseBody, data, response);
										   }
								   failureBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
									   failureBlock(data, response, error);
								   }];
				
				[mockRequestFactory clearStubs];
				[mockSession clearStubs];
			});
			
			it(@"should fail if error", ^{
				__block BOOL failureCalled = NO;
				
				failureBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
					failureCalled = YES;
				};
				
				capturedBlock(nil, nil, NSError.alloc.init);
				
				[[theValue(failureCalled) should] beYes];
			});
			
			it(@"should fail if response is not from http", ^{
				__block BOOL failureCalled = NO;
				
				failureBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
					failureCalled = YES;
				};
				
				capturedBlock(nil, NSURLResponse.mock, nil);
				
				[[theValue(failureCalled) should] beYes];
			});
			
			it(@"should fail if status code outside <200,300)", ^{
				__block int failures = 0;
				
				failureBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
					failures++;
				};
				
				NSHTTPURLResponse *mockResponse = NSHTTPURLResponse.mock;
				[mockResponse stub:@selector(statusCode) andReturn:theValue(143)];
				capturedBlock(NSData.mock, mockResponse, nil);
				[mockResponse stub:@selector(statusCode) andReturn:theValue(300)];
				capturedBlock(NSData.mock, mockResponse, nil);
				[mockResponse stub:@selector(statusCode) andReturn:theValue(523)];
				capturedBlock(NSData.mock, mockResponse, nil);
				[mockResponse stub:@selector(statusCode) andReturn:theValue(423)];
				capturedBlock(NSData.mock, mockResponse, nil);
				[mockResponse stub:@selector(statusCode) andReturn:theValue(0)];
				capturedBlock(NSData.mock, mockResponse, nil);
				
				[[theValue(failures) should] equal:theValue(5)];
			});
			
			it(@"should not fail with short string and pass it to parser", ^{
				__block BOOL successCalled = NO;
				
				NSHTTPURLResponse *mockResponse = NSHTTPURLResponse.mock;
				NSDictionary *mockParsed = NSDictionary.mock;
				[mockResponse stub:@selector(statusCode) andReturn:theValue(208)];
				NSData *testData = [@"it has exactly 24 chars " dataUsingEncoding:NSUTF8StringEncoding];
				[NSJSONSerialization stub:@selector(JSONObjectWithData:options:error:) andReturn:mockParsed withArguments:testData, theValue(0), kw_any()];
				successBlock = ^(NSDictionary *responseBody, NSData *data, NSURLResponse *response) {
					successCalled = YES;
					[[responseBody should] equal:mockParsed];
				};
				
				capturedBlock(testData, mockResponse, nil);
				
				[[theValue(successCalled) should] beYes];
			});
			
			it(@"should strip tumblr variable assignment", ^{
				__block BOOL successCalled = NO;
				
				NSHTTPURLResponse *mockResponse = NSHTTPURLResponse.mock;
				NSDictionary *mockParsed = NSDictionary.mock;
				[mockResponse stub:@selector(statusCode) andReturn:theValue(208)];
				NSData *testData = [@"var tumblr_api_read = {};\n" dataUsingEncoding:NSUTF8StringEncoding];
				NSData *correctData = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
				[NSJSONSerialization stub:@selector(JSONObjectWithData:options:error:) andReturn:mockParsed
							withArguments:correctData, theValue(0), kw_any()];
				successBlock = ^(NSDictionary *responseBody, NSData *data, NSURLResponse *response) {
					successCalled = YES;
					[[responseBody should] equal:mockParsed];
				};
				
				capturedBlock(testData, mockResponse, nil);
				
				[[theValue(successCalled) should] beYes];
			});
			
			it(@"should fail if prasing failed", ^{
				__block BOOL failureCalled = NO;
				
				failureBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
					failureCalled = YES;
				};
				
				NSHTTPURLResponse *mockResponse = NSHTTPURLResponse.mock;
				[mockResponse stub:@selector(statusCode) andReturn:theValue(208)];
				NSData *testData = [@"var tumblr_api_read = {};\n" dataUsingEncoding:NSUTF8StringEncoding];
				[NSJSONSerialization stub:@selector(JSONObjectWithData:options:error:) withBlock:^id(NSArray *params) {
					NSValue * errVal = params[2];
					NSError * __autoreleasing * errPtr = (NSError * __autoreleasing *)[errVal pointerValue];
					*errPtr = NSError.alloc.init;
					return nil;
				}];
				
				capturedBlock(testData, mockResponse, nil);
				
				[[theValue(failureCalled) should] beYes];
			});
		});
	});
});

SPEC_END
