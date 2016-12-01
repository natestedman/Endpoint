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

class EndpointProvidersTests: XCTestCase
{
    func testMethodProviderAndURLProvider()
    {
        struct Provider: Endpoint, MethodProvider, URLProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderBodyProviderAndURLProvider()
    {
        struct Provider: Endpoint, BodyProvider, MethodProvider, URLProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? HTTPBody
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPMethod = "POST"
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderHeaderFieldsProviderAndURLProvider()
    {
        struct Provider: Endpoint, MethodProvider, URLProvider, HeaderFieldsProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
            let headerFields = ["X-TEST": "TEST"]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderBodyProviderHeaderFieldsProviderAndURLProvider()
    {
        struct Provider: Endpoint, MethodProvider, BodyProvider, URLProvider, HeaderFieldsProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? HTTPBody
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderURLProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, MethodProvider, URLProvider, QueryItemsProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderBodyProviderURLProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, MethodProvider, BodyProvider, URLProvider, QueryItemsProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? HTTPBody
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderURLProviderHeaderFieldsProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, MethodProvider, URLProvider, QueryItemsProvider, HeaderFieldsProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderBodyProviderURLProviderHeaderFieldsProviderAndQueryItemsProvider()
    {
        struct Provider:
            Endpoint,
            BodyProvider,
            MethodProvider,
            URLProvider,
            QueryItemsProvider,
            HeaderFieldsProvider
        {
            let method = Method.Post
            let URL = NSURL(string: "http://test.com/")
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".dataUsingEncoding(NSUTF8StringEncoding) as? HTTPBody
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPBody = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        mutable.HTTPMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }
}
