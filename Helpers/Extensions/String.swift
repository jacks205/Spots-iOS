import Foundation

extension String {
    
    static func `for`(key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
    
}
