// Endpoint
// Written in 2016 by Nate Stedman <nate@natestedman.com>
//
// To the extent possible under law, the author(s) have dedicated all copyright and
// related and neighboring rights to this software to the public domain worldwide.
// This software is distributed without any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with
// this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

import Endpoint
import XCTest

class EndpointProviderTypesTests: XCTestCase
{
    func testMethodProviderAndURLProvider()
    {
        struct Provider: EndpointType, MethodProviderType, URLProviderType
        {
            let method = "POST"
            let URL = NSURL(string: "http://test.com/")
        }

        let mutable = NSMutableURLRequest(URL: NSURL(string: "http://test.com/")!)
        mutable.HTTPMethod = "POST"

        XCTAssertEqual(Provider().request, mutable)
    }
}
