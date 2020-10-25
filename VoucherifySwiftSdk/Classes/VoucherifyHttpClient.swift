import UIKit
import Alamofire
import ObjectMapper

public class VoucherifyHttpClient {

    /// Alamofire's manager to perform HTTP calls
    fileprivate let manager: Alamofire.Session

    fileprivate let configuration: Configuration

    fileprivate let trackingId: String

    internal init(sessionManager: Alamofire.Session, configuration: Configuration, trackingId: String) {
        self.manager = sessionManager
        self.configuration = configuration
        self.trackingId = trackingId
    }

    internal func request(requestUrl: URLRequestConvertible, completion: @escaping (AFDataResponse<Any>) -> Void) {
        manager.request(requestUrl).responseJSON { response in
            completion(response)
        }
    }

    internal func getBaseQueryParams() -> [String: Any] {
        var params = [String: Any]()

        params[HttpQueryParamName.trackingId] = self.trackingId as Any?
        params[HttpQueryParamName.channel] = configuration.userAgentClient as Any?

        return params
    }

    internal func handleJsonResponse<T: Mappable>(response: AFDataResponse<Any>) -> AFResult<T> {
        if let error = response.error {
            return AFResult<T>.failure(error)
        }

        let json: AnyObject? = try! JSONSerialization.jsonObject(
                with: (response.data! as NSData) as Data, options: []) as AnyObject?

        if let errorJson = json {
            let error = Mapper<GeneralError>().map(JSONObject: errorJson)

            if let error = error?.asAFError, error.responseCode != nil {
                return AFResult<T>.failure(error)
            }
        }

        var data: T?
        
        if let json = json {
            data = Mapper<T>().map(JSONObject: json)
        }

        return AFResult<T>.success(data!)

    }

}
