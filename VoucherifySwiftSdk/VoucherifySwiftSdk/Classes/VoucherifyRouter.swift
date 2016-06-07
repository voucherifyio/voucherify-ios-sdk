//
// Created by Marcin Polak on 05.06.2016.
//

import Foundation
import Alamofire

/*
* Simple enum to define Voucherify clients routes
*/
enum VoucherifyRouter: URLRequestConvertible {

    static let baseUrl = NSURL(string: VOUCHERIFY_SERVER_ENDPOINT)!;

    case VALIDATE_VOUCHER([String:AnyObject])

    var method: Alamofire.Method {
        return .GET;
    }

    var route: (path:String, parameters:[String:AnyObject]?) {
        switch self {
        case .VALIDATE_VOUCHER(let parameters):
            return ("/client/v1/validate", parameters);
        }
    }


    /*
    * URL for given API call
    */
    var URL: NSURL {
        return VoucherifyRouter.baseUrl.URLByAppendingPathComponent(route.path);
    }

    // MARK: URLRequestConvertible

    var URLRequest: NSMutableURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: URL);
        mutableURLRequest.HTTPMethod = method.rawValue;

        switch self {
        case .VALIDATE_VOUCHER(let parameters):
            return Alamofire
            .ParameterEncoding
            .URL
            .encode(mutableURLRequest, parameters: (parameters ?? [:])).0
        }
    }


}