# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SpoonTV' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SpoonTV
 
    pod 'RxSwift', '~> 5'
    pod 'RxCocoa', '~> 5'

    # Clean Architecture
    pod 'MGArchitecture'
    pod 'MGAPIService'
    pod 'MGLoadMore'
    
    # Core
    pod 'ObjectMapper'
    pod 'Reusable'
    pod 'Then'
    pod 'MJRefresh'
    pod 'OrderedSet'
    pod 'Validator'
    
    # Rx
    pod 'NSObject+Rx'
    pod 'RxDataSources'
    
    # Core Data
    pod 'MagicalRecord'
    
    #
    pod 'MBProgressHUD'
    pod 'SDWebImage'
    pod 'SwiftLint'
    
    post_install do |pi|
        pi.pods_project.targets.each do |t|
          t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
          end
        end
    end
end
