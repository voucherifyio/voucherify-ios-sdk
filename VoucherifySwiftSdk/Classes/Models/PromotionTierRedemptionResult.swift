import Foundation
import ObjectMapper

public struct PromotionTierRedemptionResult: Mappable {
	
	public var id: String?
	public var object: String?
	public var date: Date?
	public var customerId: String?
	public var trackingId: String?
	public var order: Order?
	public var result: String?
	public var promotionTier: PromotionTier?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		id 				<- map["id"]
		object 			<- map["object"]
		date 			<- (map["date"], ISO8601DateTransform())
		customerId 		<- map["customer_id"]
		trackingId 		<- map["tracking_id"]
		order 			<- map["order"]
		result 			<- map["result"]
		promotionTier 	<- map["promotion_tier"]
	}
}
