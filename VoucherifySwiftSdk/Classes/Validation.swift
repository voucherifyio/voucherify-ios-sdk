import Foundation
import Alamofire

public class Validation {

    private let httpClient: VoucherifyHttpClient

    public init(httpClient: VoucherifyHttpClient) {
        self.httpClient = httpClient
    }

    /**
    Method which allows to validate a voucher based on its code and gift amount
    - parameter code: Voucher's code which we want to validate
    - parameter amount: validating a gift voucher requires to pass an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
    - parameter completion: response callback function
    */
    public func validateVoucher(code: String, amount: Int? = nil, completion: @escaping (_ response: VoucherResponse?) -> Void) {
        var params = httpClient.getBaseQueryParams()

        params[HttpQueryParamName.code] = code as AnyObject?
        params[HttpQueryParamName.giftAmount] = amount as AnyObject?

        httpClient.request(requestUrl: VoucherifyRouter.validateVoucher(params) as! URLRequestConvertible) { (response) in
            completion(self.httpClient.handleJsonResponse(response: response))
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
        var params = httpClient.getBaseQueryParams()

        params[HttpQueryParamName.code] = code as AnyObject?
        params[HttpQueryParamName.giftAmount] = amount as AnyObject?

        for (index, orderItem) in orderItems.enumerated() {
            params["item[\(index)][\(HttpQueryParamName.productId)]"] = orderItem.productId as AnyObject?
            params["item[\(index)][\(HttpQueryParamName.skuId)]"] = orderItem.skuId as AnyObject?
            params["item[\(index)][\(HttpQueryParamName.quantity)]"] = orderItem.quantity as AnyObject?
        }

        httpClient.request(requestUrl: VoucherifyRouter.validateVoucher(params) as! URLRequestConvertible) { (response) in
            completion(self.httpClient.handleJsonResponse(response: response))
        }
    }

}
