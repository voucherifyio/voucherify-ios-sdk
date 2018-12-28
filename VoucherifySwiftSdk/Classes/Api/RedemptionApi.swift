import Alamofire
import Foundation

public protocol RedemptionApi {
	
	/**
	Redeem increments redemption counter and updates history of the voucher

	- Parameters:
		- code: a voucher's which will be redeemed
		- redeemContext: redemption details
		- completion: a server response callback block
 	*/
	func redeem(code: String,
				redeemContext: VoucherRedemptionContext?,
				completion: @escaping (_ response: Result<VoucherRedemptionResult>) -> Void)
	
	/**
	Redeem a promotion tier

	- Parameters:
		- promotionTierId: a voucher's which will be redeemed
		- redeemContext: redemption details
		- completion: a server response callback block
 	*/
	func redeem(promotionTierId: String,
				redeemContext: PromotionRedemptionContext,
				completion: @escaping (_ response: Result<PromotionTierRedemptionResult>) -> Void)
}

extension RedemptionApi {
	
	/**
	Redeem increments redemption counter and updates history of the voucher

	- Parameters:
		- code: a voucher's which will be redeemed
		- completion: a server response callback block
 	*/
	public func redeem(code: String,
					   redeemContext: VoucherRedemptionContext? = nil,
					   completion: @escaping (_ response: Result<VoucherRedemptionResult>) -> Void) {
		
		return redeem(code: code, redeemContext: redeemContext, completion: completion)
	}
}
