import Alamofire
import UIKit
import VoucherifySwiftSdk

class ViewController: UIViewController {
	
	var client: Client?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5",
			clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20",
			trackingId: "swift-demo-test")
		
		/*
		* List vouchers
		*/
//		client?.vouchers.list() { (response) in
//			debugPrint(response ?? "")
//		}
		
		/*
		* List vouchers
		*/
//		client?.vouchers.list(customer: "cust_123456") { (response) in
//			debugPrint(response ?? "")
//		}
		
		/*
		* Validate voucher by its code
		*/
//		client?.validations.validateVoucher(code: "test") { (response) in
//			debugPrint(response ?? "")
//		}
		
		/*
		* Validate voucher by passing its code and amount
		*/
//		client?.validations.validateVoucher(code: "test", amount: 10) { (response) in
//			debugPrint(response ?? "")
//		}
		
		/*
		* Validate a promotion
		*/

//		let orderItems: Array<OrderItem> = [
//			OrderItem(productId: "prod_s3C0nDpr0DuC7", skuId: "sku_N8icTtWKKTV952", quantity: 2, price: 99999)
//		]
//
//		var promotionValidationContext = PromotionValidationContext(
//			customer: Customer(id: "cust_52fQPHaVzj0h0TGSMFHGWUFH", sourceId: "test_customer_id_1"),
//			order: Order(amount: 3, items: orderItems),
//			metadata: ["test": "test"])
//
//		client?.validations.validatePromotion(validationContext: promotionValidationContext) { (response: Result) in
//			switch response {
//			case .success(let response):
//				debugPrint("OK")
//			case .failure(let error):
//				debugPrint("ERROR")
//			}
//
//			debugPrint(response)
//		}
		
		/*
		* Redeem a promotion tier by its id
		*/
//		let orderItems: Array<OrderItem> = [
//			OrderItem(productId: "prod_s3C0nDpr0DuC7", skuId: "sku_N8icTtWKKTV952", quantity: 2, price: 900000)
//		]
//
//		var redeemContext = PromotionRedemptionContext()
//		redeemContext.customer = Customer(id: "cust_52fQPHaVzj0h0TGSMFHGWUFH", sourceId: nil)
//		redeemContext.order = Order(amount: 2, items: orderItems)
//
//		client?.redemptions.redeem(
//			promotionTierId: "promo_Ws2wowdlnsmKHG2IWk1KxVGE",
//			redeemContext: redeemContext) { (response) in
//
//			debugPrint(response ?? "")
//		}
		
		/*
		* Redeem voucher by its code
		*/
//        client?.redemptions.redeem(code: "test") { (response) in
//            debugPrint(response ?? "")
//        }
		
		/*
		 * Redeem voucher by its code and customer under redeemContext
		 */
//        var redeemContext = VoucherRedemptionContext()
//        redeemContext.customer = Customer(id: "cust_VLrEd4woIyiUeXVVufr5xxho", sourceId: nil)
//
//        client?.redemptions.redeem(code: "test", redeemContext: redeemContext){ (response) in
//            debugPrint(response ?? "")
//        }
		
		/*
		* Validate voucher with validation rules concerning products or variants (SKUs)
		*/

//        let orderItems: Array<OrderItem> = [
//            OrderItem(productId: "prod_anJ03RZZq74z4v", skuId: "sku_F2S9beIUgWjX84", quantity: 1)
//        ]
//
//        var redeemContext = VoucherRedemptionContext()
//        redeemContext.customer = Customer(id: "cust_VLrEd4woIyiUeXVVufr5xxho", sourceId: nil)
//        redeemContext.order = Order(amount: 1, items: orderItems)
//
//        client?.redemptions.redeem(code: "test", redeemContext: redeemContext) {(response: Result) in
//            switch response {
//                case .success(let response):
//                    debugPrint("OK")
//                case .failure(let error):
//                    debugPrint("ERROR")
//            }
//            debugPrint(response)
//        }
	}
	
}
