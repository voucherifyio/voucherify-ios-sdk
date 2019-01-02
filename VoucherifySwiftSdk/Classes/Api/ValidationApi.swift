import Alamofire
import Foundation

public protocol ValidationApi {
	
	/**
	ValidateVoucher allows to validate a voucher with validation rules concerning products or variants (SKUs)

 	- Parameters:
		- code: a voucher's code which we want to validate
	 	- amount:  an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
	 	- orderItems: the validation rules concerning products or variants (SKUs)
	 	- completion: a server response callback block
 	*/
	func validateVoucher(code: String,
						 amount: Int?,
						 orderItems: [OrderItem],
						 completion: @escaping (_ response: Result<VoucherResponse>) -> Void)
	
	/**
	ValidateVoucher allows to validate a voucher based on its code and gift amount

	- Parameters:
		- code: a voucher's code which we want to validate
	 	- amount:  an amount that is intended to be withdrawn from the voucher. Order amount have to be expressed in cents, as an integer
	 	- completion: a server response callback block
 	*/
	func validateVoucher(code: String,
						 amount: Int?,
						 completion: @escaping (_ response: Result<VoucherResponse>) -> Void)
	
	/**
	ValidatePromotion allows to get valid promotions for a given customer and order

	- Parameters:
		- validationContext: a validation context which can contain information about customer and order
	 	- completion: a server response callback block
 	*/
	func validatePromotion(validationContext: PromotionValidationContext,
						   completion: @escaping (_ response: Result<PromotionValidationResponse>) -> Void)
}

public extension ValidationApi {
	
	/**
	ValidateVoucher allows to validate a voucher with validation rules concerning products or variants (SKUs)

 	- Parameters:
		- code: a voucher's code which we want to validate
	 	- orderItems: the validation rules concerning products or variants (SKUs)
	 	- completion: a server response callback block
 	*/
	func validateVoucher(code: String,
						 amount: Int? = nil,
						 orderItems: [OrderItem],
						 completion: @escaping (_ response: Result<VoucherResponse>) -> Void) {
		
		return validateVoucher(
			code: code,
			amount: amount,
			orderItems: orderItems,
			completion: completion)
	}
	
	/**
	ValidateVoucher allows to validate a voucher based on its code and gift amount

	- Parameters:
		- code: a voucher's code which we want to validate
		- completion: a server response callback block
 	*/
	func validateVoucher(code: String,
						 amount: Int? = nil,
						 completion: @escaping (_ response: Result<VoucherResponse>) -> Void) {
		
		return validateVoucher(
			code: code,
			amount: amount,
			completion: completion)
	}
	
}