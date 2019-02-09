import Foundation
import ObjectMapper

public struct PromotionTierPage: Mappable {
	
	public var dataRef: String?
	public var object: String?
	public var hasMore: Bool = false
	public var tiers: [PromotionTier] = []
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		tiers 	<- map["tiers"]
		hasMore <- map["has_more"]
		dataRef <- map["data_ref"]
		object 	<- map["object"]
	}
}
