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

/// A protocol for providing HTTP body data to requests.
public protocol HTTPBody
{
    /**
     Applies the receiver to the specified URL request.

     - parameter request: The URL request.
     */
    func apply(to URLRequest: inout URLRequest)
}

/// `Data` is extended to conform to `BodyType`.
extension Data: HTTPBody
{
    /**
     Applies the data to the specified URL request, setting the `HTTPBody` property.

     - parameter request: The URL request.
     */
    public func apply(to request: inout URLRequest)
    {
        request.httpBody = self
    }
}

/// `InputStream` is extended to conform to `BodyType`.
extension InputStream: HTTPBody
{
    /**
     Applies the stream to the specified URL request, setting the `HTTPBodyStream` property.

     - parameter request: The URL request.
     */
    public func apply(to request: inout URLRequest)
    {
        request.httpBodyStream = self
    }
}
