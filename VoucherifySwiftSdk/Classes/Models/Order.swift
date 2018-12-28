import Foundation
import ObjectMapper

public struct Order: Mappable {
	
	public var id: String?
	public var object: String?
	public var amount: Int?
	public var items: Array<OrderItem>?
	public var sourceId: String?
	public var discountAmount: Int?
	public var createdAt: Date?
	public var updatedAt: Date?
	public var customer: Customer?
	public var status: String?
	public var metadata: Dictionary<String, Any>?
	
	public init(amount: Int, items: Array<OrderItem>) {
		self.amount = amount
		self.items = items
	}
	
	public init?(map: Map) {
		mapping(map: map)
	}
	
	mutating public func mapping(map: Map) {
		amount 			<- map["amount"]
		items 			<- map["items"]
		object 			<- map["object"]
		id 				<- map["id"]
		sourceId 		<- map["source_id"]
		discountAmount 	<- map["discount_amount"]
		createdAt 		<- map["created_at"]
		updatedAt 		<- map["updated_at"]
		customer 		<- map["customer"]
		status 			<- map["status"]
		metadata 		<- map["metadata"]
	}
}

extension Order: Querable {
	
	func asDictionary() -> Dictionary<String, Any> {
		
		var queryItems: [String: Any] = [:]
		
		queryItems["amount"] = amount
		
		if let items = items {
			for (index, item) in items.enumerated() {
				queryItems["item[\(index)][product_id]"] = item.productId
				queryItems["item[\(index)][sku_id]"] = item.skuId
				queryItems["item[\(index)][quantity]"] = item.quantity
				queryItems["item[\(index)][price]"] = item.price
			}
		}
		
		return queryItems.filter({ !($0.value is NSNull) })
	}
}
