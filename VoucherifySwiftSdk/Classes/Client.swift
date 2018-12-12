import Foundation

public protocol Client {

	var validations: Validation { get }
	
	var redemptions: Redemption { get }

}