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

/// A type that provides HTTP header fields for a URL request.
public protocol HeaderFieldsProviderType
{
    /// The HTTP header fields.
    var headerFields: [String:String] { get }
}

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

    /// A default implementation, provided when conforming to `MethodProviderType` and `URLProviderType`.
    public var request: NSURLRequest?
    {
        return URL?.buildRequest(method: method)
    }
}

extension EndpointType where Self: MethodProviderType, Self: HeaderFieldsProviderType, Self: URLProviderType
{
    // MARK: - MethodProviderType, HeaderFieldsProviderType, & URLProviderType

    /// A default implementation, provided when conforming to `MethodProviderType`, `HeaderFieldsProviderType, and
    /// `URLProviderType`.
    public var request: NSURLRequest?
    {
        return URL?.buildRequest(method: method, headerFields: headerFields)
    }
}

extension EndpointType where Self: MethodProviderType, Self: URLProviderType, Self: QueryItemsProviderType
{
    /// A default implementation, provided when conforming to `MethodProviderType`, `URLProviderType`, and
    /// `QueryItemsProviderType`.
    public var request: NSURLRequest?
    {
        return URL?
            .transformWithComponents({ components in
                components.queryItems = queryItems
            })?
            .buildRequest(method: method)
    }
}

extension EndpointType where
    Self: MethodProviderType,
    Self: URLProviderType,
    Self: HeaderFieldsProviderType,
    Self: QueryItemsProviderType
{
    /// A default implementation, provided when conforming to `MethodProviderType`, `URLProviderType`
    /// `HeaderFieldsProviderType`, and `QueryItemsProviderType`.
    public var request: NSURLRequest?
    {
        return URL?
            .transformWithComponents({ components in
                components.queryItems = queryItems
            })?
            .buildRequest(method: method, headerFields: headerFields)
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
        return baseURL.buildRequest(method: method)
    }
}

extension BaseURLEndpointType where Self: MethodProviderType, Self: HeaderFieldsProviderType
{
    // MARK: - MethodProviderType & HeaderFieldsProviderType

    /**
    A default implementation of `BaseURLEndpointType`'s requirement.

    - parameter baseURL: The base URL.
    */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return baseURL.buildRequest(method: method, headerFields: headerFields)
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
        return NSURL(string: relativeURLString, relativeToURL: baseURL)?
            .buildRequest(method: method)
    }
}

extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: HeaderFieldsProviderType,
    Self: RelativeURLStringProviderType
{
    // MARK: - MethodProviderType, HeaderFieldsProviderType, & RelativeURLStringProviderType

    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURL(string: relativeURLString, relativeToURL: baseURL)?
            .buildRequest(method: method, headerFields: headerFields)
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
        return baseURL
            .transformWithComponents({ components in
                components.queryItems = queryItems
            })?
            .buildRequest(method: method)
    }
}

extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: HeaderFieldsProviderType,
    Self: QueryItemsProviderType
{
    // MARK: - MethodProviderType, HeaderFieldsProviderType, & QueryItemsProviderType

    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return baseURL
            .transformWithComponents({ components in
                components.queryItems = queryItems
            })?
            .buildRequest(method: method, headerFields: headerFields)
    }
}

extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: RelativeURLStringProviderType,
    Self: QueryItemsProviderType
{
    // MARK: - MethodProviderType, QueryItemsProviderType, & RelativeURLStringProviderType

    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURL(string: relativeURLString, relativeToURL: baseURL)?
            .transformWithComponents({ components in
                components.queryItems = queryItems
            })?
            .buildRequest(method: method)
    }
}

extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: HeaderFieldsProviderType,
    Self: RelativeURLStringProviderType,
    Self: QueryItemsProviderType
{
    // MARK: - MethodProviderType, HeaderFieldsProviderType, QueryItemsProviderType, & RelativeURLStringProviderType

    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURL(string: relativeURLString, relativeToURL: baseURL)?
            .transformWithComponents({ components in
                components.queryItems = queryItems
            })?
            .buildRequest(method: method, headerFields: headerFields)
    }
}
