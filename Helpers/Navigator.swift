import UIKit

protocol Navigator {
    func navigate(to viewController: UIViewController)
}

class RootNavigator: Navigator {
    
    weak var navigationController: UINavigationController?
    
    static let shared = RootNavigator()
    
    func navigate(to viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RootNavigator {
    
    enum Destination {
        case login
        case registration
        case home
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .login:
            let vc = UIViewController()
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.viewControllers = [vc]
        case .registration:
            let vc = UIViewController()
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.viewControllers = [vc]
        case .home:
            let tab = UITabBarController()
            tab.viewControllers = [UIViewController()]
            navigationController?.viewControllers = [tab]
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func pop() {
        guard
            let endIndex = navigationController?.viewControllers.endIndex,
            let popViewController = navigationController?.viewControllers[endIndex - 2] else {
            return
        }
        
        switch popViewController {
        default:
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension RootNavigator {
    
    func present(_ viewController: UIViewController, inNavigationController presentInNavigationController: Bool = false) {
        let vcToPresent: UIViewController
        if presentInNavigationController {
            let navVC = UINavigationController(rootViewController: viewController)
            navVC.addCancelButton(target: navVC, action: #selector(navVC.pop))
            vcToPresent = navVC
        } else {
            vcToPresent = viewController
        }
        self.navigationController?.present(vcToPresent, animated: true, completion: nil)
    }
    
}
