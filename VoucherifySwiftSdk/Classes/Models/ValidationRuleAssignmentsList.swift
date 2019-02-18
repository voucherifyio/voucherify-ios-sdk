import Foundation
import ObjectMapper

public struct ValidationRuleAssignmentsList: Mappable {
	
	public var object: String?
	public var dataRef: String?
	public var total: Int = 0
	public var data: [ValidationRuleAssignment] = []
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		dataRef <- map["data_ref"]
		object 	<- map["object"]
		total 	<- map["total"]
		data 	<- map["data"]
	}
}
