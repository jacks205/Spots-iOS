import UIKit

class BaseViewController: UIViewController {
    
    var activityController: SpinnerViewController?
    
    var backgroundColor: UIColor? {
        get {
            return view.backgroundColor
        }
        set {
            view.backgroundColor = newValue
        }
    }
    
    let scrollView = with(UIScrollView()) {
        $0.backgroundColor = Style.Color.white
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.indicatorStyle = .black
        $0.bounces = false
    }
    
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = Style.Color.white
        view.addSubview(scrollView)
        scrollView.pinToTopEdgeOfSafeArea()
        scrollView.pinToSideEdgesOfSuperview()
        scrollView.pinToBottomEdgeOfSafeArea()
        
        scrollView.addSubview(contentView)
        contentView.pinToEdgesOfSuperview()
        contentView.size(toWidth: UIScreen.main.bounds.width)
    }
    
    func addContentSubview(_ view: UIView) {
        contentView.addSubview(view)
    }
}

extension BaseViewController {
    func showLoading() {
        let activityController = SpinnerViewController()
        defer {
            self.activityController = activityController
        }
        addChild(activityController)
        activityController.view.frame = view.frame
        view.addSubview(activityController.view)
        activityController.didMove(toParent: self)
    }
    
    func hideLoading() {
        activityController?.willMove(toParent: nil)
        activityController?.view.removeFromSuperview()
        activityController?.removeFromParent()
    }
}

class SpinnerViewController: UIViewController {
    lazy var activityIndicator = with(UIActivityIndicatorView(style: .whiteLarge)) {
        view.addSubview($0)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        activityIndicator.centerInSuperview()
    }
}
