import Foundation

class Session {
    
    private let userDefaults: UserDefaults
    
    static let current = Session()
        
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var isLoggedIn: Bool {
        return false
    }
}

extension Session {
    
    func logout() {
        //
        RootNavigator.shared.navigate(to: .login)
    }
    
}
