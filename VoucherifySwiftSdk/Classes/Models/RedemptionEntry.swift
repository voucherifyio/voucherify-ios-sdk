import Foundation
import ObjectMapper

/**
 * I hold a history information about voucher redemption
 */
public struct RedemptionEntry: Mappable {

    /// An identifier for entity
    public var id: String?

    /// When the voucher was redeemed
    public var date: NSDate?

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

    /// Metadata - whatever you
    public var metadata: Dictionary<String, AnyObject>?

    public init?(_ map: Map) {
        mapping(map)
    }

    mutating public func mapping(map: Map) {
        id          <- map["id"]
        date        <- (map["date"], ISO8601DateTransform())
        object      <- map["object"]
        customerId  <- map["customer_id"]
        trackingId  <- map["tracking_id"]
        redemption  <- map["redemption"]
        reason      <- map["reason"]
        metadata    <- map["metadata"]
    }
}