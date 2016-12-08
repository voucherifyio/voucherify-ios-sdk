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
    private let manager: Alamofire.SessionManager

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

        let sessionConfiguration = URLSessionConfiguration.default
        var additionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders ?? [:]

        additionalHeaders[HttpHeader.HTTP_HEADER_CONTENT_TYPE] = "application/json"
        additionalHeaders[HttpHeader.HTTP_HEADER_CLIENT_ID] = clientId
        additionalHeaders[HttpHeader.HTTP_HEADER_CLIENT_TOKEN] = clientToken
        additionalHeaders[HttpHeader.HTTP_HEADER_ORIGIN] = origin.isEmpty ? VOUCHERIFY_DEFAULT_ORIGIN : origin
        additionalHeaders[HttpHeader.HTTP_HEADER_VOUCHERIFY_CHANNEL] = VOUCHERIFY_CHANNEL_NAME

        sessionConfiguration.httpAdditionalHeaders = additionalHeaders;
        manager = Alamofire.SessionManager(configuration: sessionConfiguration);

    }

    internal func request(requestUrl: URLRequestConvertible, completion: @escaping (DataResponse<Any>) -> Void) {
        manager.request(requestUrl).responseJSON { response in
            print("Response JSON: \(response.result.value)")
//            debugPrint("[Voucherify] Response from \(try requestUrl.asURLRequest().url): \n \(response)")
            completion(response)
        }
    }

    internal func getBaseQueryParams() -> [String: AnyObject] {
        var params = [String: AnyObject]()

        params[HttpQueryParamName.TRACKING_ID] = self.trackingId as AnyObject?
        params[HttpQueryParamName.CHANNEL] = configuration.userAgentClient as AnyObject?

        return params
    }

    internal func handleJsonResponse<T: Mappable>(response: DataResponse<Any>) -> T? {
        let json: AnyObject? = try! JSONSerialization.jsonObject(with: (response.data! as NSData) as Data, options: []) as AnyObject?

        var data : T?;

        if let r: AnyObject = json {
            data = Mapper<T>().map(JSONObject: r)!;
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
    public func validateVoucher(code: String, amount: Int? = nil, completion: @escaping (_ response: VoucherResponse?) -> Void) {
        var params = getBaseQueryParams()

        params[HttpQueryParamName.CODE] = code as AnyObject?
        params[HttpQueryParamName.GIFT_AMOUNT] = amount as AnyObject?

        request(requestUrl: VoucherifyRouter.VALIDATE_VOUCHER(params) as! URLRequestConvertible) { (response) in
            completion(self.handleJsonResponse(response: response))
        }
    }

    /**
    Method which allows to validate a voucher with validation rules concerning products or variants (SKUs)
    - parameter code: Voucher's code which we want to validate
    - parameter amount: an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
    - parameter orderItems: validation rules concerning products or variants (SKUs)
    - parameter completion: response callback function
    */
    public func validateVoucher(code: String, amount: Int? = nil, orderItems: [OrderItem], completion: @escaping (_ response: VoucherResponse?) -> Void) {
        var params = getBaseQueryParams()

        params[HttpQueryParamName.CODE] = code as AnyObject?
        params[HttpQueryParamName.GIFT_AMOUNT] = amount as AnyObject?

        for (index, orderItem) in orderItems.enumerated() {
            params["item[\(index)][\(HttpQueryParamName.PRODUCT_ID)]"] = orderItem.productId as AnyObject?
            params["item[\(index)][\(HttpQueryParamName.SKU_ID)]"] = orderItem.skuId as AnyObject?
            params["item[\(index)][\(HttpQueryParamName.QUANTITY)]"] = orderItem.quantity as AnyObject?
        }

        request(requestUrl: VoucherifyRouter.VALIDATE_VOUCHER(params) as! URLRequestConvertible) { (response) in
            completion(self.handleJsonResponse(response: response))
        }
    }

    /**
    Increments redemption counter and updates history of the voucher
    - parameter code: Voucher's code which we want to redeem
    - parameter completion: response callback function
    */
    public func redeemVoucher(code: String, completion: @escaping (_ response: VoucherRedemptionResult?) -> Void) {
        var params = getBaseQueryParams()

        params[HttpQueryParamName.CODE] = code as AnyObject?

        request(requestUrl: VoucherifyRouter.REDEEM_VOUCHER(params) as! URLRequestConvertible) { (response) in
            completion(self.handleJsonResponse(response: response))
        }
    }
}
