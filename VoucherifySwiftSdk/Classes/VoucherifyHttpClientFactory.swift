import Alamofire
import Foundation
import ObjectMapper

enum VoucherifyHttpClientFactory {
	
	static func create(clientId: String,
					   clientToken: String,
					   origin: String,
					   trackingId: String,
					   configuration: Configuration) -> VoucherifyHttpClient {
		
		let sessionConfiguration = URLSessionConfiguration.default
		var additionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
		
		additionalHeaders[HttpHeader.httpHeaderContentType] = "application/json"
		additionalHeaders[HttpHeader.httpHeaderClientId] = clientId
		additionalHeaders[HttpHeader.httpHeaderClientToken] = clientToken
		additionalHeaders[HttpHeader.httpHeaderOrigin] = origin.isEmpty ? voucherifyDefaultOrigin : origin
		additionalHeaders[HttpHeader.httpHeaderChannel] = voucherifyChannelName
		
		sessionConfiguration.httpAdditionalHeaders = additionalHeaders
		let manager = Alamofire.SessionManager(configuration: sessionConfiguration)
		
		return VoucherifyHttpClient(
			sessionManager: manager,
			configuration: configuration,
			trackingId: trackingId)
	}
}