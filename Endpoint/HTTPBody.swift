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
    func applyToMutableURLRequest(request: NSMutableURLRequest)
}

/// `NSData` is extended to conform to `BodyType`.
extension NSData: HTTPBody
{
    /**
     Applies the data to the specified URL request, setting the `HTTPBody` property.

     - parameter request: The URL request.
     */
    public func applyToMutableURLRequest(request: NSMutableURLRequest)
    {
        request.HTTPBody = self
    }
}

/// `NSInputStream` is extended to conform to `BodyType`.
extension NSInputStream: HTTPBody
{
    /**
     Applies the stream to the specified URL request, setting the `HTTPBodyStream` property.

     - parameter request: The URL request.
     */
    public func applyToMutableURLRequest(request: NSMutableURLRequest)
    {
        request.HTTPBodyStream = self
    }
}
