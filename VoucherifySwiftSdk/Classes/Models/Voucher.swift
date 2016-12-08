import Foundation
import ObjectMapper

public struct Voucher: Mappable {
    /// The unique voucher's id
    public var id: String?

    /// The unique voucher's code used for instance to consume it
    public var code: String?

    /// Voucher's type
    public var type: VoucherType?

    /// The name of voucher's campaign
    public var campaign: String?

    /// The name of voucher's category
    public var category: String?

    /// Discount definition - present if type is DISCOUNT_VOUCHER
    public var discount: Discount?

    /// Gift definition (amount) - present if type is GIFT_VOUCHER
    public var gift: Gift?

    /// Voucher's start date
    //@SerializedName("")
    public var startDate: Date?

    /// Voucher's expiration date
    public var expirationDate: Date?

    /// Disables a voucher when set to false even if it's within a activity period (start date - expiration date).
    public var active: Bool?

    /// Holds information about voucher's publications
    public var publish: VoucherPublish?

    /// Holds information about voucher's redemption
    public var redemption: VoucherRedemption?

    /// Additional voucher's information
    public var additionalInfo: String?

    public var metadata: Dictionary<String, AnyObject>?

    public init?(map: Map) {
        mapping(map:map)
    }

    mutating public func mapping(map: Map) {
        id              <- map["id"]
        code            <- map["code"]
        type            <- map["type"]
        campaign        <- map["campaign"]
        category        <- map["category"]
        discount        <- map["discount"]
        gift            <- map["gift"]
        startDate       <- (map["start_date"], DateTransform())
        expirationDate  <- (map["expiration_date"], DateTransform())
        active          <- map["active"]
        publish         <- map["publish"]
        redemption      <- map["redemption"]
        additionalInfo  <- map["additional_info"]
        metadata        <- map["metadata"]
    }
}

