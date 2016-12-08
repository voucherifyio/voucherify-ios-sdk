import Foundation
import Alamofire

/**
* Simple enum to define Voucherify clients routes
*/
enum VoucherifyRouter: URLRequestConvertible {

    static let baseUrl = VOUCHERIFY_SERVER_ENDPOINT

    case VALIDATE_VOUCHER([String:AnyObject])
    case REDEEM_VOUCHER([String:AnyObject])

    var method: Alamofire.HTTPMethod {
        switch self {
        case .VALIDATE_VOUCHER:
            return .get
        case .REDEEM_VOUCHER:
            return .post
        }
    }

    var route: (path:String, parameters:[String:AnyObject]?) {
        switch self {
        case .VALIDATE_VOUCHER(let parameters):
            return ("/client/v1/validate", parameters);
        case .REDEEM_VOUCHER(let parameters):
            return ("/client/v1/redeem", parameters)
        }
    }

    /// URL for given API call
//    var URL: NSURL {
//        return VoucherifyRouter.baseUrl.appendingPathComponent(route.path);
//    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: VoucherifyRouter.baseUrl)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(route.path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .VALIDATE_VOUCHER(let parameters):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)

        case .REDEEM_VOUCHER(let parameters):
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
 
    }


}
