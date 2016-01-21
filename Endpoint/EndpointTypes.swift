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

/// An endpoint, which provides a URL request to load itself.
public protocol EndpointType
{
    // MARK: - Requests

    /// A request to load the endpoint.
    var request: NSURLRequest? { get }
}

// MARK: - Base URL

/// A relative URL endpoint, which provides a URL request given a base URL.
///
/// This type can be used to implement switchable backends, e.g. production, staging, development.
public protocol BaseURLEndpointType
{
    // MARK: - Requests

    /**
    Creates a request to load the base URL endpoint, with the specified base URL.

    - parameter baseURL: The base URL.
    */
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
}

extension BaseURLEndpointType
{
    // MARK: - Endpoint

    /**
     Creates an endpoint for the base URL endpoint, with the specified base URL.

     - parameter baseURL: The base URL.
     */
    public func endpointWithBaseURL(baseURL: NSURL) -> AnyEndpoint
    {
        return AnyEndpoint { self.requestWithBaseURL(baseURL) }
    }
}
