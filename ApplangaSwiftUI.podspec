Pod::Spec.new do |s|
  s.name                = "ApplangaSwiftUI"
  s.version             = "2.0.174"
  s.summary             = "This is the SwiftUI Applanga SDK"
  s.homepage            = "http://applanga.com"
  s.license             = { :type => 'Commercial', :file => 'LICENSE' }
  s.author              = { "Mbaas Development GmbH" => "developer@applanga.com" }
  s.source              = { :git => "https://github.com/applanga/sdk-swiftui.git", :tag => "2.0.174" }
  s.requires_arc        = true

  s.ios.deployment_target = '13.0'
  s.swift_versions = '5.0'
  s.ios.vendored_frameworks = 'ApplangaSwiftUI.xcframework'

  s.dependency 'Applanga'
end
