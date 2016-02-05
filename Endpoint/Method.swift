// Endpoint
// Written in 2016 by Nate Stedman <nate@natestedman.com>
//
// To the extent possible under law, the author(s) have dedicated all copyright and
// related and neighboring rights to this software to the public domain worldwide.
// This software is distributed without any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with
// this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

/// Enumerates the HTTP methods.
public enum Method: String
{
    /// `OPTIONS`.
    case Options = "OPTIONS"

    /// `GET`.
    case Get = "GET"

    /// `HEAD`.
    case Head = "HEAD"

    /// `POST`.
    case Post = "POST"

    /// `PUT`.
    case Put = "PUT"

    /// `PATCH`.
    case Patch = "PATCH"

    /// `DELETE`.
    case Delete = "DELETE"

    /// `TRACE`.
    case Trace = "TRACE"

    /// `CONNECT`.
    case Connect = "CONNECT"
}
