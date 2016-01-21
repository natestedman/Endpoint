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

// MARK: - EndpointType

/// A type-erased `EndpointType`.
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
    public init(_ wrapped: EndpointType)
    {
        self.init(requestFunction: { wrapped.request })
    }
}

extension AnyEndpoint: EndpointType
{
    // MARK: - Request

    /// A request to load the endpoint.
    public var request: NSURLRequest?
    {
        return requestFunction()
    }
}
