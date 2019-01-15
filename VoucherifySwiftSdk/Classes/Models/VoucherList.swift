import Foundation
import ObjectMapper

public struct VoucherList: Mappable {
	
	public var vouchers: [Voucher] = []
	
	public var total: Int = 0
	
	public var object: String?
	
	public var dataRef: String?
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		vouchers	<- map["vouchers"]
		total      	<- map["total"]
		object      <- map["object"]
		dataRef     <- map["data_ref"]
	}
}
