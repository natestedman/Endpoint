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

extension Endpoint where Self: MethodProvider, Self: URLProvider
{
    /// A default implementation.
    public var request: URLRequest?
    {
        var URL = self.URL

        if let provider = self as? QueryItemsProvider
        {
            URL = URL?.transformWithComponents({ components in
                components.queryItems = provider.queryItems
            })
        }

        return URL?.buildRequest(
            method: method,
            headerFields: (self as? HeaderFieldsProvider)?.headerFields,
            body: (self as? BodyProvider)?.body
        ) as URLRequest?
    }
}
