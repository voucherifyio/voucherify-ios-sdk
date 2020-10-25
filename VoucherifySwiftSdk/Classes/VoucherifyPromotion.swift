import Alamofire
import Foundation

public class VoucherifyPromotion {
	
	private let httpClient: VoucherifyHttpClient
	
	public init(httpClient: VoucherifyHttpClient) {
		self.httpClient = httpClient
	}
}

extension VoucherifyPromotion: PromotionApi {
	
	public func list(isAvailable: Bool,
					 limit: Int,
					 page: Int,
					 completion: @escaping (Result<PromotionTierPage, Error>) -> Void) {
		
		var params: [String: Any] = [:]
		
        // Alamofire converts bool values to 1/0 instead true/false
		params[HttpQueryParamName.isAvailable] = "\(isAvailable)"
		params[HttpQueryParamName.page] = page
		params[HttpQueryParamName.limit] = limit
		
		httpClient.request(
			requestUrl: VoucherifyRouter.listPromotionsTiers(params) as URLRequestConvertible,
			completion: {
				[weak self] (response) in
				guard let strongSelf = self else {
					return
				}
				
				completion(strongSelf.httpClient.handleJsonResponse(response: response))
			})
	}
}
