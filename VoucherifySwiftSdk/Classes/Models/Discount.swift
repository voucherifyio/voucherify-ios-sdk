//
// Created by Marcin Polak on 08.06.2016.
//

import Foundation
import ObjectMapper

public struct Discount: Mappable {

    public var type: DiscountType?
    public var amountOff: Int?
    public var percentOff: Double?
    public var unitOff: Double?
    public var unitType: String?

    public init?(_ map: Map) {
        mapping(map)
    }

    mutating public func mapping(map: Map) {
        type        <- map["type"]
        amountOff   <- map["amount_off"]
        percentOff  <- map["percent_off"]
        unitOff     <- map["unit_off"]
        unitType    <- map["unit_type"]
    }

}