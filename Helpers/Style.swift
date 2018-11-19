import UIKit

struct Style {
    
    struct Color {
        static let blue = UIColor.blue
        static let error = UIColor.red
        static let lightGray = UIColor.lightGray
        static let mediumGray = UIColor.gray
        static let warning = UIColor.yellow
        static let white = UIColor.white
    }
    
    enum FontStyle: String {
        
        /// JosefinSans-Bold, 22pt
        case title1
        /// JosefinSans-Light, 22pt
        case title2
        /// JosefinSans-Bold, 14pt
        case headline
        /// JosefinSans-Light, 12pt
        case subhead
        /// Poppins-Light, 14pt
        case body
        /// Poppins-Light, 12pt
        case caption1
        /// Poppins-Thin, 12pt
        case footnote
        
    }
    
    struct Font {
        static let contentSize = UIApplication.shared.preferredContentSizeCategory
        
        static let fontNameTable = [
            FontStyle.title1: "JosefinSans-Bold",
            FontStyle.title2: "JosefinSans-Light",
            FontStyle.headline: "JosefinSans-Bold",
            FontStyle.subhead: "JosefinSans-Light",
            FontStyle.body: "Poppins-Light",
            FontStyle.caption1: "Poppins-Light",
            FontStyle.footnote: "Poppins-Thin",
            ]

        
        static let fontSizeTable = [
            FontStyle.title1: [
                UIContentSizeCategory.accessibilityExtraExtraExtraLarge: 33,
                UIContentSizeCategory.accessibilityExtraExtraLarge: 32,
                UIContentSizeCategory.accessibilityExtraLarge: 31,
                UIContentSizeCategory.accessibilityLarge: 30,
                UIContentSizeCategory.accessibilityMedium: 29,
                UIContentSizeCategory.extraExtraExtraLarge: 28,
                UIContentSizeCategory.extraExtraLarge: 26,
                UIContentSizeCategory.extraLarge: 26,
                UIContentSizeCategory.large: 24,
                UIContentSizeCategory.medium: 24,
                UIContentSizeCategory.small: 24,
                UIContentSizeCategory.extraSmall: 24,
            ],
            FontStyle.title2: [
                UIContentSizeCategory.accessibilityExtraExtraExtraLarge: 33,
                UIContentSizeCategory.accessibilityExtraExtraLarge: 32,
                UIContentSizeCategory.accessibilityExtraLarge: 31,
                UIContentSizeCategory.accessibilityLarge: 30,
                UIContentSizeCategory.accessibilityMedium: 29,
                UIContentSizeCategory.extraExtraExtraLarge: 28,
                UIContentSizeCategory.extraExtraLarge: 28,
                UIContentSizeCategory.extraLarge: 26,
                UIContentSizeCategory.large: 24,
                UIContentSizeCategory.medium: 24,
                UIContentSizeCategory.small: 24,
                UIContentSizeCategory.extraSmall: 24,
            ],
            FontStyle.headline: [
                UIContentSizeCategory.accessibilityExtraExtraExtraLarge: 25,
                UIContentSizeCategory.accessibilityExtraExtraLarge: 24,
                UIContentSizeCategory.accessibilityExtraLarge: 23,
                UIContentSizeCategory.accessibilityLarge: 22,
                UIContentSizeCategory.accessibilityMedium: 21,
                UIContentSizeCategory.extraExtraExtraLarge: 20,
                UIContentSizeCategory.extraExtraLarge: 20,
                UIContentSizeCategory.extraLarge: 18,
                UIContentSizeCategory.large: 16,
                UIContentSizeCategory.medium: 16,
                UIContentSizeCategory.small: 16,
                UIContentSizeCategory.extraSmall: 16,
            ],
            FontStyle.subhead: [
                UIContentSizeCategory.accessibilityExtraExtraExtraLarge: 23,
                UIContentSizeCategory.accessibilityExtraExtraLarge: 22,
                UIContentSizeCategory.accessibilityExtraLarge: 21,
                UIContentSizeCategory.accessibilityLarge: 20,
                UIContentSizeCategory.accessibilityMedium: 19,
                UIContentSizeCategory.extraExtraExtraLarge: 18,
                UIContentSizeCategory.extraExtraLarge: 18,
                UIContentSizeCategory.extraLarge: 14,
                UIContentSizeCategory.large: 14,
                UIContentSizeCategory.medium: 14,
                UIContentSizeCategory.small: 14,
                UIContentSizeCategory.extraSmall: 14,
            ],
            FontStyle.body: [
                UIContentSizeCategory.accessibilityExtraExtraExtraLarge: 25,
                UIContentSizeCategory.accessibilityExtraExtraLarge: 24,
                UIContentSizeCategory.accessibilityExtraLarge: 23,
                UIContentSizeCategory.accessibilityLarge: 22,
                UIContentSizeCategory.accessibilityMedium: 21,
                UIContentSizeCategory.extraExtraExtraLarge: 20,
                UIContentSizeCategory.extraExtraLarge: 20,
                UIContentSizeCategory.extraLarge: 18,
                UIContentSizeCategory.large: 16,
                UIContentSizeCategory.medium: 16,
                UIContentSizeCategory.small: 16,
                UIContentSizeCategory.extraSmall: 16,
            ],
            FontStyle.caption1: [
                UIContentSizeCategory.accessibilityExtraExtraExtraLarge: 23,
                UIContentSizeCategory.accessibilityExtraExtraLarge: 22,
                UIContentSizeCategory.accessibilityExtraLarge: 21,
                UIContentSizeCategory.accessibilityLarge: 20,
                UIContentSizeCategory.accessibilityMedium: 19,
                UIContentSizeCategory.extraExtraExtraLarge: 18,
                UIContentSizeCategory.extraExtraLarge: 18,
                UIContentSizeCategory.extraLarge: 16,
                UIContentSizeCategory.large: 14,
                UIContentSizeCategory.medium: 14,
                UIContentSizeCategory.small: 14,
                UIContentSizeCategory.extraSmall: 14,
            ],
            FontStyle.footnote: [
                UIContentSizeCategory.accessibilityExtraExtraExtraLarge: 23,
                UIContentSizeCategory.accessibilityExtraExtraLarge: 22,
                UIContentSizeCategory.accessibilityExtraLarge: 21,
                UIContentSizeCategory.accessibilityLarge: 20,
                UIContentSizeCategory.accessibilityMedium: 19,
                UIContentSizeCategory.extraExtraExtraLarge: 18,
                UIContentSizeCategory.extraExtraLarge: 18,
                UIContentSizeCategory.extraLarge: 16,
                UIContentSizeCategory.large: 14,
                UIContentSizeCategory.medium: 14,
                UIContentSizeCategory.small: 14,
                UIContentSizeCategory.extraSmall: 14,
            ],
            ]
        
