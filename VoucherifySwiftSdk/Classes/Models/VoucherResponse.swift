import Foundation
import ObjectMapper

public struct VoucherResponse: Mappable {

    public var code: String?
    public var campaign: String?
    public var campaignId: String?
    public var valid: Bool?
    public var discount: Discount?
    public var trackingId: String?
    public var gift: Gift?
    public var reason: String?

    public init?(map: Map) {
        mapping(map: map)
    }
    mutating public func mapping(map: Map) {
        code        <- map["code"]
        campaign    <- map["campaign"]
        campaignId  <- map["campaign_id"]
        valid       <- map["valid"]
        discount    <- map["discount"]
        trackingId  <- map["tracking_id"]
        gift        <- map["gift"]
        reason      <- map["reason"]
    }

}
