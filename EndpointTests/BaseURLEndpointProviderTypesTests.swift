// Endpoint
// Written in 2016 by Nate Stedman <nate@natestedman.com>
//
// To the extent possible under law, the author(s) have dedicated all copyright and
// related and neighboring rights to this software to the public domain worldwide.
// This software is distributed without any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with
// this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

import Endpoint
import XCTest

class BaseURLEndpointProviderTypesTests: XCTestCase
{
    func testMethodProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType
        {
            let method = Method.Post
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndBodyProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, BodyProviderType
        {
            let method = Method.Post
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, HeaderFieldsProviderType
        {
            let method = Method.Post
            let headerFields = ["X-TEST": "TEST"]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, BodyProviderType, HeaderFieldsProviderType
        {
            let method = Method.Post
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, RelativeURLStringProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, BodyProviderType, RelativeURLStringProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderRelativeURLStringProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, RelativeURLStringProviderType, HeaderFieldsProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let headerFields = ["X-TEST": "TEST"]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test")!)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderRelativeURLStringProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, BodyProviderType, RelativeURLStringProviderType, HeaderFieldsProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndQueryProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, QueryItemsProviderType
        {
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderAndQueryProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, BodyProviderType, QueryItemsProviderType
        {
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderQueryProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, QueryItemsProviderType, HeaderFieldsProviderType
        {
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderQueryProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, BodyProviderType, QueryItemsProviderType, HeaderFieldsProviderType
        {
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderQueryProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, RelativeURLStringProviderType, QueryItemsProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test?foo=bar")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderQueryProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpointType, BodyProviderType, MethodProviderType, RelativeURLStringProviderType, QueryItemsProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test?foo=bar")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderQueryProviderHeaderFieldsProviderAndRelativeURLStringProvider()
    {
        struct Provider:
            BaseURLEndpointType,
            MethodProviderType,
            RelativeURLStringProviderType,
            QueryItemsProviderType,
            HeaderFieldsProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test?foo=bar")!)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderQueryProviderHeaderFieldsProviderAndRelativeURLStringProvider()
    {
        struct Provider:
            BaseURLEndpointType,
            MethodProviderType,
            BodyProviderType,
            RelativeURLStringProviderType,
            QueryItemsProviderType,
            HeaderFieldsProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? BodyType
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test?foo=bar")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testManualImplementation()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, RelativeURLStringProviderType, QueryItemsProviderType
        {
            let relativeURLString = "test"
            let method = Method.Post
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]

            private func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
            {
                return NSURLRequest(URL: NSURL(string: "http://different.com")!)
            }
        }

        let expected = NSURLRequest(URL: NSURL(string: "http://different.com")!)
        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), expected)
    }
}