        static func preferredFont(withFontStyle fontStyle: FontStyle) -> UIFont {
            if let fontContentSizesForFontStyle = Font.fontSizeTable[fontStyle],
                let fontSize = fontContentSizesForFontStyle[Font.contentSize],
                let fontName = Font.fontNameTable[fontStyle],
                let font = UIFont(name: fontName, size: CGFloat(fontSize)) {
                return font
            }
            
            if let fontContentSizesForFontStyle = Font.fontSizeTable[.body],
                let fontSize = fontContentSizesForFontStyle[.medium],
                let fontName = Font.fontNameTable[.body],
                let font = UIFont(name: fontName, size: CGFloat(fontSize)) {
                return font
            }
            
            assert(false, "critical failure to find font")
            
            return UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }        
    }
    
    struct Padding {
        /// 10.0
        static let small: CGFloat = 10.0
        /// 20.0
        static let medium: CGFloat = 20.0
        /// 40.0
        static let large: CGFloat = 40.0
    }
    
    struct Size {
        /// 44.0
        static let control: CGFloat = 44.0
        /// 50.0
        static let largeControl: CGFloat = 50.0
        /// 60.0
        static let veryLargeControl: CGFloat = 60.0
        /// 64.0
        static let largeButton: CGFloat = 64.0
        /// 100.0
        static let veryLargeButton: CGFloat = 100.0
    }
    
}

extension Style {
    
    enum BaseButtonStyle {
        case solid
        case outline
        case flat
    }
    
    enum BaseButtonType {
        case primary
        case secondary
        case error
    }
    
