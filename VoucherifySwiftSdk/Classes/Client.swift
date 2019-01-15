import Foundation

public protocol Client {

	var validations: ValidationApi { get }
	
	var redemptions: RedemptionApi { get }
	
	var vouchers: VoucherApi { get }

}
