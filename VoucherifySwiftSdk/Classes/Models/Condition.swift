import Foundation
import ObjectMapper

public struct Condition: Mappable {
	
	public var id: String?
	public var createdAt: Date?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		id			<- map["id"]
		createdAt 	<- (map["created_at"], ISO8601DateTransform())
	}
}
