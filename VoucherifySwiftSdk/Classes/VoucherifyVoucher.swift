import Alamofire
import Foundation

public class VoucherifyVoucher {
	
	private let httpClient: VoucherifyHttpClient
	
	public init(httpClient: VoucherifyHttpClient) {
		self.httpClient = httpClient
	}
}

extension VoucherifyVoucher: VoucherApi {
	
	public func list(customer: String?,
					 completion: @escaping (AFResult<VoucherList>) -> Void) {
		
		var params = httpClient.getBaseQueryParams()
		
		params[HttpQueryParamName.customer] = customer as AnyObject?
		
		httpClient.request(
			requestUrl: VoucherifyRouter.listVouchers(params) as URLRequestConvertible,
			completion: {
				[weak self] (response) in
				guard let strongSelf = self else {
					return
				}
				
				completion(strongSelf.httpClient.handleJsonResponse(response: response))
			})
	}
}
