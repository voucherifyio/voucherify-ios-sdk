import Foundation
import ObjectMapper

public struct OrderItem: Mappable {

    public var productId: String?
    public var skuId: String?
    public var quantity: Int?

    public init(productId: String, skuId: String, quantity: Int) {
        self.productId = productId
        self.skuId = skuId
        self.quantity = quantity
    }
    
    public init?(map: Map) {
        mapping(map: map)
    }
    
    mutating public func mapping(map: Map) {
        productId   <- map["product_id"]
        skuId       <- map["sku_id"]
        quantity    <- map["quantity"]
    }
}
