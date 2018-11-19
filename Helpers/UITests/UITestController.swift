import Foundation

class UITestController {

    static var isUITesting: Bool {
        return self.shared.process.arguments.contains("UI_TEST_MODE") == true
    }
    static let shared = UITestController()

    var process = ProcessInfo.processInfo
    lazy var arguments: [Arguments] = Arguments.from(process: self.process)
    var environmentVariables: [String: String] {
        return self.process.environment
    }

    var destination: URL? {
        guard
            let dest = self.environmentVariables[EnvKeys.deepLink],
            let url = URL(string: dest)
        else {
            return nil
        }
        // let deepLink = DeepLink(url: url, originalUrl: url, sourceApplication: nil, annotation: nil)
        // return deepLink
        return url
    }

    // MARK: - Actions

    func evaluateArguments() {
        self.arguments.forEach {
            switch $0 {
            case .resetKeychain:
                break
            case .noFakeNetwork:
                break
            }
        }
    }
}

extension UITestController {

    enum Arguments: String {
        case resetKeychain = "UI_TEST_RESET_KEYCHAIN"
        case noFakeNetwork = "UI_TEST_NO_FAKE_NETWORK"

        static func from(process: ProcessInfo) -> [Arguments] {
            return process.arguments.compactMap(Arguments.init)
        }
    }

    typealias EnvKeys = EnvironmentVariableKeys
    struct EnvironmentVariableKeys {
        static let deepLink = "UI_TEST_DEST"
        static let user = "UI_TEST_USER"
    }
}