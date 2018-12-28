import Foundation
import ObjectMapper

public struct PromotionValidationResponse: Mappable {
	
	public var valid: Bool?
	public var trackingId: String?
	public var promotions: [Promotion]?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		valid 		<- map["valid"]
		trackingId 	<- map["tracking_id"]
		promotions 	<- map["promotions"]
	}
}
