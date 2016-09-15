import Foundation
import ObjectMapper

/**
 * Represents voucher redemption
 */
public struct VoucherRedemption: Mappable {

    /// Value of voucher's quantity
    public var quantity: Int?

    /// Value of redeemed voucher's quantity
    public var redeemedQuantity: Int?

    public var redemptionEntries: Array<RedemptionEntry>?

    public init?(_ map: Map) {
        mapping(map)
    }

    mutating public func mapping(map: Map) {
        quantity          <- map["quantity"]
        redeemedQuantity  <- map["redeemed_quantity"]
        redemptionEntries <- map["redemption_entries"]
    }
}