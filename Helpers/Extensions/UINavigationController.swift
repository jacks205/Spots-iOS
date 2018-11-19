import UIKit

extension UINavigationController {
    
    @discardableResult
    func addCancelButton(target: Any?, action: Selector) -> UIBarButtonItem {
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: target, action: action)
        navigationItem.leftBarButtonItem = cancel
        return cancel
    }
}

extension UIViewController {
    @objc func pop() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func present(alert: UIAlertController) {
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            presenter.permittedArrowDirections = []
        }
        
        present(alert, animated: true, completion: nil)
    }
}
