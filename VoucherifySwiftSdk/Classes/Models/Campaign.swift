import Foundation
import ObjectMapper

public struct Campaign: Mappable {
	
	public var id: String?
	public var object: String?
	public var startDate: Date?
	public var expirationDate: Date?
	public var active: Bool?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		id 				<- map["id"]
		object 			<- map["object"]
		startDate 		<- (map["start_date"], ISO8601DateTransform())
		expirationDate 	<- (map["expiration_date"], ISO8601DateTransform())
		active 			<- map["active"]
	}
}
