import Foundation

public struct OrderItem {

    public let productId: String
    public let skuId: String
    public let quantity: Int

    public init(productId: String, skuId: String, quantity: Int) {
        self.productId = productId
        self.skuId = skuId
        self.quantity = quantity
    }
}
