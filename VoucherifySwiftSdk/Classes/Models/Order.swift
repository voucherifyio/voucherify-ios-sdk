import Foundation
import ObjectMapper

public struct Order: Mappable {
    
    public var amount: Int?
    public var items: Array<OrderItem>?
 
    public init(amount: Int, items: Array<OrderItem>) {
        self.amount = amount
        self.items = items
    }
    
    public init?(map: Map) {
        mapping(map: map)
    }
    
    mutating public func mapping(map: Map) {
        amount  <- map["amount"]
        items   <- map["items"]
    }
}
