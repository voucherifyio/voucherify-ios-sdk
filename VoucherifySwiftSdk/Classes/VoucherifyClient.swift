import Foundation
import Alamofire
import ObjectMapper

/**
 Voucherify client object for performing voucher request against the Voucherify API
*/

public class VoucherifyClient {

    /// Client's custom configuration
    private let configuration: Configuration

    private let httpClient: VoucherifyHttpClient

    internal let voucherModule: VoucherModule

    /**
     Initializes a new VoucherifyClient client instance
     - parameter configuration: Custom configuration of the client
     - returns: An initialized client instance
     */
    public init(clientId: String,
                clientToken: String,
                origin: String = "",
                trackingId: String = "swift-sdk",
                configuration: Configuration = Configuration()) {
        self.configuration = configuration

        let sessionConfiguration = URLSessionConfiguration.default
        var additionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

        additionalHeaders[HttpHeader.httpHeaderContentType] = "application/json"
        additionalHeaders[HttpHeader.httpHeaderClientId] = clientId
        additionalHeaders[HttpHeader.httpHeaderClientToken] = clientToken
        additionalHeaders[HttpHeader.httpHeaderOrigin] = origin.isEmpty ? voucherifyDefaultOrigin : origin
        additionalHeaders[HttpHeader.httpHeaderChannel] = voucherifyChannelName

        sessionConfiguration.httpAdditionalHeaders = additionalHeaders
        let manager = Alamofire.SessionManager(configuration: sessionConfiguration)

        httpClient = VoucherifyHttpClient(sessionManager: manager, configuration: configuration, trackingId: trackingId)

        voucherModule = VoucherModule(
                validation: Validation(httpClient: httpClient),
                redeemption: Redeemption(httpClient: httpClient)
        )
    }

}

//MARK: Voucher module

extension VoucherifyClient {

    public func vouchers() -> VoucherModule {
        return voucherModule
    }
}
