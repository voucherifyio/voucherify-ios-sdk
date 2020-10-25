import Alamofire
import Foundation

public protocol PromotionApi {
	
	func list(isAvailable: Bool,
			  limit: Int,
			  page: Int,
			  completion: @escaping (AFResult<PromotionTierPage>) -> Void)
}

public extension PromotionApi {
	
	func list(isAvailable: Bool = true,
			  limit: Int = 100,
			  page: Int = 1,
			  completion: @escaping (AFResult<PromotionTierPage>) -> Void) {
		
		return list(
			isAvailable: isAvailable,
			limit: limit,
			page: page,
			completion: completion)
	}
}
