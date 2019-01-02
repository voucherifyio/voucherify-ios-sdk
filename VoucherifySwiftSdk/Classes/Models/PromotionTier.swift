import Foundation
import ObjectMapper

public struct PromotionTier: Mappable {
	
	public var id: String?
	public var object: String?
	public var name: String?
	public var banner: String?
	public var campaign: Campaign?
	public var condition: Condition?
	public var action: Action?
	public var metadata: Dictionary<String, Any>?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		id 			<- map["id"]
		object 		<- map["object"]
		name 		<- map["name"]
		banner 		<- map["banner"]
		condition 	<- map["condition"]
		campaign 	<- map["campaign"]
		action 		<- map["action"]
		metadata 	<- map["metadata"]
	}
}
