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
<a href="#validations-api">Validations</a>
|
<a href="#redemptions-api">Redemptions</a>
</p>


## Setup

The Voucherify Swift SDK requires Swift 4.2

###### Using [CocoaPods](http://cocoapods.org):

```ruby
pod "VoucherifySwiftSdk"
```

### Configuration
The `VoucherifyClient` manages your interaction with the Voucherify API.

```swift
VoucherifyClient(clientId: YOUR-PUBLIC-CLIENT-APPLICATION-ID, clientToken: YOUR-PUBLIC-CLIENT-APPLICATION-TOKEN)
```

We are tracking users which are validating vouchers with those who consume them, by a `tracking_id`. By that we are setting up an identity for the user. If you want to provide your custom value for `tracking_id`, you have to do it when creating VoucherifyClient:
```swift
VoucherifyClient(clientId: YOUR-PUBLIC-CLIENT-APPLICATION-ID, clientToken: YOUR-PUBLIC-CLIENT-APPLICATION-TOKEN, origin: YOUR_ORIGIN, trackingId: YOUR_TRACKING_ID, configuration: Configuration)
```

## API

#### Validations API

### [Validate Voucher]

```swift
    client.vouchers().validations().validateVoucher(code: String, amount: Int? = nil, completion: (_ response: Result<VoucherResponse>) -> Void)
```

```swift
    client.vouchers().validations().validateVoucher(code: String, amount: Int? = nil, orderItems: [OrderItem], completion: (_ response: Result<VoucherResponse>) -> Void)
```

#### Redemptions API

### [Redeem Voucher]

```swift
    client.vouchers().redeemptions().redeem(code: String, redeemContext: VoucherRedemptionContext? = nil, completion: (_ response: Result<VoucherRedemptionResult>) -> Void)
```

## Contributing

Bug reports and pull requests are welcome through [GitHub Issues](https://github.com/voucherifyio/voucherify-ios-sdk/issues).

## Changelog
- **2018-12-04** - `2.0.0` - Swift 4.2
- **2018-09-29** - `1.4.0` - Change minimum target version to 9.0 and update external dependency to the latest version
- **2017-03-17** - `1.3.0` - Improve error handling
- **2017-03-17** - `1.2.0` - Fix OrderItem mappings
- **2017-03-16** - `1.1.0` - Update Order and OrderItem model
- **2017-01-12** - `1.0.0` - Unify API with other voucherify SDKs
- **2016-09-15** - `0.4.0` - redeem a voucher
- **2016-08-08** - `0.3.0` - validate voucher with validation rules concerning products or variants (SKUs)
- **2016-07-22** - `0.2.0` - validate gift voucher
- **2016-07-08** - `0.1.0` - validate voucher by its code

## License

MIT. See the [LICENSE](https://github.com/voucherifyio/voucherify-ios-sdk/blob/master/LICENSE) file for details.

[Validate Voucher]: https://docs.voucherify.io/reference#vouchers-validate
[Redeem Voucher]: https://docs.voucherify.io/reference#redeem-voucher-client-side
