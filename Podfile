# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MyExD' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyExD
   pod 'SwiftGifOrigin' , '~> 1.7.0' #https://github.com/swiftgif/SwiftGif
   pod 'Alamofire', '4.8.1'
   pod 'MaterialComponents/Snackbar'
   pod 'TransitionButton'
   pod 'SDWebImage'
   pod 'IQKeyboardManager', '6.2.0'
   pod 'Toast-Swift', '~> 5.0.1'
   pod 'NVActivityIndicatorView'   #https://github.com/ninjaprox/NVActivityIndicatorView
   pod 'DTTextField'
   pod 'BRYXBanner'
   pod 'Firebase/Core'
   pod 'Firebase/Analytics'
   pod 'Firebase/Auth'
   pod 'Firebase/Messaging'
   pod 'Firebase/Firestore'


   
   
   post_install do |installer|
   installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
   end
   end
   end

end
