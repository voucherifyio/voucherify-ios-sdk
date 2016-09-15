import Foundation
import ObjectMapper

public struct VoucherPublish: Mappable {

    public var count: Int?
    public var entries: Array<PublishEntry>?

    public init?(_ map: Map) {
        mapping(map)
    }

    mutating public func mapping(map: Map) {
        count   <- map["count"]
        entries <- map["entries"]
    }

}