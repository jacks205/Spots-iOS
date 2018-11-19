import UIKit

protocol URLOpener {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpener {
    //
}

protocol PermissionController {
    associatedtype PermissionContext: RawRepresentable
    typealias StringComponents = (title: String, body: String, cta: String)

    static var application: URLOpener { get }
    static var userDefaults: UserDefaults { get }
    static var userDefaultsKey: String { get }
    static var lastSavedContext: PermissionContext? { get }

    static func permissionController(for context: PermissionContext) -> UIViewController?
    static func stringComponents(for context: PermissionContext) -> StringComponents

    static func openSystemSettings(from context: PermissionContext)

    static func directToPermissionContext(from viewController: UIViewController, completion: (() -> Void)?)

    static func cleanup()
}

extension PermissionController {

    static var application: URLOpener {
        return UIApplication.shared
    }

    static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }

    static var hasSavedContext: Bool {
        return self.lastSavedContext != nil
    }

    static func openSystemSettings(from context: PermissionContext) {
        guard
            let url = URL(string: UIApplication.openSettingsURLString),
            application.canOpenURL(url) == true
        else {
            return
        }
        application.open(url, options: [:], completionHandler: nil)
    }
}

func cleanupPermissions() {
//    [].forEach { $0() }
}
