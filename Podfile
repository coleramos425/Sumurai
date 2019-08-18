# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Sumurai' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!
    pod 'SwiftyJSON'
    pod 'Cards'
    pod 'Player'
    pod 'Alamofire', '~>4.5.1'
    pod 'lottie-ios'
    # Pods for Sumurai
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings.delete('CODE_SIGNING_ALLOWED')
      config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
  end

end
