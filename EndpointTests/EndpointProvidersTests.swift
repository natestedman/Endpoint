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
            let method = Method.post
            let url = URL(string: "http://test.com/")
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderBodyProviderAndURLProvider()
    {
        struct Provider: Endpoint, BodyProvider, MethodProvider, URLProvider
        {
            let method = Method.post
            let url = URL(string: "http://test.com/")
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderHeaderFieldsProviderAndURLProvider()
    {
        struct Provider: Endpoint, MethodProvider, URLProvider, HeaderFieldsProvider
        {
            let method = Method.post
            let url = URL(string: "http://test.com/")
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderBodyProviderHeaderFieldsProviderAndURLProvider()
    {
        struct Provider: Endpoint, MethodProvider, BodyProvider, URLProvider, HeaderFieldsProvider
        {
            let method = Method.post
            let url = URL(string: "http://test.com/")
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderURLProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, MethodProvider, URLProvider, QueryItemsProvider
        {
            let method = Method.post
            let url = URL(string: "http://test.com/")
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderBodyProviderURLProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, MethodProvider, BodyProvider, URLProvider, QueryItemsProvider
        {
            let method = Method.post
            let url = URL(string: "http://test.com/")
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testMethodProviderURLProviderHeaderFieldsProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, MethodProvider, URLProvider, QueryItemsProvider, HeaderFieldsProvider
        {
            let method = Method.post
            let url = URL(string: "http://test.com/")
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"
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
            let method = Method.post
            let url = URL(string: "http://test.com/")
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }
}
