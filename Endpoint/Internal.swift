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

extension URL
{
    internal func transformWithComponents(_ transform: (inout URLComponents) -> ()) -> URL?
    {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }

        transform(&components)

        return components.url
    }

    internal func buildRequest(method: Method, headerFields: [String:String]? = nil, body: HTTPBody? = nil)
        -> URLRequest
    {
        var request = URLRequest(url: self)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headerFields
        body?.apply(to: &request)

        return request
    }
}
