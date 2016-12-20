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

/// A type that provides an HTTP body for a URL request.
public protocol BodyProvider
{
    /// The HTTP body for the request.
    var body: HTTPBody? { get }
}

/// A type that provides HTTP header fields for a URL request.
public protocol HeaderFieldsProvider
{
    /// The HTTP header fields.
    var headerFields: [String:String] { get }
}

/// A type that provides a relative URL string for a URL request.
public protocol RelativeURLStringProvider
{
    /// The relative URL string.
    var relativeURLString: String { get }
}

/// A types that provides an HTTP method for a URL request.
public protocol HTTPMethodProvider
{
    /// The HTTP method of the URL.
    var httpMethod: HTTPMethod { get }
}

/// A type that provides query items for a URL request.
public protocol QueryItemsProvider
{
    /// The query items for the URL.
    var queryItems: [URLQueryItem] { get }
}

/// A type that provides a URL for a URL request.
public protocol URLProvider
{
    /// The URL.
    var url: URL? { get }
}
