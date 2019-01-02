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
            completion(response)
        }
    }

    internal func getBaseQueryParams() -> [String: Any] {
        var params = [String: Any]()

        params[HttpQueryParamName.trackingId] = self.trackingId as Any?
        params[HttpQueryParamName.channel] = configuration.userAgentClient as Any?

        return params
    }

    internal func handleJsonResponse<T: Mappable>(response: DataResponse<Any>) -> Result<T> {
        if let error = response.error {
            return Result<T>.failure(error)
        }

        let json: AnyObject? = try! JSONSerialization.jsonObject(
                with: (response.data! as NSData) as Data, options: []) as AnyObject?

        if let errorJson = json {
            let error = Mapper<GeneralError>().map(JSONObject: errorJson)

            if let error = error, error.code != nil {
                return Result<T>.failure(error)
            }
        }

        var data: T?
        
        if let json = json {
            data = Mapper<T>().map(JSONObject: json)
        }

        return Result<T>.success(data!)

    }

}
