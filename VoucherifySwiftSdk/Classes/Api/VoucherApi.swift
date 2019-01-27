import Alamofire
import Foundation

public protocol VoucherApi {
	
	/**
	List allows to fetch all vouchers or filter them by passing customer parameter

	- Parameters:
		- customer: an optional id of the customer
 		- completion: a server response callback block
	*/
	func list(customer: String?,
			  completion: @escaping (_ response: Result<VoucherList>) -> Void)
}

public extension VoucherApi {
	
	/**
	List allows to fetch all vouchers or filter them by passing customer parameter

	- Parameters:
		- customer: an optional id of the customer
		- completion: a server response callback block
	*/
	func list(customer: String? = nil,
			  completion: @escaping (Result<VoucherList>) -> Void) {
		
		return list(customer: customer, completion: completion)
	}
}
