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
		var additionalHeaders = HTTPHeaders.default
		
		additionalHeaders[HttpHeader.httpHeaderContentType] = "application/json"
		additionalHeaders[HttpHeader.httpHeaderClientId] = clientId
		additionalHeaders[HttpHeader.httpHeaderClientToken] = clientToken
		additionalHeaders[HttpHeader.httpHeaderOrigin] = origin.isEmpty ? voucherifyDefaultOrigin : origin
		additionalHeaders[HttpHeader.httpHeaderChannel] = voucherifyChannelName
		
		sessionConfiguration.headers = additionalHeaders
		let manager = Alamofire.Session(configuration: sessionConfiguration)
		
		return VoucherifyHttpClient(
			sessionManager: manager,
			configuration: configuration,
			trackingId: trackingId)
	}
}