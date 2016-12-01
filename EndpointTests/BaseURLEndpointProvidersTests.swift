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
    func testMethodProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider
        {
            let method = Method.post
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndBodyProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, BodyProvider
        {
            let method = Method.post
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, HeaderFieldsProvider
        {
            let method = Method.post
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, BodyProvider, HeaderFieldsProvider
        {
            let method = Method.post
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, RelativeURLStringProvider
        {
            let relativeURLString = "test"
            let method = Method.post
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, BodyProvider, RelativeURLStringProvider
        {
            let relativeURLString = "test"
            let method = Method.post
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderRelativeURLStringProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, RelativeURLStringProvider, HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let method = Method.post
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderRelativeURLStringProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, BodyProvider, RelativeURLStringProvider, HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let method = Method.post
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderAndQueryProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, QueryItemsProvider
        {
            let method = Method.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderAndQueryProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, BodyProvider, QueryItemsProvider
        {
            let method = Method.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderQueryProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, QueryItemsProvider, HeaderFieldsProvider
        {
            let method = Method.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderQueryProviderAndHeaderFieldsProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, BodyProvider, QueryItemsProvider, HeaderFieldsProvider
        {
            let method = Method.post
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

    func testMethodProviderQueryProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, MethodProvider, RelativeURLStringProvider, QueryItemsProvider
        {
            let relativeURLString = "test"
            let method = Method.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test?foo=bar")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderQueryProviderAndRelativeURLStringProvider()
    {
        struct Provider: BaseURLEndpoint, BodyProvider, MethodProvider, RelativeURLStringProvider, QueryItemsProvider
        {
            let relativeURLString = "test"
            let method = Method.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderQueryProviderHeaderFieldsProviderAndRelativeURLStringProvider()
    {
        struct Provider:
            BaseURLEndpoint,
            MethodProvider,
            RelativeURLStringProvider,
            QueryItemsProvider,
            HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let method = Method.post
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/test?foo=bar")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request(baseURL: URL(string: "http://test.com/")!), mutable)
    }

    func testMethodProviderBodyProviderQueryProviderHeaderFieldsProviderAndRelativeURLStringProvider()
    {
        struct Provider:
            BaseURLEndpoint,
            MethodProvider,
            BodyProvider,
            RelativeURLStringProvider,
            QueryItemsProvider,
            HeaderFieldsProvider
        {
            let relativeURLString = "test"
            let method = Method.post
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
        struct Provider: BaseURLEndpoint, MethodProvider, RelativeURLStringProvider, QueryItemsProvider
        {
            let relativeURLString = "test"
            let method = Method.post
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