    class Button: UIButton {
        private var type = BaseButtonType.primary
        private var style = BaseButtonStyle.solid
        
        var id: String?
        
        internal override var isEnabled: Bool {
            get {
                return true
            }
            set(newValue) {
                if newValue == false {
                    self.isEnabled = true
                }
            }
        }
        
        internal var isNotDisabled: Bool = true {
            didSet {
                (self.isNotDisabled == true) ? self.enableButton() : self.disableButton()
            }
        }
        
        // MARK: View Lifecycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        convenience init(type: BaseButtonType, style: BaseButtonStyle) {
            self.init(frame: CGRect.zero)
            
            self.type = type
            self.style = style
            
            self.isNotDisabled = true
            self.enableButton()
            
            self.setup()
        }
        
        // MARK: Helper Methods
        
        private func setup() {
            self.titleLabel?.font = Style.Font.preferredFont(withFontStyle: .headline)
            self.contentEdgeInsets = UIEdgeInsets.init(top: 0.0, left: Style.Padding.medium, bottom: 0.0, right: Style.Padding.medium)
        }
        
        private func enableButton() {
            switch self.style {
            case .solid:
                self.backgroundColor = self.enabledTintColorForType(self.type, style: self.style)
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0.0
                self.setTitleColor(self.enabledTextColorForType(self.type, style: self.style), for: .normal)
            case .outline:
                self.backgroundColor = .clear
                self.layer.borderColor = self.enabledTextColorForType(self.type, style: self.style).cgColor
                self.layer.borderWidth = 1.0
                self.setTitleColor(self.enabledTextColorForType(self.type, style: self.style), for: .normal)
            case .flat:
                self.backgroundColor = .clear
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0.0
                self.setTitleColor(self.enabledTextColorForType(self.type, style: self.style), for: .normal)
            }
        }
        
        private func disableButton() {
            switch self.style {
            case .solid:
                self.backgroundColor = self.disabledTintColorForType(self.type)
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0.0
                self.setTitleColor(self.disabledTextColorForType(self.type, style: self.style), for: .normal)
            case .outline:
                self.backgroundColor = .clear
                self.layer.borderColor = self.disabledTintColorForType(self.type).cgColor
                self.layer.borderWidth = 1.0
                self.setTitleColor(self.disabledTextColorForType(self.type, style: self.style), for: .normal)
            case .flat:
                self.backgroundColor = .clear
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0.0
                self.setTitleColor(self.disabledTextColorForType(self.type, style: self.style), for: .normal)
            }
        }
        
        private func enabledTextColorForType(_ type: BaseButtonType, style: BaseButtonStyle) -> UIColor {
            switch (type, style) {
            case (.primary, .solid):
                return Style.Color.white
            case (.secondary, .solid):
                return Style.Color.blue
            case (.primary, .outline):
                return Style.Color.blue
            case (.secondary, .outline):
                return Style.Color.blue
            case (.primary, .flat):
                return Style.Color.blue
            case (.secondary, .flat):
                return Style.Color.mediumGray
            case (.error, _):
                return Style.Color.error
            }
        }
        
        private func disabledTextColorForType(_ type: BaseButtonType, style: BaseButtonStyle) -> UIColor {
            switch (type, style) {
            case (_, .solid):
                return Style.Color.lightGray
            default:
                return Style.Color.lightGray
            }
            
        }
        
        private func enabledTintColorForType(_ type: BaseButtonType, style: BaseButtonStyle) -> UIColor {
            switch (type, style) {
            case (.primary, _):
                return Style.Color.blue
            case (.secondary, .solid):
                return Style.Color.blue
            case (.secondary, _):
                return Style.Color.blue
            case (.error, _):
                return Style.Color.error
            }
        }
        
