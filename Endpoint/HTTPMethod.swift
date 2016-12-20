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
public enum HTTPMethod: String
{
    /// `OPTIONS`.
    case options = "OPTIONS"

    /// `GET`.
    case get = "GET"

    /// `HEAD`.
    case head = "HEAD"

    /// `POST`.
    case post = "POST"

    /// `PUT`.
    case put = "PUT"

    /// `PATCH`.
    case patch = "PATCH"

    /// `DELETE`.
    case delete = "DELETE"

    /// `TRACE`.
    case trace = "TRACE"

    /// `CONNECT`.
    case connect = "CONNECT"
}
