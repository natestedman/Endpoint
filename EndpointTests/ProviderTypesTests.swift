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

class ProviderTypeTests: XCTestCase
{
    func testMethodProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType
        {
            let method = "POST"
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, RelativeURLStringProviderType
        {
            let relativeURLString = "test"
            let method = "POST"
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testQueryProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, QueryItemsProviderType
        {
            let method = "POST"
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/?foo=bar")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testQueryProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, RelativeURLStringProviderType, QueryItemsProviderType
        {
            let relativeURLString = "test"
            let method = "POST"
            let queryItems = [NSURLQueryItem(name: "foo", value: "bar")]
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/test?foo=bar")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().requestWithBaseURL(NSURL(string: "http://test.com/")!), mutable)
    }

    func testManualImplementation()
    {
        struct Provider: BaseURLEndpointType, MethodProviderType, RelativeURLStringProviderType, QueryItemsProviderType
        {
            let relativeURLString = "test"
            let method = "POST"
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
