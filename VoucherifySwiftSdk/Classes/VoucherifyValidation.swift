import Foundation
import Alamofire

public class VoucherifyValidation {
	
	private let httpClient: VoucherifyHttpClient
	
	public init(httpClient: VoucherifyHttpClient) {
		self.httpClient = httpClient
	}
}

extension VoucherifyValidation: ValidationApi {
	
	public func validateVoucher(code: String,
								amount: Int? = nil,
								completion: @escaping (_ response: AFResult<VoucherResponse>) -> Void) {
		
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
	
	public func validateVoucher(code: String,
								amount: Int? = nil,
								orderItems: [OrderItem],
								completion: @escaping (_ response: AFResult<VoucherResponse>) -> Void) {
		
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
	
	public func validatePromotion(validationContext: PromotionValidationContext,
								  completion: @escaping (AFResult<PromotionValidationResponse>) -> Void) {
		
		let params = httpClient.getBaseQueryParams()
		
		httpClient.request(
			requestUrl: VoucherifyRouter.validatePromotions(params, validationContext) as URLRequestConvertible,
			completion: {
				[weak self] (response) in
				guard let strongSelf = self else {
					return
				}
				
				completion(strongSelf.httpClient.handleJsonResponse(response: response))
			})
	}
}