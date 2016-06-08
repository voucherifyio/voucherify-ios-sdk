//
// Created by Marcin Polak on 08.06.2016.
//

import Foundation

let VOUCHERIFY_SERVER_ENDPOINT = "https://api.voucherify.io"

let VOUCHERIFY_CHANNEL_NAME = "Swift-SDK"
let VOUCHERIFY_DEFAULT_ORIGIN = "http://voucherify-swift"

/// Configuration parameters for a client instance

public struct Configuration {
    /// Whether or not to use HTTPS connections, defaults to `true`
    public var secure = true

    /// The server to use for performing requests, defaults to `api.voucherify.io`
    public var server = VOUCHERIFY_SERVER_ENDPOINT

    /// The user agent to use for performing requests
    public var userAgentClient = "swift"

    /// Computed version of the user agent, including OS name and version
    public var userAgent: String {
        var osName = "iOS"
        let osVersion: AnyObject = NSProcessInfo.processInfo().operatingSystemVersionString ?? "Unknown"

#if os(OSX)
        osName = "OS X"
#elseif os(tvOS)
        osName = "tvOS"
#elseif os(watchOS)
        osName = "watchOS"
#endif

        return "\(userAgentClient) (\(osName) \(osVersion))"
    }

    /**
     Initialize a configuration with default values
     - returns: An initialized configuration instance
     */
    public init() {
    }

}

public struct HttpHeader {
    static let HTTP_HEADER_CONTENT_TYPE = "Content-Type"
    static let HTTP_HEADER_CLIENT_ID = "X-Client-Application-Id"
    static let HTTP_HEADER_CLIENT_TOKEN = "X-Client-Token"
    static let HTTP_HEADER_ORIGIN = "origin"
    static let HTTP_HEADER_VOUCHERIFY_CHANNEL = "X-Voucherify-Channel"
}

public struct HttpQueryParamName {
    static let CODE = "code"
    static let TRACKING_ID = "tracking_id"
    static let CHANNEL = "channel"
}
