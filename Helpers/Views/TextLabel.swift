import UIKit

class TextLabel: UILabel {
    
    var links: [Link] = [] {
        didSet {
            self.setupLinks()
        }
    }
    private var linkRanges = [Link: NSRange]()
    private var linkGestureRecognizer: UITapGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required convenience init(styleGuideFontStyle fontStyle: Style.FontStyle, color: UIColor = Style.Color.white, text: String?, numberOfLines: Int = 0, alignment: NSTextAlignment = .left, fitToWidth: Bool = false, uppercased: Bool = false) {
        self.init(frame: CGRect.zero)
        
        self.font = Style.Font.preferredFont(withFontStyle: fontStyle)
        
        self.textColor = color
        
        if uppercased == true {
            self.text = text?.uppercased()
        } else {
            self.text = text
        }
        
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = fitToWidth
    }
    
    @objc
    private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.isEnabled == true else {
            return
        }
        
        if let link = self.detectedTappedLink(gestureRecognizer: gestureRecognizer) {
            link.action?(link.urlString)
        }
    }
    
    private func detectedTappedLink(gestureRecognizer: UITapGestureRecognizer) -> Link? {
        guard self.frame.contains(gestureRecognizer.location(in: self)) else {
            return nil
        }
        
        let tappedLinks = self.links.filter { (link) -> Bool in
            guard let range = self.linkRanges[link] else {
                return false
            }
            return gestureRecognizer.didTapAttributedTextInLabel(label: self, inRange: range)
        }
        
        return tappedLinks.first
    }
    
    private func setupLinks() {
        guard let text = self.text else {
            return
        }
        
        if self.linkGestureRecognizer == nil {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gestureRecognizer)
            self.linkGestureRecognizer = gestureRecognizer
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        
        self.links.forEach { (link) in
            let range = attributedString.mutableString.range(of: link.text)
            
            if range.location != NSNotFound {
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
                self.linkRanges[link] = range
            }
        }
        
        self.attributedText = attributedString
    }
    
}

struct Link: Hashable {
    
    let text: String
    let urlString: String
    let action: ((String) -> Void)?
    
    var hashValue: Int {
        return urlString.hashValue
    }
    
    init(text: String, urlString: String, action: ((String) -> Void)? = nil) {
        self.text = text
        self.urlString = urlString
        self.action = action
    }
    
    static func == (lhs: Link, rhs: Link) -> Bool {
        return lhs.text == rhs.text && lhs.urlString == rhs.urlString
    }
}
