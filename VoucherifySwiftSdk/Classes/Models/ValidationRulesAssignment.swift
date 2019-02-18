import Foundation
import ObjectMapper

public struct ValidationRuleAssignment: Mappable {
	
	public var id: String = ""
	public var ruleId: String = ""
	public var relatedObjectId: String?
	public var relatedObjectType: String?
	public var createdAt: Date?
	public var updatedAt: Date?
	public var object: String?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		id 					<- map["id"]
		ruleId 				<- map["rule_id"]
		relatedObjectId 	<- map["related_object_id"]
		relatedObjectType 	<- map["related_object_type"]
		createdAt 			<- (map["created_at"], ISO8601DateTransform())
		updatedAt 			<- (map["updated_at"], ISO8601DateTransform())
		object 				<- map["object"]
	}
}
