import Foundation
import Alamofire
import ObjectMapper

/**
* Simple enum to define Voucherify clients routes
*/
public enum VoucherifyRouter: URLRequestConvertible {

    static let baseUrl = voucherifyServerEndpoint

    case validateVoucher([String:AnyObject])
    case redeemVoucher([String:AnyObject], VoucherRedemptionContext?)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .validateVoucher:
            return .get
        case .redeemVoucher:
            return .post
        }
    }

    var route: (path:String, parameters:[String:AnyObject]?) {
        switch self {
        case .validateVoucher(let parameters):
            return ("/client/v1/validate", parameters);
        case .redeemVoucher(let parameters, _):
            return ("/client/v1/redeem", parameters)
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: VoucherifyRouter.baseUrl)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(route.path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .validateVoucher(let parameters):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)

        case .redeemVoucher(let parameters, let body):
            if let body = body {
                let data = body.toJSONString(prettyPrint: true)!.data(using: String.Encoding.utf8)!
                urlRequest.httpBody = data
            }
        
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
            
        }
    }
    
}
