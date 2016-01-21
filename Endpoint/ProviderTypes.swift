// Endpoint
// Written in 2016 by Nate Stedman <nate@natestedman.com>
//
// To the extent possible under law, the author(s) have dedicated all copyright and
// related and neighboring rights to this software to the public domain worldwide.
// This software is distributed without any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with
// this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

import Foundation

// MARK: - Provider Types

/// A type that provides a relative URL string for a URL request.
public protocol RelativeURLStringProviderType
{
    /// The relative URL string.
    var relativeURLString: String { get }
}

/// A types that provides an HTTP method for a URL request.
public protocol MethodProviderType
{
    /// The HTTP method of the URL.
    var method: String { get }
}

/// A type that provides query items for a URL request.
public protocol QueryItemsProviderType
{
    /// The query items for the URL.
    var queryItems: [NSURLQueryItem] { get }
}

/// A type that provides a URL for a URL request.
public protocol URLProviderType
{
    /// The URL.
    var URL: NSURL? { get }
}

// MARK: - EndpointType Extensions
extension EndpointType where Self: MethodProviderType, Self: URLProviderType
{
    // MARK: - MethodProviderType & URLProviderType
    public var request: NSURLRequest?
    {
        return URL.flatMap({ URL in
            let request = NSMutableURLRequest(URL: URL)
            request.HTTPMethod = method
            return request
        })
    }
}

// MARK: - BaseURLEndpointType Extensions
extension BaseURLEndpointType where Self: MethodProviderType
{
    // MARK: - MethodProviderType

    /**
    A default implementation of `BaseURLEndpointType`'s requirement.

    - parameter baseURL: The base URL.
    */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        let request = NSMutableURLRequest(URL: baseURL)
        request.HTTPMethod = method
        return request
    }
}

extension BaseURLEndpointType where Self: MethodProviderType, Self: RelativeURLStringProviderType
{
    // MARK: - MethodProviderType & RelativeURLStringProviderType

    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURL(string: relativeURLString, relativeToURL: baseURL).map({ URL in
            let request = NSMutableURLRequest(URL: URL)
            request.HTTPMethod = method
            return request
        })
    }
}

extension BaseURLEndpointType where Self: MethodProviderType, Self: QueryItemsProviderType
{
    // MARK: - MethodProviderType & QueryItemsProviderType

    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURLComponents(URL: baseURL, resolvingAgainstBaseURL: true)
            .flatMap({ components -> NSURL? in
                components.queryItems = queryItems
                return components.URL
            })
            .map({ URL in
                let request = NSMutableURLRequest(URL: URL)
                request.HTTPMethod = method
                return request
            })
    }
}

extension BaseURLEndpointType where Self: MethodProviderType, Self: RelativeURLStringProviderType, Self: QueryItemsProviderType
{
    // MARK: - MethodProviderType, QueryItemsProviderType, & RelativeURLStringProviderType

    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURL(string: relativeURLString, relativeToURL: baseURL)
            .flatMap({ URL in
                NSURLComponents(URL: URL, resolvingAgainstBaseURL: true)
            })
            .flatMap({ components -> NSURL? in
                components.queryItems = queryItems
                return components.URL
            })
            .map({ URL in
                let request = NSMutableURLRequest(URL: URL)
                request.HTTPMethod = method
                return request
            })
    }
}
