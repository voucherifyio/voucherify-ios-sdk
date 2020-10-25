import Foundation
import Alamofire

public class VoucherifyRedemption {
	
	private let httpClient: VoucherifyHttpClient
	
	public init(httpClient: VoucherifyHttpClient) {
		self.httpClient = httpClient
	}
}

extension VoucherifyRedemption: RedemptionApi {
	
	public func redeem(code: String,
					   redeemContext: VoucherRedemptionContext? = nil,
					   completion: @escaping (_ response: AFResult<VoucherRedemptionResult>) -> Void) {
		
		var params = httpClient.getBaseQueryParams()
		
		params[HttpQueryParamName.code] = code as AnyObject?
		
		httpClient.request(
			requestUrl: VoucherifyRouter.redeemVoucher(params, redeemContext) as URLRequestConvertible,
			completion: {
				[weak self] (response) in
				guard let strongSelf = self else {
					return
				}
				
				completion(strongSelf.httpClient.handleJsonResponse(response: response))
			})
	}
	
	public func redeem(promotionTierId: String,
					   redeemContext: PromotionRedemptionContext,
					   completion: @escaping (AFResult<PromotionTierRedemptionResult>) -> Void) {
		
		let params = httpClient.getBaseQueryParams()
		
		httpClient.request(
			requestUrl: VoucherifyRouter.redeemPromotion(params, promotionTierId, redeemContext) as URLRequestConvertible,
			completion: {
				[weak self] (response) in
				guard let strongSelf = self else {
					return
				}
				
				completion(strongSelf.httpClient.handleJsonResponse(response: response))
			})
	}
}