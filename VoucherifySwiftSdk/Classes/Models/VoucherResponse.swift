//
// Created by Marcin Polak on 08.06.2016.
//

import Foundation
import ObjectMapper

public struct VoucherResponse: Mappable {

    public var code: String?
    public var valid: Bool?
    public var discount: Discount?
    public var trackingId: String?
    public var gift: Gift?
    public var reason: String?

    public init?(_ map: Map) {
        mapping(map)
    }
    mutating public func mapping(map: Map) {
        code        <- map["code"]
        valid       <- map["valid"]
        discount    <- map["discount"]
        trackingId  <- map["tracking_id"]
        gift        <- map["gift"]
        reason      <- map["reason"]
    }

}