import Foundation
import ObjectMapper

public struct Customer: Mappable {
    
    public var id: String?
    public var sourceId: String?
    public var name: String?
    public var email: String?
    public var description: String?
    public var createdAt: Date?
    public var metadata: Dictionary<String, AnyObject>?
    public var object: String?

    public init(id: String, sourceId: String?) {
        self.id = id
        self.sourceId = sourceId
    }
    
    public init?(map: Map) {
        mapping(map: map)
    }
    
    mutating public func mapping(map: Map) {
        id          <- map["id"]
        sourceId    <- map["source_id"]
        name        <- map["name"]
        email       <- map["email"]
        description <- map["description"]
        createdAt   <- (map["created_at"], ISO8601DateTransform())
        metadata    <- map["metadata"]
        object      <- map["object"]
    }
}

extension Customer: Querable {
    
    func asDictionary() -> Dictionary<String, Any> {
        
        var queryItems: [String: Any] = [:]
        
        queryItems["customer[id]"] = id
        queryItems["customer[source_id]"] = sourceId
        queryItems["customer[name]"] = name
        queryItems["customer[email]"] = email
        queryItems["customer[created_at]"] = createdAt
        queryItems["customer[object]"] = object
        
        if let metadata = metadata {
            for (key, value) in metadata {
                queryItems["customer[metadata][\(key)]"] = value
            }
        }
        
        return queryItems.filter({ !($0.value is NSNull) })
    }
}
