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

extension BaseURLEndpointType where Self: MethodProviderType
{
    /**
     A default implementation of `BaseURLEndpointType`'s requirement.

     - parameter baseURL: The base URL.
     */
    public func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?
    {
        var URL: NSURL? = baseURL

        if let provider = self as? RelativeURLStringProviderType
        {
            URL = NSURL(string: provider.relativeURLString, relativeToURL: baseURL)
        }

        if let provider = self as? QueryItemsProviderType
        {
            URL = URL?.transformWithComponents({ components in
                components.queryItems = provider.queryItems
            })
        }

        return URL?.buildRequest(
            method: method,
            headerFields: (self as? HeaderFieldsProviderType)?.headerFields,
            body: (self as? BodyProviderType)?.body
        )
    }
}
