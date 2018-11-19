import UIKit

class Checkbox: UIControl {
    
    var isChecked: Bool = false
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.3
        }
    }
    
    private let imageView = with(UIImageView()) {
        $0.size(toWidth: Style.Size.control)
        $0.size(toHeight: Style.Size.control)
        $0.layer.cornerRadius = Style.Size.control / 2.0
        $0.layer.borderColor = Style.Color.mediumGray.cgColor
        $0.layer.borderWidth = 1.0
        $0.backgroundColor = Style.Color.lightGray
    }
    private let label = TextLabel(styleGuideFontStyle: .body, color: Style.Color.blue, text: nil, numberOfLines: 0, alignment: .left, fitToWidth: false, uppercased: false)
    
    var text: String? {
        didSet {
            self.label.text = text
            self.setupLinks()
        }
    }
    
    var links: [Link]? {
        didSet {
            self.setupLinks()
        }
    }
    private var linkRanges = [Link: NSRange]()
    
    init(text: String? = nil, links: [Link]? = nil) {
        super.init(frame: .zero)
        
        self.text = text
        self.links = links
        self.setupViews()
        self.setupLinks()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(self.imageView)
        self.imageView.pinToLeftEdgeOfSuperview()
        self.imageView.pinToTopEdgeOfSuperview()
        self.constrain(item: self.imageView, attribute: .bottom, toItem: self, attribute: .bottom, relatedBy: .lessThanOrEqual, multiplier: 1.0, offset: 0)
        
        self.addSubview(self.label)
        self.constrain(item: self.label, attribute: .top, toItem: self, attribute: .top, relatedBy: .greaterThanOrEqual, multiplier: 1.0, offset: 0, priority: .defaultLow)
        self.constrain(item: self.label, attribute: .bottom, toItem: self, attribute: .bottom, relatedBy: .lessThanOrEqual, multiplier: 1.0, offset: 0, priority: .defaultLow)
        self.label.positionToTheRight(of: self.imageView, withOffset: Style.Padding.medium)
        self.constrain(item: self.label, attribute: .right, toItem: self, attribute: .right, relatedBy: .lessThanOrEqual, multiplier: 1.0, offset: 0.0)
        label.centerVertically(to: imageView)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
        
        self.label.text = text
    }
    
    private func setupLinks() {
        guard let text = self.text, let links = links else {
            return
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        
        links.forEach { (link) in
            let range = attributedString.mutableString.range(of: link.text)
            
            if range.location != NSNotFound {
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
                self.linkRanges[link] = range
            }
        }
        
        self.label.attributedText = attributedString
    }
    
    @objc
    private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.isEnabled == true else {
            return
        }
        
        if let link = self.detectedTappedLink(gestureRecognizer: gestureRecognizer) {
            link.action?(link.urlString)
        } else {
            self.isChecked = !self.isChecked
            self.imageView.backgroundColor = self.isChecked == true ? Style.Color.blue : Style.Color.lightGray
        }
    }
    
    private func detectedTappedLink(gestureRecognizer: UITapGestureRecognizer) -> Link? {
        guard let links = self.links, self.label.frame.contains(gestureRecognizer.location(in: self)) else {
            return nil
        }
        
        let tappedLinks = links.filter { (link) -> Bool in
            guard let range = self.linkRanges[link] else {
                return false
            }
            return gestureRecognizer.didTapAttributedTextInLabel(label: self.label, inRange: range)
        }
        
        return tappedLinks.first
    }
    
}
