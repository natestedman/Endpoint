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

// MARK: - MethodProviderType & URLProviderType
extension EndpointType where Self: MethodProviderType, Self: URLProviderType
{
    /// A default implementation, provided when conforming to `MethodProviderType` and `URLProviderType`.
    public var request: NSURLRequest?
    {
        return URL?.buildRequest(method: method)
    }
}

// MARK: - MethodProviderType, HeaderFieldsProviderType, & URLProviderType
extension EndpointType where Self: MethodProviderType, Self: HeaderFieldsProviderType, Self: URLProviderType
{
    /// A default implementation, provided when conforming to `MethodProviderType`, `HeaderFieldsProviderType, and
    /// `URLProviderType`.
    public var request: NSURLRequest?
    {
        return URL?.buildRequest(method: method, headerFields: headerFields)
    }
}

// MARK: - MethodProviderType, URLProviderType, & QueryItemsProviderType
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

// MARK: - MethodProviderType, URLProviderType, HeaderFieldsProviderType, & QueryItemsProviderType
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
