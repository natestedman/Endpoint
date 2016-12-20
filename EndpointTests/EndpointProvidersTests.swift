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
    func testHTTPMethodProviderAndURLProvider()
    {
        struct Provider: Endpoint, HTTPMethodProvider, URLProvider
        {
            let httpMethod = HTTPMethod.post
            let url = URL(string: "http://test.com/")
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testHTTPMethodProviderBodyProviderAndURLProvider()
    {
        struct Provider: Endpoint, BodyProvider, HTTPMethodProvider, URLProvider
        {
            let httpMethod = HTTPMethod.post
            let url = URL(string: "http://test.com/")
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)

        XCTAssertEqual(Provider().request, mutable)
    }

    func testHTTPMethodProviderHeaderFieldsProviderAndURLProvider()
    {
        struct Provider: Endpoint, HTTPMethodProvider, URLProvider, HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
            let url = URL(string: "http://test.com/")
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }

    func testHTTPMethodProviderBodyProviderHeaderFieldsProviderAndURLProvider()
    {
        struct Provider: Endpoint, HTTPMethodProvider, BodyProvider, URLProvider, HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
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

    func testHTTPMethodProviderURLProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, HTTPMethodProvider, URLProvider, QueryItemsProvider
        {
            let httpMethod = HTTPMethod.post
            let url = URL(string: "http://test.com/")
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testHTTPMethodProviderBodyProviderURLProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, HTTPMethodProvider, BodyProvider, URLProvider, QueryItemsProvider
        {
            let httpMethod = HTTPMethod.post
            let url = URL(string: "http://test.com/")
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let body = "Test".data(using: String.Encoding.utf8) as? HTTPBody
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpBody = "Test".data(using: String.Encoding.utf8)
        mutable.httpMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }

    func testHTTPMethodProviderURLProviderHeaderFieldsProviderAndQueryItemsProvider()
    {
        struct Provider: Endpoint, HTTPMethodProvider, URLProvider, QueryItemsProvider, HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
            let url = URL(string: "http://test.com/")
            let queryItems = [URLQueryItem(name: "foo", value: "bar")]
            let headerFields = ["X-TEST": "TEST"]
        }

        var mutable = URLRequest(url: URL(string: "http://test.com/?foo=bar")!)
        mutable.httpMethod = "POST"
        mutable.setValue("TEST", forHTTPHeaderField: "X-TEST")

        XCTAssertEqual(Provider().request, mutable)
    }

    func testHTTPMethodProviderBodyProviderURLProviderHeaderFieldsProviderAndQueryItemsProvider()
    {
        struct Provider:
            Endpoint,
            BodyProvider,
            HTTPMethodProvider,
            URLProvider,
            QueryItemsProvider,
            HeaderFieldsProvider
        {
            let httpMethod = HTTPMethod.post
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
