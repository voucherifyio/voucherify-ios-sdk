import Foundation
import ObjectMapper

public struct VoucherPublish: Mappable {

    public var count: Int?
    public var entries: Array<PublishEntry>?

    public init?(map: Map) {
        mapping(map: map)
    }

    mutating public func mapping(map: Map) {
        count   <- map["count"]
        entries <- map["entries"]
    }

}
