import Alamofire
import Foundation

public protocol VoucherApi {
	
	func list(customer: String?,
			  completion: @escaping (_ response: Result<VoucherList>) -> Void)
}

public extension VoucherApi {
	
	func list(customer: String? = nil,
			  completion: @escaping (Result<VoucherList>) -> Void) {
		
		return list(customer: customer, completion: completion)
	}
}
