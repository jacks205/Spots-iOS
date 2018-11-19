import Foundation

class LoadingViewModel {
        
    var timeoutTimer: Timer?
    let timeout = 10.0
    
    var hasInvalidatedTimeout: Bool {
        return timeoutTimer == nil
    }
    
    func startLoadingDependencies() {
        setupTimeoutTimer()
        defer {
            stopTimeoutTimer()
        }
        guard Session.current.isLoggedIn else {
            RootNavigator.shared.navigate(to: .login)
            return
        }
        
        RootNavigator.shared.navigate(to: .home)
    }
    
    private func setupTimeoutTimer() {
        timeoutTimer?.invalidate()
        timeoutTimer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false, block: { [weak self] (timer) in
            timer.invalidate()
            self?.timeoutTimer = nil
            DispatchQueue.main.async {
                guard Session.current.isLoggedIn else {
                    RootNavigator.shared.navigate(to: .login)
                    return
                }
                RootNavigator.shared.navigate(to: .home)
            }
        })
    }
    
    private func stopTimeoutTimer() {
        timeoutTimer?.invalidate()
    }
    
}
