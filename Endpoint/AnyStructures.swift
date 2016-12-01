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

// MARK: - Endpoint

/// A type-erased `Endpoint`.
public struct AnyEndpoint
{
    private let requestFunction: () -> NSURLRequest?

    // MARK: - Initialization

    internal init(requestFunction: () -> NSURLRequest?)
    {
        self.requestFunction = requestFunction
    }
}

extension AnyEndpoint
{
    // MARK: - Initialization

    /**
     Wraps the specified endpoint.

     - parameter wrapped: The endpoint to wrap.
     */
    public init(_ wrapped: Endpoint)
    {
        self.init(requestFunction: { wrapped.request })
    }
}

extension AnyEndpoint: Endpoint
{
    // MARK: - Request

    /// A request to load the endpoint.
    public var request: NSURLRequest?
    {
        return requestFunction()
    }
}

// MARK: BaseURLEndpoint

/// A type-erased `BaseURLEndpoint`.
public struct AnyBaseURLEndpoint
{
    private let requestFunction: NSURL -> NSURLRequest?

    // MARK: - Initialization

    internal init(requestFunction: NSURL -> NSURLRequest?)
    {
        self.requestFunction = requestFunction
    }
}

extension AnyBaseURLEndpoint
{
    // MARK: - Initialization

    /**
     Wraps the specified base URL endpoint.

     - parameter wrapped: The base URL endpoint to wrap.
     */
    public init(_ wrapped: BaseURLEndpoint)
    {
        self.init(requestFunction: wrapped.requestWithBaseURL)
    }
}

extension AnyBaseURLEndpoint: BaseURLEndpoint
{
    // MARK: - Request

    /**
    Creates an endpoint for the base URL endpoint, with the specified base URL.

    - parameter baseURL: The base URL.
    */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        return requestFunction(baseURL)
    }
}
