import Foundation
import ObjectMapper

public struct Gift: Mappable {

    public var amount: Int?

    public init?(map: Map) {
        mapping(map: map)
    }

    mutating public func mapping(map: Map) {
        amount <- map["amount"]
    }

}
