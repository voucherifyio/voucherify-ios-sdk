import Foundation
import ObjectMapper

public struct Action: Mappable {
	
	public var discount: Discount?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		discount <- map["discount"]
	}
}
