<p align="center">
  <img src="./docs/images/voucherify-ios-sdk.png"/>
</p>

<h3 align="center">Official <a href="http://voucherify.io?utm_source=github&utm_medium=sdk&utm_campaign=acq">Voucherify</a> SDK for Swift</h3>

<p align="center">
<b><a href="#setup">Setup</a></b>
|
<b><a href="#contributing">Contributing</a></b>
|
<b><a href="#changelog">Changelog</a></b>
|
<b><a href="#license">License</a></b>
|
</p>

<p align="center">
API:
<a href="#validations">Validations</a>
|
<a href="#redemptions">Redemptions</a>
|
<a href="#voucher-listing">Voucher Listing</a>
|
<a href="#promotions">Promotions</a>
</p>


## Setup

The Voucherify Swift SDK requires Swift 5.1

###### Using [CocoaPods](http://cocoapods.org):

```ruby
pod "VoucherifySwiftSdk"
```

### Configuration
The `VoucherifyClient` manages your interaction with the Voucherify API.

```swift
VoucherifyClient(
    clientId: YOUR-PUBLIC-CLIENT-APPLICATION-ID,
    clientToken: YOUR-PUBLIC-CLIENT-APPLICATION-TOKEN)
```

We are tracking users which are validating vouchers with those who consume them, by a `tracking_id`. By that we are setting up an identity for the user. If you want to provide your custom value for `tracking_id`, you have to do it when creating VoucherifyClient:
```swift
VoucherifyClient(
    clientId: YOUR-PUBLIC-CLIENT-APPLICATION-ID,
    clientToken: YOUR-PUBLIC-CLIENT-APPLICATION-TOKEN,
    origin: YOUR_ORIGIN,
    trackingId: YOUR_TRACKING_ID,
    configuration: Configuration)
```

#### API Endpoint

Optionally, you can specify `server` configuration option if you want to use Voucherify running in a specific region.

```swift
let configuration = Configuration()
configuration.server = "https://<region>.api.voucherify.io"

VoucherifyClient(
    clientId: YOUR-PUBLIC-CLIENT-APPLICATION-ID,
    clientToken: YOUR-PUBLIC-CLIENT-APPLICATION-TOKEN,
    origin: YOUR_ORIGIN,
    trackingId: YOUR_TRACKING_ID,
    configuration: configuration)
```

## API

#### Voucher listing

### [List Vouchers]

```swift
    client.vouchers.list(customer: String?,
                      	 completion: @escaping (_ response: Result<VoucherList>) -> Void
```


#### Validations

### [Validate Voucher]

```swift
    client.validations.validateVoucher(code: String,
                                       amount: Int? = nil,
                                       completion: (_ response: Result<VoucherResponse>) -> Void)
```

```swift
    client.validations.validateVoucher(code: String,
                                       amount: Int? = nil,
                                       orderItems: [OrderItem],
                                       completion: (_ response: Result<VoucherResponse>) -> Void)
```

### [Validate Promotions]

```swift
    client.validations.validatePromotion(validationContext: promotionValidationContext,
                                         completion: (_ response: Result<PromotionValidationResponse>) -> Void)
```

#### Redemptions

### [Redeem Voucher]

```swift
    client.redeemptions.redeem(code: String,
                               redeemContext: VoucherRedemptionContext? = nil,
                               completion: (_ response: Result<VoucherRedemptionResult>) -> Void)
```

### [Redeem Promotions]

```swift
    client.redeemptions.redeem(promotionTierId: String,
                               redeemContext: PromotionRedemptionContext,
                               completion: @escaping (Result<PromotionTierRedemptionResult>) -> Void)
```

#### Promotions

### [List Promotion Tiers]

```swift
    client.promotions.list(isAvailable: Bool = true,
                           limit: Int = 100,
                           page: Int = 1,
                           completion: @escaping (Result<PromotionTierPage>) -> Void)
```

## Contributing

Bug reports and pull requests are welcome through [GitHub Issues](https://github.com/voucherifyio/voucherify-ios-sdk/issues).

## Changelog
- **2020-11-28** - `4.1.0` - Extend VoucherResponse by `campaign` and `campaignId` field, update dependencies, Swift 5.3
- **2019-11-10** - `4.0.0` - Swift 5.1 and increased ios minimum deployment target to 10
- **2019-02-18** - `3.3.0` - Add API method to list promotion tiers
- **2019-01-27** - `3.2.0` - Add API method to list vouchers
- **2019-01-02** - `3.1.0` - Add API methods to validate and redeem a promotion
- **2018-12-15** - `3.0.0` - Client's API unification. Information about breaking changes can be find here: https://github.com/voucherifyio/voucherify-ios-sdk/wiki/Voucherify-3.0.0-Migration-Guide
- **2018-12-04** - `2.0.0` - Swift 4.2
- **2018-09-29** - `1.4.0` - Change minimum target version to 9.0 and update external dependency to the latest version
- **2017-03-17** - `1.3.0` - Improve error handling
- **2017-03-17** - `1.2.0` - Fix OrderItem mappings
- **2017-03-16** - `1.1.0` - Update Order and OrderItem model
- **2017-01-12** - `1.0.0` - Unify API with other voucherify SDKs
- **2016-09-15** - `0.4.0` - Redeem a voucher
- **2016-08-08** - `0.3.0` - Validate voucher with validation rules concerning products or variants (SKUs)
- **2016-07-22** - `0.2.0` - Validate gift voucher
- **2016-07-08** - `0.1.0` - Validate voucher by its code

## License

MIT. See the [LICENSE](https://github.com/voucherifyio/voucherify-ios-sdk/blob/master/LICENSE) file for details.

[Validate Voucher]: https://docs.voucherify.io/reference#vouchers-validate
[Validate Promotions]: https://docs.voucherify.io/reference#validate-promotions-1
[Redeem Voucher]: https://docs.voucherify.io/reference#redeem-voucher-client-side
[Redeem Promotions]: https://docs.voucherify.io/reference#redeem-promotion
[List Vouchers]: https://docs.voucherify.io/v2018-08-01/reference#list-vouchers
[List Promotion Tiers]: https://docs.voucherify.io/v2018-08-01/reference#list-promotion-tiers-client-side
