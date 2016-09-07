//
// Created by Marcin Polak on 07.09.2016.
//

import Foundation

protocol ApiClient {
    /**
    Method which allows to validate a voucher based on its code and gift amount
        - parameter code: Voucher's code which we want to validate
        - parameter completion: response callback function
    */
    public func validateVoucher(code: String, amount: Int? = nil, completion: (response:VoucherResponse?) -> Void)

}
