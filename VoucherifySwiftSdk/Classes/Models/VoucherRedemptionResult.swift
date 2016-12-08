import Foundation
import ObjectMapper

public struct VoucherRedemptionResult: Mappable {
    /// An identifier for entity
    public var id: String?

    /// When the voucher was redeemed
    public var date: Date?

    /// Type of the operation (redemption or redemption_rollback)
    public var object: String?

    /// Id of a customer who made this redemption
    public var customerId: String?

    /// Voucher's consumer tracking id
    public var trackingId: String?

    /// Original redemption id (present if this entry is a rollback).
    public var redemption: String?

    /// Reason of the rollback.
    public var reason: String?

    /// Full voucher data
    public var voucher: Voucher?

    /// Metadata - whatever you
    public var metadata: Dictionary<String, AnyObject>?

    public init?(map: Map) {
        mapping(map: map)
    }

    mutating public func mapping(map: Map) {
        id          <- map["id"]
        date        <- (map["date"], DateTransform())
        object      <- map["object"]
        customerId  <- map["customer_id"]
        trackingId  <- map["tracking_id"]
        redemption  <- map["redemption"]
        reason      <- map["reason"]
        voucher     <- map["voucher"]
        metadata    <- map["metadata"]
    }
}
