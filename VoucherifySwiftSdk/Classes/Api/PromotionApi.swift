import Foundation

public protocol PromotionApi {
	
	func list(isAvailable: Bool,
			  limit: Int,
			  page: Int,
			  completion: @escaping (Result<PromotionTierPage, Error>) -> Void)
}

public extension PromotionApi {
	
	func list(isAvailable: Bool = true,
			  limit: Int = 100,
			  page: Int = 1,
			  completion: @escaping (Result<PromotionTierPage, Error>) -> Void) {
		
		return list(
			isAvailable: isAvailable,
			limit: limit,
			page: page,
			completion: completion)
	}
}
