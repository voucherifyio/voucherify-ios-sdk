import Foundation
import ObjectMapper

/**
 * I hold a list of vouchers
 */
public struct VoucherList: Mappable {
	
	// Vouchers array for a given filtering query
	public var vouchers: [Voucher] = []
	
	// Total number of vouchers for given filtering query
	public var total: Int = 0
	
	// A string describing the object type returned
	public var object: String?
	
	// A value for this property directs to the property name which points to the results array
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
