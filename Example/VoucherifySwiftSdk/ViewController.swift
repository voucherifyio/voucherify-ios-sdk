import Alamofire
import UIKit
import VoucherifySwiftSdk

class ViewController: UIViewController {

    var client: VoucherifyClient?

    override func viewDidLoad() {
        super.viewDidLoad()

        client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5",
                                  clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20",
                                  trackingId:"swift-demo-test")

        /*
        * Validate voucher by its code
        */
//        client?.validations.validateVoucher(code: "test") { (response) in
//            debugPrint(response ?? "")
//        }

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
