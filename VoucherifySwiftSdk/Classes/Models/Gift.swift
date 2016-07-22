//
// Created by Marcin Polak on 22.07.2016.
//

import Foundation
import ObjectMapper

public struct Gift: Mappable {

    public var amount: Int?

    public init?(_ map: Map) {
        mapping(map)
    }

    mutating public func mapping(map: Map) {
        amount <- map["amount"]
    }

}