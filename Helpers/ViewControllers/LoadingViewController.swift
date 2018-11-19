import UIKit

class LoadingViewController: UIViewController {
    
    let viewModel: LoadingViewModel
    
    let imageView = with(UIImageView(image: UIImage())) {
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = TextLabel(styleGuideFontStyle: .title1, color: Style.Color.blue, text: "Loading", numberOfLines: 0, alignment: .center, fitToWidth: true, uppercased: false)
    
    init(viewModel: LoadingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = LoadingViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.Color.white
        
        view.addSubview(imageView)
        imageView.pinToEdgesOfSuperview(withOffset: Style.Padding.large)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.startLoadingDependencies()
    }
    
}
