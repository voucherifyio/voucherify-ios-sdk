import Foundation
import Alamofire

public class Redemption {
	
	private let httpClient: VoucherifyHttpClient
	
	public init(httpClient: VoucherifyHttpClient) {
		self.httpClient = httpClient
	}
	
	/**
	   Increments redemption counter and updates history of the voucher
	   - parameter code: Voucher's code which we want to redeem
	   - parameter completion: response callback function
	   */
	public func redeem(code: String,
					   redeemContext: VoucherRedemptionContext? = nil,
					   completion: @escaping (_ response: Result<VoucherRedemptionResult>) -> Void) {
		var params = httpClient.getBaseQueryParams()
		
		params[HttpQueryParamName.code] = code as AnyObject?
		
		httpClient.request(requestUrl: VoucherifyRouter.redeemVoucher(params, redeemContext) as URLRequestConvertible) { (response) in
			completion(self.httpClient.handleJsonResponse(response: response))
		}
	}
	
}
