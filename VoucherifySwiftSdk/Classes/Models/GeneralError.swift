import Foundation
import ObjectMapper

public struct GeneralError: Error, Mappable {
    
    public var code: Int?
    public var details: String?
    public var message: String?
 
    public init?(map: Map) {
        mapping(map: map)
    }
    mutating public func mapping(map: Map) {
        code    <- map["code"]
        details <- map["details"]
        message <- map["message"]
    }
}
