# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

def shared_pods
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'RxSwift'
    pod 'Moya-ObjectMapper/RxSwift', '1.2'
    pod 'RxCocoa', '2.3.1'
    pod 'RxDataSources'
    pod 'Kanna', '~> 1.0.0'
end

target 'Spots' do
    shared_pods
end

target 'SpotsTests' do

end

target 'SpotsToday' do
    shared_pods
end
