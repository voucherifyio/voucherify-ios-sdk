import Foundation
import ObjectMapper

public struct Promotion: Mappable {
	
	public var id: String?
	public var discount: Discount?
	public var discountAmount: Int?
	public var banner: String?
	public var object: String?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		id 				<- map["id"]
		discount 		<- map["discount"]
		discountAmount 	<- map["discount_amount"]
		banner 			<- map["banner"]
		object 			<- map["object"]
	}
}
