import Foundation
import Alamofire

public class Validation {
	
	private let httpClient: VoucherifyHttpClient
	
	public init(httpClient: VoucherifyHttpClient) {
		self.httpClient = httpClient
	}
	
	/**
	ValidateVoucher allows to validate a voucher based on its code and gift amount

	- Parameters:
		- code: a voucher's code which we want to validate
	 	- amount:  an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
	 	- completion: a server response callback block
 	*/
	public func validateVoucher(code: String,
								amount: Int? = nil,
								completion: @escaping (_ response: Result<VoucherResponse>) -> Void) {
		var params = httpClient.getBaseQueryParams()
		
		params[HttpQueryParamName.code] = code as AnyObject?
		params[HttpQueryParamName.giftAmount] = amount as AnyObject?
		
		httpClient.request(
			requestUrl: VoucherifyRouter.validateVoucher(params) as URLRequestConvertible,
			completion: {
				[weak self] (response) in
				guard let strongSelf = self else {
					return
				}
				
				completion(strongSelf.httpClient.handleJsonResponse(response: response))
			})
	}
	
	/**
	ValidateVoucher allows to validate a voucher with validation rules concerning products or variants (SKUs)

 	- Parameters:
		- code: a voucher's code which we want to validate
	 	- amount:  an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
	 	- orderItems: the validation rules concerning products or variants (SKUs)
	 	- completion: a server response callback block
 	*/
	public func validateVoucher(code: String,
								amount: Int? = nil,
								orderItems: [OrderItem],
								completion: @escaping (_ response: Result<VoucherResponse>) -> Void) {
		var params = httpClient.getBaseQueryParams()
		
		params[HttpQueryParamName.code] = code as AnyObject?
		params[HttpQueryParamName.giftAmount] = amount as AnyObject?
		
		for (index, orderItem) in orderItems.enumerated() {
			params["item[\(index)][\(HttpQueryParamName.productId)]"] = orderItem.productId as AnyObject?
			params["item[\(index)][\(HttpQueryParamName.skuId)]"] = orderItem.skuId as AnyObject?
			params["item[\(index)][\(HttpQueryParamName.quantity)]"] = orderItem.quantity as AnyObject?
		}
		
		httpClient.request(
			requestUrl: VoucherifyRouter.validateVoucher(params) as URLRequestConvertible,
			completion: {
				[weak self] (response) in
				guard let strongSelf = self else {
					return
				}
				
				completion(strongSelf.httpClient.handleJsonResponse(response: response))
			})
	}
}
