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