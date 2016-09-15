import Foundation
import Alamofire
import ObjectMapper

/**
 Voucherify client object for performing voucher request against the Voucherify API
*/
public class VoucherifyClient {

    /// Client's custom configuration
    private let configuration: Configuration

    /// Alamofire's manager to perform HTTP calls
    private let manager: Alamofire.Manager

    /// Query custom tracking param
    private let trackingId: String

    /**
     Initializes a new VoucherifyClient client instance
     - parameter configuration: Custom configuration of the client
     - returns: An initialized client instance
     */
    public init(clientId: String, clientToken: String, origin: String = "", trackingId: String = "swift-sdk", configuration: Configuration = Configuration()) {
        self.trackingId = trackingId
        self.configuration = configuration

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration();
        var additionalHeaders = Alamofire.Manager.defaultHTTPHeaders ?? [:];

        additionalHeaders[HttpHeader.HTTP_HEADER_CONTENT_TYPE] = "application/json"
        additionalHeaders[HttpHeader.HTTP_HEADER_CLIENT_ID] = clientId
        additionalHeaders[HttpHeader.HTTP_HEADER_CLIENT_TOKEN] = clientToken
        additionalHeaders[HttpHeader.HTTP_HEADER_ORIGIN] = origin.isEmpty ? VOUCHERIFY_DEFAULT_ORIGIN : origin
        additionalHeaders[HttpHeader.HTTP_HEADER_VOUCHERIFY_CHANNEL] = VOUCHERIFY_CHANNEL_NAME

        sessionConfiguration.HTTPAdditionalHeaders = additionalHeaders;
        manager = Alamofire.Manager(configuration: sessionConfiguration);

    }

    private func request(requestUrl: URLRequestConvertible, completion: (Response<AnyObject, NSError>) -> Void) {
        manager.request(requestUrl).responseJSON(queue: dispatch_get_main_queue()) {
            responseData in

            debugPrint("[Voucherify] Response from \(requestUrl.URLRequest.URL): \n \(responseData)")
            completion(responseData)
        }
    }

    private func getBaseQueryParams() -> [String: AnyObject] {
        var params = [String: AnyObject]()

        params[HttpQueryParamName.TRACKING_ID] = self.trackingId
        params[HttpQueryParamName.CHANNEL] = configuration.userAgentClient

        return params
    }

    private func handleJsonResponse<T: Mappable>(response: Response<AnyObject, NSError>) -> T? {
        let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(response.data! as NSData, options: [])

        var data : T?;

        if let r: AnyObject = json {
            data = Mapper<T>().map(r)!;
        }

        return data

    }

}

//MARK: Voucher validation

extension VoucherifyClient {

    /**
     Method which allows to validate a voucher based on its code and gift amount
     - parameter code: Voucher's code which we want to validate
     - parameter amount: validating a gift voucher requires to pass an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
     - parameter completion: response callback function
     */
    public func validateVoucher(code: String, amount: Int? = nil, completion: (response: VoucherResponse?) -> Void) {
        var params = getBaseQueryParams()

        params[HttpQueryParamName.CODE] = code
        params[HttpQueryParamName.GIFT_AMOUNT] = amount

        request(VoucherifyRouter.VALIDATE_VOUCHER(params)) { (response) in
            completion(response: self.handleJsonResponse(response))
        }
    }

    /**
    Method which allows to validate a voucher with validation rules concerning products or variants (SKUs)
    - parameter code: Voucher's code which we want to validate
    - parameter amount: an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
    - parameter orderItems: validation rules concerning products or variants (SKUs)
    - parameter completion: response callback function
    */
    public func validateVoucher(code: String, amount: Int? = nil, orderItems: [OrderItem], completion: (response: VoucherResponse?) -> Void) {
        var params = getBaseQueryParams()

        params[HttpQueryParamName.CODE] = code
        params[HttpQueryParamName.GIFT_AMOUNT] = amount

        for (index, orderItem) in orderItems.enumerate() {
            params["item[\(index)][\(HttpQueryParamName.PRODUCT_ID)]"] = orderItem.productId
            params["item[\(index)][\(HttpQueryParamName.SKU_ID)]"] = orderItem.skuId
            params["item[\(index)][\(HttpQueryParamName.QUANTITY)]"] = orderItem.quantity
        }

        request(VoucherifyRouter.VALIDATE_VOUCHER(params)) { (response) in
            completion(response: self.handleJsonResponse(response))
        }
    }

    /**
    Increments redemption counter and updates history of the voucher
    - parameter code: Voucher's code which we want to redeem
    - parameter completion: response callback function
    */
    public func redeemVoucher(code: String, completion: (response: VoucherRedemptionResult?) -> Void) {
        var params = getBaseQueryParams()

        params[HttpQueryParamName.CODE] = code

        request(VoucherifyRouter.REDEEM_VOUCHER(params)) { (response) in
            completion(response: self.handleJsonResponse(response))
        }
    }
}