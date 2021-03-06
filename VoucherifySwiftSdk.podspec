
Pod::Spec.new do |s|
  s.name             = 'VoucherifySwiftSdk'
  s.version          = '4.1.0'
  s.summary          = 'Swift SDK for Voucherify to validate a voucher on client side.'

  s.description      = <<-DESC
    Swift SDK for Voucherify to validate a voucher on client side.

    Voucherify has a new platform that will help your team automate voucher campaigns. It does this by providing composable API and the marketer-friendly interface that increases teams' productivity:

    - roll-out thousands of vouchers in minutes instead of weeks,
    - check status or disable every single promo code in real time,
    - track redemption history and build reports on the fly.

    You can find full documentation on voucherify.readme.io.
                       DESC

  s.homepage         = 'http://www.voucherify.io/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marcin.polak' => 'marcin.polak@rspective.pl' }
  s.source           = { :git => 'https://github.com/voucherifyio/voucherify-ios-sdk.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hashtag/voucherify'

  s.ios.deployment_target = '10.0'

  s.swift_versions = ['5.0', '5.1', '5.2', '5.3']

  s.source_files = 'VoucherifySwiftSdk/Classes/**/*'

  s.dependency 'Alamofire', '~> 5.3.0'
  s.dependency 'ObjectMapper', '~> 4.2.0'

end