        private func disabledTintColorForType(_ type: BaseButtonType) -> UIColor {
            switch type {
            case .primary:
                return Style.Color.lightGray
            case .secondary:
                return Style.Color.mediumGray
            case .error:
                return Style.Color.mediumGray
            }
        }
    }
    
    class SolidButton: Button {
        
        class func primary() -> Button {
            return Button(type: .primary, style: .solid)
        }
        
        class func secondary() -> Button {
            return Button(type: .secondary, style: .solid)
        }
        
    }
    
    class OutlineButton: Button {
        
        class func primary() -> Button {
            return Button(type: .primary, style: .outline)
        }
        
        class func secondary() -> Button {
            return Button(type: .secondary, style: .outline)
        }
        
    }
    
    class FlatButton: Button {
        
        class func primary() -> Button {
            return Button(type: .primary, style: .flat)
        }
        
        class func secondary() -> Button {
            return Button(type: .secondary, style: .flat)
        }
        
        class func error() -> Button {
            return Button(type: .error, style: .flat)
        }
        
    }
    
}

extension Style {
    
    static func setupAppearances() {
        let barItem = UIBarButtonItem.appearance()
        barItem.tintColor = Style.Color.white
        barItem.setTitleTextAttributes([.foregroundColor: Style.Color.white, .font: Style.Font.preferredFont(withFontStyle: .footnote)], for: .normal)
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = Style.Color.blue
        navigationBar.barTintColor = Style.Color.blue
        navigationBar.backgroundColor = Style.Color.blue
        navigationBar.titleTextAttributes = [.foregroundColor: Style.Color.white, .font: Style.Font.preferredFont(withFontStyle: .title2)]
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = Style.Color.white
        tabBar.barTintColor = Style.Color.blue
        tabBar.unselectedItemTintColor = Style.Color.mediumGray
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = false
        
        let tabBarItem = UITabBarItem.appearance()
        tabBarItem.setTitleTextAttributes([.font: Style.Font.preferredFont(withFontStyle: .caption1)], for: .normal)
    }
    
}

extension Style {
    
    enum ShadowStyle {
        /// Radius - 6, Opacity - 0.15, Offset - (0,6)
        case largeImageShadow
        /// Radius - 1, Opacity - 0.15, Offset - (0,1)
        case containerShadow
        /// Radius - 16, Opacity - 0.20, Offset - (0,0)
        case alertShadow
        /// Radius - 2, Opacity - 0.01, Offset - (0,1)
        case dividerShadow
    }
    
}

extension Style {
    
    enum BaseBannerStyle {
        case general
        case warning
        case error
    }
    
    class Banner: BannerView {
        class func primary(title: String, subtitle: String) -> BannerView {
            return BannerView(titleConfig: TitleConfig(text: title, color: Style.Color.white, font: .title2), subtitleConfig: TitleConfig(text: subtitle, color: Style.Color.lightGray, font: .subhead), backgroundColor: Style.Color.blue)
        }
        
        class func connected() -> BannerView {
            return primary(title: String.for(key: "banner.general.device_connected.title"), subtitle: String.for(key: "banner.general.device_connected.body"))
        }
        
        class func treatmentFinished(title: String, subtitle: String) -> BannerView {
            return primary(title: title, subtitle: subtitle)
        }
    }
    
    class WarningBanner: BannerView {
        class func primary(title: String, subtitle: String) -> BannerView {
            return BannerView(titleConfig: TitleConfig(text: title, color: Style.Color.blue, font: .title2), subtitleConfig: TitleConfig(text: subtitle, color: Style.Color.blue, font: .subhead), backgroundColor: Style.Color.warning)
        }
        
        class func bluetoothDisabled() -> BannerView {
            return primary(title: String.for(key: "banner.warning.bluetooth_disabled.title"), subtitle: String.for(key: "banner.warning.bluetooth_disabled.body"))
        }
    }
    
    class ErrorBanner: BannerView {
        class func primary(title: String, subtitle: String) -> BannerView {
            return BannerView(titleConfig: TitleConfig(text: title, color: Style.Color.white, font: .title2), subtitleConfig: TitleConfig(text: subtitle, color: Style.Color.lightGray, font: .subhead), backgroundColor: Style.Color.error)
        }
        
        class func disconnected() -> BannerView {
            return primary(title: String.for(key: "banner.error.device_disconnected.title"), subtitle: String.for(key: "banner.error.device_disconnected.body"))
        }
    }
    
    class BannerView: UIView {
        
        func attachToTopView(for interval: TimeInterval = 0.0) {
            if let controller = UIApplication.shared.keyWindow?.rootViewController {
                attach(to: controller.view, for: interval)
            }
        }
        
