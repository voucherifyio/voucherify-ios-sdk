import Foundation
import Alamofire

/**
* Simple enum to define Voucherify clients routes
*/
enum VoucherifyRouter: URLRequestConvertible {

    static let baseUrl = NSURL(string: VOUCHERIFY_SERVER_ENDPOINT)!;

    case VALIDATE_VOUCHER([String:AnyObject])
    case REDEEM_VOUCHER([String:AnyObject])

    var method: Alamofire.Method {
        switch self {
        case .VALIDATE_VOUCHER:
            return .GET
        case .REDEEM_VOUCHER:
            return .POST
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
    var URL: NSURL {
        return VoucherifyRouter.baseUrl.URLByAppendingPathComponent(route.path);
    }

    var URLRequest: NSMutableURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: URL);
        mutableURLRequest.HTTPMethod = method.rawValue;

        switch self {
        case .VALIDATE_VOUCHER(let parameters):
            return Alamofire
            .ParameterEncoding
            .URL
            .encode(mutableURLRequest, parameters: (parameters ?? [:])).0
        case .REDEEM_VOUCHER(let parameters):
            return Alamofire
            .ParameterEncoding
            .URLEncodedInURL
            .encode(mutableURLRequest, parameters: (parameters ?? [:])).0
        }
    }


}