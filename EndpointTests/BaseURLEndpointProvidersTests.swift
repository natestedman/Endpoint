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

class BaseURLEndpointProvidersTests: XCTestCase
{
    func testHTTPMethodProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider
        {
            let httpMethod = HTTPMethod.post
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderAndBodyProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, BodyProvider
        {
            let httpMethod = HTTPMethod.post
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderBodyProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, BodyProvider, HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, RelativeURLStringProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderBodyProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, BodyProvider, RelativeURLStringProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderRelativeURLStringProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, RelativeURLStringProvider, HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderBodyProviderRelativeURLStringProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, BodyProvider, RelativeURLStringProvider, HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderAndQueryProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, QueryItemsProvider
        {
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderBodyProviderAndQueryProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, BodyProvider, QueryItemsProvider
        {
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderQueryProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, QueryItemsProvider, HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderBodyProviderQueryProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, BodyProvider, QueryItemsProvider, HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderQueryProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, RelativeURLStringProvider, QueryItemsProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test?foo=bar")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderBodyProviderQueryProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, BodyProvider, HTTPMethodProvider, RelativeURLStringProvider, QueryItemsProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderQueryProviderHeaderFieldsProviderAndRelativeURLStringProvider()
    {
        struct Provider:
            BaseURLEndpoint,
            HTTPMethodProvider,
            RelativeURLStringProvider,
            QueryItemsProvider,
            HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test?foo=bar")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testHTTPMethodProviderBodyProviderQueryProviderHeaderFieldsProviderAndRelativeURLStringProvider()
    {
        struct Provider:
            BaseURLEndpoint,
            HTTPMethodProvider,
            BodyProvider,
            RelativeURLStringProvider,
            QueryItemsProvider,
            HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testManualImplementation()
    {
        struct Provider: BaseURLEndpoint, HTTPMethodProvider, RelativeURLStringProvider, QueryItemsProvider
        {
            let relativeURLString = "test"
            let httpMethod = HTTPMethod.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]

            fileprivate func request(baseURL: URL) -> URLRequest?
            {
                return URLRequest(url: URL(string: "http://different.com")!)
            }
        }

        let expected = URLRequest(url: URL(string: "http://different.com")!)
        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), expected)
    }
}
