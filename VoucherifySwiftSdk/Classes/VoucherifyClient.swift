import Foundation

/// Voucherify client object for performing validations and redemptions request against the Voucherify API
public class VoucherifyClient {
	
	/// Client's custom configuration
	private let configuration: Configuration
	
	/// Client's http client
	private let httpClient: VoucherifyHttpClient
	
	private lazy var validation: ValidationApi = {
		VoucherifyValidation(httpClient: httpClient)
	}()
	
	private lazy var redemption: RedemptionApi = {
		VoucherifyRedemption(httpClient: httpClient)
	}()
	
	/**
	 Initializes a new voucherify client using the provided parameters
	
	 - Parameters:
 		- clientId: A client-side ID
 		- clientToken: A client-side key
 		- origin: A client origin
 		- trackingId: A client custom tracking ID
 		- configuration: A custom configuration of the client
 	
 	 - Returns: a new voucherify client
	 */
	public init(clientId: String,
				clientToken: String,
				origin: String = "",
				trackingId: String = "swift-sdk",
				configuration: Configuration = Configuration()) {
		
		self.configuration = configuration
		self.httpClient = VoucherifyHttpClientFactory.create(
			clientId: clientId,
			clientToken: clientToken,
			origin: origin,
			trackingId: trackingId,
			configuration: configuration
		)
	}
}

extension VoucherifyClient: Client {
	
	public var validations: ValidationApi {
		return validation
	}
	
	public var redemptions: RedemptionApi {
		return redemption
	}
}
