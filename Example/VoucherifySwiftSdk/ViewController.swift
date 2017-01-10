import UIKit
import VoucherifySwiftSdk

class ViewController: UIViewController {

    var client: VoucherifyClient?

    override func viewDidLoad() {
        super.viewDidLoad()

        client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5", clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20", trackingId:"swift-test-polakos")

        /*
        * Validate voucher by its code
        */
        client?.vouchers().validations().validateVoucher(code: "test") { (response) in
            debugPrint(response ?? "")
        }

        /*
        * Redeem voucher by its code
        */
//        client?.vouchers().redeemptions().redeemVoucher(code: "Testing7fjWdr") { (response) in
//            debugPrint(response ?? "")
//        }
        
//        var redeemContext = VoucherRedemptionContext()
//        redeemContext.customer = Customer(id: "cust_VLrEd4woIyiUeXVVufr5xxho", sourceId: nil)
        
//        client?.vouchers().redeemptions().redeemVoucher(code: "Testing7fjWdr", redeemContext: redeemContext){ (response) in
//            debugPrint(response ?? "")
//        }
        
//        client?.redeemVoucher(code: <#T##String#>, completion: <#T##(VoucherRedemptionResult?) -> Void#>)

        /*
        * Validate voucher with validation rules concerning products or variants (SKUs)
        */
//        client?.validateVoucher(code: "test", orderItems: [
//                OrderItem(productId: "prod_anJ03RZZq74z4v", skuId: "sku_F2S9beIUgWjX84", quantity: 1),
//                ]) { (response) in
//            debugPrint(response)
//        }
    }

}

