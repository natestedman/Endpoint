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

// MARK: - MethodProviderType
extension BaseURLEndpointType where Self: MethodProviderType
{
    /**
    A default implementation of `BaseURLEndpointType`'s requirement.

    - parameter baseURL: The base URL.
    */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return baseURL.buildRequest(method: method)
    }
}

// MARK: - MethodProviderType & BodyProviderType
extension BaseURLEndpointType where Self: MethodProviderType, Self: BodyProviderType
{
    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return baseURL.buildRequest(method: method, body: body)
    }
}

// MARK: - MethodProviderType & HeaderFieldsProviderType
extension BaseURLEndpointType where Self: MethodProviderType, Self: HeaderFieldsProviderType
{
    /**
    A default implementation of `BaseURLEndpointType`'s requirement.

    - parameter baseURL: The base URL.
    */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return baseURL.buildRequest(method: method, headerFields: headerFields)
    }
}

// MARK: - MethodProviderType, HeaderFieldsProviderType, & BodyProviderType
extension BaseURLEndpointType where Self: MethodProviderType, Self: HeaderFieldsProviderType, Self: BodyProviderType
{
    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return baseURL.buildRequest(method: method, headerFields: headerFields, body: body)
    }
}

// MARK: - MethodProviderType & RelativeURLStringProviderType
extension BaseURLEndpointType where Self: MethodProviderType, Self: RelativeURLStringProviderType
{
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

// MARK: - MethodProviderType, RelativeURLStringProviderType, & BodyProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: RelativeURLStringProviderType,
    Self: BodyProviderType
{
    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURL(string: relativeURLString, relativeToURL: baseURL)?
            .buildRequest(method: method, body: body)
    }
}

// MARK: - MethodProviderType, HeaderFieldsProviderType, & RelativeURLStringProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: HeaderFieldsProviderType,
    Self: RelativeURLStringProviderType
{
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

// MARK: - MethodProviderType, BodyProviderType, HeaderFieldsProviderType, & RelativeURLStringProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: BodyProviderType,
    Self: HeaderFieldsProviderType,
    Self: RelativeURLStringProviderType
{
    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return NSURL(string: relativeURLString, relativeToURL: baseURL)?
            .buildRequest(method: method, headerFields: headerFields, body: body)
    }
}

// MARK: - MethodProviderType & QueryItemsProviderType
extension BaseURLEndpointType where Self: MethodProviderType, Self: QueryItemsProviderType
{
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

// MARK: - MethodProviderType, BodyProviderType, & QueryItemsProviderType
extension BaseURLEndpointType where Self: MethodProviderType, Self: BodyProviderType, Self: QueryItemsProviderType
{
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
            .buildRequest(method: method, body: body)
    }
}

// MARK: - MethodProviderType, HeaderFieldsProviderType, & QueryItemsProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: HeaderFieldsProviderType,
    Self: QueryItemsProviderType
{
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

// MARK: - MethodProviderType, BodyProviderType, HeaderFieldsProviderType, & QueryItemsProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: BodyProviderType,
    Self: HeaderFieldsProviderType,
    Self: QueryItemsProviderType
{
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
            .buildRequest(method: method, headerFields: headerFields, body: body)
    }
}

// MARK: - MethodProviderType, QueryItemsProviderType, & RelativeURLStringProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: RelativeURLStringProviderType,
    Self: QueryItemsProviderType
{
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

// MARK: - MethodProviderType, BodyProviderType, QueryItemsProviderType, & RelativeURLStringProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: BodyProviderType,
    Self: RelativeURLStringProviderType,
    Self: QueryItemsProviderType
{
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
            .buildRequest(method: method, body: body)
    }
}

// MARK: - MethodProviderType, HeaderFieldsProviderType, QueryItemsProviderType, & RelativeURLStringProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: HeaderFieldsProviderType,
    Self: RelativeURLStringProviderType,
    Self: QueryItemsProviderType
{
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

// MARK: - MethodProviderType, BodyProviderType, HeaderFieldsProviderType, QueryItemsProviderType, & RelativeURLStringProviderType
extension BaseURLEndpointType where
    Self: MethodProviderType,
    Self: BodyProviderType,
    Self: HeaderFieldsProviderType,
    Self: RelativeURLStringProviderType,
    Self: QueryItemsProviderType
{
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
            .buildRequest(method: method, headerFields: headerFields, body: body)
    }
}
