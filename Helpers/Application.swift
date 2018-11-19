import Foundation

struct Application {
    
    enum Target: CustomStringConvertible {
        case dev
        case prod
        
        var description: String {
            switch self {
            case .dev:
                return ".dev"
            case .prod:
                return ""
            }
        }
    }
    
    static let appStoreUrl = ""
    static let appStoreId = ""
    
    private static let infoDictionary = Bundle.main.infoDictionary ?? [String: Any]()
    
    static let name = infoDictionary["CFBundleName"] as? String ?? ""
    
    static var versionNumber: String {
        let version = infoDictionary["CFBundleShortVersionString"] as? String ?? ""
        let build = infoDictionary["CFBundleVersion"] as? String ?? ""
        return "v\(version)(\(build))"
    }
    
    static var target: Target? {
        let bundleName = Bundle.main.bundleIdentifier?.lowercased()
        if bundleName?.contains("dev") == true {
            return .dev
        }
        return .prod
    }
    
    private static var environment: String {
        return "\(target?.description ?? "")"
    }
    
    static let versionLabel = Application.versionNumber + Application.environment
    
}
