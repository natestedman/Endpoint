# Endpoint
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/natestedman/Endpoint.svg?branch=master)](https://travis-ci.org/natestedman/Endpoint)
[![License](https://img.shields.io/badge/license-Creative%20Commons%20Zero%20v1.0%20Universal-blue.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

A Swift µframework for web API endpoint types.

Endpoint is specifically concerned with building URL requests - while it might make sense for the same type to be aware of how to handle response data, that is out-of-scope for this framework.

## Usage
### Endpoint Protocols
There are two endpoint protocol types: `EndpointType`, and `BaseURLEndpointType`.

#### Endpoints
Endpoints simply provide:

    var endpoint: NSURLRequest? { get }

How the URL request is actually built is left up to the implementation, but Endpoint includes *provider* types, which help create URL requests.

#### Base URL Endpoints
Base URL endpoints are similar, but receive a base URL as an input parameter:

    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest?

Types implementing this protocol can be used to switch between different backend servers.

### Provider Protocols
The provider protocols can be used on top of `EndpointType` and `BaseURLEndpointType` to make URL request generation declarative. Implementing these protocols in a type conforming to one of the endpoint types activates a default implementation of `request` or `requestWithBaseURL(:)`, so that the derived type does not have to include one.

In this example, a `GET` endpoint is created for the `users` API, sorting users by their creation date:

    struct UsersEndpoint:
        BaseURLEndpointType,
        MethodProviderType,
        QueryItemsProviderType,
        RelativeURLStringProviderType
    {
        let method = "GET"
        let queryItems = [NSURLQueryItem(name: "sort", value: "created")]
        let relativeURLString = "users"
    }

When given the base URL `http://example.api/`, this endpoint will yield a `GET` request to `http://example.api/users?sort=created`.

#### HTTP Methods
To create an HTTP request, a method is required. This is implemented by `MethodProviderType`:

    var method: String { get }

To take advantage of the other provider types, your type *must* provide an HTTP method.

#### Query Items
Provides an array of query items to append to the request's URL:

    var queryItems: [NSURLQueryItem] { get }

This can be used with:

- `EndpointType`, if the type also conforms to `MethodProviderType` and `URLProviderType`.
- `BaseURLEndpointType`, if the type also conforms to `MethodProviderType`.

#### Relative URL Strings
Generally used to provide a path, `RelativeURLStringProviderType` will send the result of:

    var relativeURLString: String { get }

To `NSURL(string:relativeToURL:)`, in order to generate the final URL for a `BaseURLEndpointType`. This protocol cannot be used with `EndpointType`.

#### URLs
To provide a URL, `URLProviderType` can be used:

    var URL: NSURL? { get }

This can only be used in conjunction with `EndpointType`, since `BaseURLEndpointType` implementations must be able to receive a base URL.

## Documentation
If necessary, install `jazzy`:

    gem install jazzy
   
Then run:

    make docs

To generate HTML documentation in the `Documentation` subdirectory.

## Installation

Add:

    github "natestedman/Endpoint"

To your `Cartfile`.
