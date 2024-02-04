# Uncomment the next line to define a global platform for your project
# platform :ios, '17.0'
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
            end
        end
    end
end


target 'SportsApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SportsApp
  pod 'NVActivityIndicatorView'
  pod 'Alamofire'
  pod 'Kingfisher', '~> 7.0'
  pod 'lottie-ios'


  target 'SportsAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SportsAppUITests' do
    # Pods for testing
  end

end
