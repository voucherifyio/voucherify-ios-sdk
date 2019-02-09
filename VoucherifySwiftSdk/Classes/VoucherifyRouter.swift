import Foundation
import Alamofire
import ObjectMapper

/**
* Simple enum to define Voucherify clients routes
*/
public enum VoucherifyRouter: URLRequestConvertible {
    
    static let baseUrl = voucherifyServerEndpoint
    
    case validateVoucher([String: Any])
    case listVouchers([String: Any])
    case validatePromotions([String: Any], PromotionValidationContext)
    case redeemVoucher([String: Any], VoucherRedemptionContext?)
    case redeemPromotion([String: Any], String, PromotionRedemptionContext?)
    case listPromotionsTiers([String: Any])
    
    var method: Alamofire.HTTPMethod {
        switch self {
        
        case .listVouchers,
             .listPromotionsTiers:
            return .get
            
        case .validateVoucher,
             .validatePromotions:
            return .get
            
        case .redeemVoucher,
             .redeemPromotion:
            return .post
        }
    }
    
    var route: (path: String, parameters: [String: Any]?) {
        switch self {
        case .listVouchers(let parameters):
            return ("/client/v1/vouchers", parameters);
        case .listPromotionsTiers(let parameters):
            return ("/client/v1/promotions/tiers", parameters);
        case .validateVoucher(let parameters):
            return ("/client/v1/validate", parameters);
        case .validatePromotions(let parameters, _):
            return ("/client/v1/promotions/validation", parameters)
        case .redeemVoucher(let parameters, _):
            return ("/client/v1/redeem", parameters)
        case let .redeemPromotion(parameters, promotionTierId, _):
            return ("/client/v1/promotions/tiers/\(promotionTierId)/redemption", parameters)
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: VoucherifyRouter.baseUrl)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(route.path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .listVouchers(let parameters):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
            
        case .listPromotionsTiers(let parameters):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
            
        case .validateVoucher(let parameters):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        
        case .redeemVoucher(let parameters, let body):
            if let data = body?.toJSONString(prettyPrint: true)?.data(using: String.Encoding.utf8) {
                urlRequest.httpBody = data
            }
            
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)

        case let .redeemPromotion(parameters, _, body):
            if let data = body?.toJSONString(prettyPrint: true)?.data(using: String.Encoding.utf8) {
                urlRequest.httpBody = data
            }
    
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
        
        case .validatePromotions(let parameters, let body):
            var queryParameters = parameters
    
            queryParameters = queryParameters
                .merging(body.asDictionary(), uniquingKeysWith: { (first, _) in first })
            
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: queryParameters)
        }
    }
}
