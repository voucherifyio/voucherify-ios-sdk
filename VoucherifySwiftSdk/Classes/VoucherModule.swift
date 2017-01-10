import Foundation

public class VoucherModule {

    private let validation: Validation
    private let redeemption: Redeemption

    public init(validation: Validation, redeemption: Redeemption) {
        self.validation = validation
        self.redeemption = redeemption
    }

    public func validations() -> Validation {
        return validation
    }

    public func redeemptions() -> Redeemption {
        return redeemption
    }

}
