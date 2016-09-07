Voucherify-Swift-SDK
======================

###Version: 0.3.0

Swift SDK for Voucherify to validate a voucher on client side.

[Voucherify](http://voucherify.io?utm_source=github&utm_medium=sdk&utm_campaign=acq) has a new platform that will help your team automate voucher campaigns. It does this by providing composable API and the marketer-friendly interface that increases teams' productivity:

- **roll-out thousands** of vouchers **in minutes** instead of weeks,
- **check status** or disable **every single** promo code in real time,
- **track redemption** history and build reports on the fly.

<b>Note:</b>
The Voucherify Swift SDK has not reached 1.0.0, yet, but we are on a good track to release it.

Example
=====

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Requirements
=====

The Voucherify Swift SDK requires Swift 2.2 and therefore Xcode 7.3.

Under the hood the Voucherify Swift SDK takes benefits of using
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)


Documentation
=====

You can find full documentation on [voucherify.readme.io](https://voucherify.readme.io).

Installation
=====

VoucherifySwiftSdk is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "VoucherifySwiftSdk"
```

Current list of features
=====
- validate a voucher based on its code and optionally order amount (required for gift vouchers)
- validate a gift voucher. This requires to pass an amount that is intended to be withdrawn from the voucher.
  Order amount have to be expressed in cents, as an integer. For example $22.50 should be provided as 2250

Usage
=====

* Validate by voucher code
```swift
let client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5", clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20")
client.validateVoucher("test") { (response) in
    debugPrint(response)
}
```

* Validate gift voucher
```swift
let client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5", clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20")
client.validateVoucher("test", amount: 1323) { (response) in
    debugPrint(response)
}
```

* Validate voucher with with validation rules concerning products or variants (SKUs). It's required to pass order items.
```swift
let client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5", clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20")
client.validateVoucher("test", orderItems: [
        OrderItem(productId: "prod_anJ03RZZq74z4v", skuId: "sku_F2S9beIUgWjX84", quantity: 1),
    ]) { (response) in
        debugPrint(response)
}
```

We are tracking users which are validating vouchers with those who consume them, by a `tracking_id`. By that we are setting up an identity for the user. If you want to provide your custom value for `tracking_id`, you have to do it when creating VoucherifyClient
```swift
client = VoucherifyClient(clientId: "011240bf-d5fc-4ef1-9e82-11eb68c43bf5", clientToken: "9e2230c5-71fb-460a-91c6-fbee64707a20", trackingId: "my_custom_tracking_id")
```

VoucherResponse
=====

Valid amount discount response:

    {
        "code": "VOUCHER_CODE",
        "valid": true,
        "discount": {
            "type": "AMOUNT",
            "amount_off": 999,
        },
        "tracking_id": "generated-or-passed-tracking-id"
    }

Valid percentage discount response:

    {
        "code": "VOUCHER_CODE",
        "valid": true,
        "discount": {
            "type": "PERCENT",
            "percent_off": 15.0,
        },
        "tracking_id": "generated-or-passed-tracking-id"
    }
    
Valid unit discount response:
    
    {
        "code": "VOUCHER_CODE",
        "valid": true,
        "discount": {
            "type": "UNIT",
            "unit_off": 1.0,
        },
        "tracking_id": "generated-or-passed-tracking-id"
    }

Valid gift voucher response:
    
    
    ```javascript
    {
        "code": "VOUCHER_CODE",
        "valid": true,
        "gift": {
            "amount": 10000
        }
        "tracking_id": "generated-or-passed-tracking-id"
    }
       ```

Invalid voucher response:

    {
        "code": "VOUCHER_CODE",
        "valid": false,
        "reason": "voucher expired",
        "tracking_id": "generated-or-passed-tracking-id"
    }

There are several reasons why validation may fail (`valid: false` response). 
You can find the actual cause in the `reason` field:

- `voucher is disabled`
- `voucher not active yet`
- `voucher expired`
- `quantity exceeded`
- `gift amount exceeded`

Author
=====

marcin.polak@rspective.pl / rspective P. Rychlik sp. j.

License
=====

Copyright (c) 2016 rspective P. Rychlik sp. j. See LICENSE for further details.
