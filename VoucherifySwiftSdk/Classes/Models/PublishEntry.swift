import Foundation
import ObjectMapper

public struct PublishEntry: Mappable {

    public var customer: String?
    public var channel: String?

    public var publishedAt: NSDate?

    public init?(_ map: Map) {
        mapping(map)
    }

    mutating public func mapping(map: Map) {
        customer    <- map["customer"]
        channel     <- map["channel"]
        publishedAt <- (map["published_at"], ISO8601DateTransform())
    }

}