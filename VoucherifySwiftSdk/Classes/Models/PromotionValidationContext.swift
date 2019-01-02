import Foundation
import ObjectMapper

public struct PromotionValidationContext: Mappable {
	
	public var customer: Customer?
	public var order: Order?
	public var metadata: Dictionary<String, Any>?
	
	public init(customer: Customer? = nil,
				order: Order? = nil,
				metadata: Dictionary<String, Any>? = nil) {
		
		self.customer = customer
		self.order = order
		self.metadata = metadata
	}
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		customer <- map["customer"]
		order    <- map["order"]
		metadata <- map["metadata"]
	}
}

extension PromotionValidationContext: Querable {
	
	func asDictionary() -> Dictionary<String, Any> {
		
		var queryParameters: [String: Any] = [:]
		
		if let customerQueryParameters = customer?.asDictionary() {
			queryParameters = queryParameters
				.merging(customerQueryParameters, uniquingKeysWith: { (first, _) in first })
		}
		
		if let orderQueryParameters = order?.asDictionary() {
			queryParameters = queryParameters
				.merging(orderQueryParameters, uniquingKeysWith: { (first, _) in first })
		}
		
		if let metadataQueryParameters = metadata {
			
			for (key, value) in metadataQueryParameters {
				queryParameters["metadata[\(key)]"] = value
			}
		}
		
		return queryParameters
	}
}
