# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RushApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RushApp


  #AWS
    pod 'AWSUserPoolsSignIn', '~> 2.6.13'
    pod 'AWSAuthUI', '~> 2.6.13'
    pod 'AWSCognito'
    pod 'AWSCognitoIdentityProvider'
    pod 'AWSLambda'
    pod 'AWSS3'
    pod 'AWSAppSync'
    
  #Facebook
    pod 'FacebookLogin'
    
  #TextField
    pod 'IQKeyboardManagerSwift'
    pod 'PMAlertController'
  
  #Loader
    pod 'SVProgressHUD'
    
  #Image Crop and Selector
    pod 'Fusuma'

  #Image download and cache
    pod 'SDWebImage', '~> 4.0'
    pod 'GSKStretchyHeaderView'
    pod 'CRRefresh'
    pod 'DeckTransition', '~> 2.0'
  
  #Push Notification
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    
    pod 'Fabric'
    pod 'Crashlytics'
    
  #Animation
    pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
    
  #Review
    pod 'AppRating', '>= 0.0.1'
    
  pod 'Cosmos', '~> 17.0'
  
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
