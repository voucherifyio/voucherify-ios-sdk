//
// Created by Marcin Polak on 05.06.2016.
//

import Foundation
import Alamofire
import ObjectMapper

/**
 Voucherify client object for performing voucher request against the Voucherify API
*/
public class VoucherifyClient {

    /*
    * Client's custom configuration
    */
    private let configuration: Configuration

    /*
    * Alamofire's manager to perform HTTP calls
    */
    private let manager: Alamofire.Manager

    /*
    * Query custom tracking param
    */
    private let trackingId: String

    /**
     Initializes a new VoucherifyClient client instance
     - parameter configuration: Custom configuration of the client
     - returns: An initialized client instance
     */
    public init(clientId: String, clientToken: String, origin: String = "", trackingId: String = "swift-sdk", configuration: Configuration = Configuration()) {
        self.trackingId = trackingId
        self.configuration = configuration

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration();
        var additionalHeaders = Alamofire.Manager.defaultHTTPHeaders ?? [:];

        additionalHeaders[HttpHeader.HTTP_HEADER_CONTENT_TYPE] = "application/json"
        additionalHeaders[HttpHeader.HTTP_HEADER_CLIENT_ID] = clientId
        additionalHeaders[HttpHeader.HTTP_HEADER_CLIENT_TOKEN] = clientToken
        additionalHeaders[HttpHeader.HTTP_HEADER_ORIGIN] = origin.isEmpty ? VOUCHERIFY_DEFAULT_ORIGIN : origin
        additionalHeaders[HttpHeader.HTTP_HEADER_VOUCHERIFY_CHANNEL] = VOUCHERIFY_CHANNEL_NAME

        sessionConfiguration.HTTPAdditionalHeaders = additionalHeaders;
        manager = Alamofire.Manager(configuration: sessionConfiguration);

    }

    private func request(requestUrl: URLRequestConvertible, completion: (Response<AnyObject, NSError>) -> Void) {
        manager.request(requestUrl).responseJSON(queue: dispatch_get_main_queue()) {
            responseData in

            debugPrint("[Voucherify] Response from \(requestUrl.URLRequest.URL): \n \(responseData)")
            completion(responseData)
        }
    }

    private func getBaseQueryParams() -> [String: AnyObject] {
        var params = [String: AnyObject]()

        params[HttpQueryParamName.TRACKING_ID] = self.trackingId
        params[HttpQueryParamName.CHANNEL] = configuration.userAgentClient

        return params
    }
    
    private func handleJsonResponse<T: Mappable>(response: Response<AnyObject, NSError>) -> T? {
        let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(response.data! as NSData, options: [])
        
        var data : T?;
        
        if let r: AnyObject = json {
            data = Mapper<T>().map(r)!;
        }
        
        return data

    }

}

extension VoucherifyClient {

    /**
     Mthod which allows to validate voucher code
     - parameter code: Voucher's code which we want to validate
     - parameter completion: response callback function
     */
    public func validateVoucher(code: String, completion: (response: VoucherResponse?) -> Void) {
        var params = getBaseQueryParams()
        
        params[HttpQueryParamName.CODE] = code

        request(VoucherifyRouter.VALIDATE_VOUCHER(params)) { (response) in
            completion(response: self.handleJsonResponse(response))
        }
    }

}
