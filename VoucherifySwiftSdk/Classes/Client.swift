import Foundation

public protocol Client {

	var validations: ValidationApi { get }
	
	var redemptions: RedemptionApi { get }

}