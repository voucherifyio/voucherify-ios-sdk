import Foundation

let voucherifyServerEndpoint = "https://api.voucherify.io"
let voucherifyChannelName = "Swift-SDK"
let voucherifyDefaultOrigin = "http://voucherify-swift"

/// Configuration parameters for a client instance

public struct Configuration {
    /// Whether or not to use HTTPS connections, defaults to `true`
    public var secure = true

    /// The server to use for performing requests, defaults to `api.voucherify.io`
    public var server = voucherifyServerEndpoint

    /// The user agent to use for performing requests
    public var userAgentClient = "swift"

    /// Computed version of the user agent, including OS name and version
    public var userAgent: String {
        var osName = "iOS"
        let osVersion: AnyObject = ProcessInfo.processInfo.operatingSystemVersionString as AnyObject? ?? "Unknown" as AnyObject

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
    static let httpHeaderContentType = "Content-Type"
    static let httpHeaderClientId = "X-Client-Application-Id"
    static let httpHeaderClientToken = "X-Client-Token"
    static let httpHeaderOrigin = "origin"
    static let httpHeaderChannel = "X-Voucherify-Channel"
}

public struct HttpQueryParamName {
    static let code = "code"
    static let giftAmount = "amount"
    static let trackingId = "tracking_id"
    static let channel = "channel"
    static let customer = "customer"

    static let productId = "product_id"
    static let skuId = "sku_id"
    static let quantity = "quantity"
}
