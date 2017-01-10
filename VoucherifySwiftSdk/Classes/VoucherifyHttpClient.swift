import UIKit
import Alamofire
import ObjectMapper

public class VoucherifyHttpClient {

    /// Alamofire's manager to perform HTTP calls
    fileprivate let manager: Alamofire.SessionManager

    fileprivate let configuration: Configuration

    fileprivate let trackingId: String

    internal init(sessionManager: Alamofire.SessionManager, configuration: Configuration, trackingId: String) {
        self.manager = sessionManager
        self.configuration = configuration
        self.trackingId = trackingId
    }

    internal func request(requestUrl: URLRequestConvertible, completion: @escaping (DataResponse<Any>) -> Void) {
        manager.request(requestUrl).responseJSON { response in
                    debugPrint("Request: \(try! requestUrl.asURLRequest().url?.absoluteString)")
                    debugPrint("[Voucherify] JSON Response \(response.result.value)")
                    completion(response)
                }
    }

    internal func getBaseQueryParams() -> [String: AnyObject] {
        var params = [String: AnyObject]()

        params[HttpQueryParamName.trackingId] = self.trackingId as AnyObject?
        params[HttpQueryParamName.channel] = configuration.userAgentClient as AnyObject?

        return params
    }

    internal func handleJsonResponse<T: Mappable>(response: DataResponse<Any>) -> T? {
        let json: AnyObject? = try! JSONSerialization.jsonObject(with: (response.data! as NSData) as Data, options: []) as AnyObject?

        var data : T?;

        if let r: AnyObject = json {
            data = Mapper<T>().map(JSONObject: r)!;
        }

        return data

    }

}
