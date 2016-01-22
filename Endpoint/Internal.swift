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

extension NSURL
{
    internal func transformWithComponents(@noescape transform: NSURLComponents -> ()) -> NSURL?
    {
        return NSURLComponents(URL: self, resolvingAgainstBaseURL: true).flatMap({ components in
            transform(components)
            return components.URL
        })
    }

    internal func buildRequest(method method: String, headerFields: [String:String]? = nil) -> NSURLRequest
    {
        let request = NSMutableURLRequest(URL: self)
        request.HTTPMethod = method
        request.allHTTPHeaderFields = headerFields
        return request
    }
}