        func attach(to view: UIView, for interval: TimeInterval) {
            DispatchQueue.main.async { [weak self, weak view] in
                guard self?.superview == nil, let sSelf = self else {
                    return
                }
                view?.addSubview(sSelf)
                sSelf.pinToTopEdgeOfSafeArea()
                sSelf.pinToSideEdgesOfSuperview()
                view?.setNeedsLayout()
                view?.layoutIfNeeded()
                
                let statusBar = view?.safeAreaInsets.top ?? 0.0
                
                sSelf.transform = sSelf.transform.translatedBy(x: 0, y: -statusBar - sSelf.bounds.height)
                
                DispatchQueue.main.async { [weak self] in
                    UIView.animate(withDuration: 0.3) {
                        self?.transform = .identity
                    }
                }
                
                if interval > 0.0 {
                    sSelf.startTimer(for: interval)
                }
            }
        }
        
        func remove() {
            guard superview != nil else {
                return
            }
            let statusBar = superview?.safeAreaInsets.top ?? 0.0
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = self.transform.translatedBy(x: 0, y: -statusBar - self.bounds.height)
            }) { _ in
                self.removeFromSuperview()
            }
        }
        
        class func remove(from view: UIView) {
            let views = view.subviews.filter { type(of: $0).isEqual(BannerView.self) }
            views.forEach { $0.removeFromSuperview() }
        }
        
        struct TitleConfig {
            let text: String
            let color: UIColor
            let font: Style.FontStyle
        }
        
        struct ButtonConfig {
            let text: String?
            let image: UIImage?
            let font: UIFont?
        }
        
        let titleLabel: TextLabel
        let subtitleLabel: TextLabel
        
        var timer: Timer?
        var onTap: (() -> Void)?
        
        init(titleConfig: TitleConfig, subtitleConfig: TitleConfig, backgroundColor: UIColor) {
            titleLabel = TextLabel(styleGuideFontStyle: titleConfig.font, color: titleConfig.color, text: titleConfig.text, numberOfLines: 0, alignment: .center, fitToWidth: true, uppercased: false)
            subtitleLabel = TextLabel(styleGuideFontStyle: subtitleConfig.font, color: subtitleConfig.color, text: subtitleConfig.text, numberOfLines: 0, alignment: .center, fitToWidth: true, uppercased: false)
            super.init(frame: .zero)
            self.backgroundColor = backgroundColor
            setupViews()
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
            addGestureRecognizer(tap)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupViews() {
            addSubview(titleLabel)
            addSubview(subtitleLabel)
            
            titleLabel.pinToSideEdgesOfSuperview(withOffset: Style.Padding.small)
            titleLabel.pinToTopEdgeOfSuperview(withOffset: Style.Padding.small)
            subtitleLabel.positionBelow(titleLabel)
            subtitleLabel.pinToSideEdgesOfSuperview(withOffset: Style.Padding.medium)
            subtitleLabel.pinToBottomEdgeOfSuperview(withOffset: Style.Padding.small)
        }
        
        func startTimer(for interval: TimeInterval) {
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { [weak self] (timer) in
                timer.invalidate()
                self?.remove()
            })
        }
        
        @objc func onTap(_ gesture: UIGestureRecognizer) {
            DispatchQueue.main.async { [weak self] in
                debug(items: "Tap")
                self?.onTap?()
                if self?.timer != nil {
                    self?.timer?.invalidate()
                    self?.remove()
                }
            }
            
        }
    }

    
}

extension UIView {
    
    func applyShadow(with style: Style.ShadowStyle) {
        let radius: CGFloat
        let offset: CGSize
        let opacity: Float
        
        switch style {
        case .containerShadow:
            radius = 1.0
            opacity = 0.13
            offset = CGSize(width: 0.0, height: radius)
        case .largeImageShadow:
            radius = 6.0
            opacity = 0.15
            offset = CGSize(width: 0.0, height: radius)
        case .alertShadow:
            radius = 16.0
            opacity = 0.2
            offset = .zero
        case .dividerShadow:
            radius = 2
            opacity = 0.01
            offset = CGSize(width: 0.0, height: 1.0)
        }
        
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }
    
    func removeShadow() {
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
}
