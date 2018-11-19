import UIKit

protocol LayoutItem {}
extension UIView: LayoutItem {}
@available(iOS 9.0, *)
extension UILayoutGuide: LayoutItem {}

extension UIView {
    
    @discardableResult func pinToEdgesOfSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> (top: NSLayoutConstraint?, right: NSLayoutConstraint?, bottom: NSLayoutConstraint?, left: NSLayoutConstraint?) {
        return (
            self.pinToTopEdgeOfSuperview(withOffset: offset, priority: priority),
            self.pinToRightEdgeOfSuperview(withOffset: offset, priority: priority),
            self.pinToBottomEdgeOfSuperview(withOffset: offset, priority: priority),
            self.pinToLeftEdgeOfSuperview(withOffset: offset, priority: priority)
        )
    }
    
    @discardableResult func pinToTopEdgeOfSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(edgeAttribute: .top, offset: offset, priority: priority)
    }
    
    @discardableResult func pinToRightEdgeOfSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(edgeAttribute: .right, offset: -offset, priority: priority)
    }
    
    
    @discardableResult func pinToBottomEdgeOfSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(edgeAttribute: .bottom, offset: -offset, priority: priority)
    }
    
    @discardableResult func pinToLeftEdgeOfSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(edgeAttribute: .left, offset: offset, priority: priority)
    }
    
    @discardableResult func pinToSideEdgesOfSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> (left: NSLayoutConstraint?, right: NSLayoutConstraint?) {
        return (
            self.pinToLeftEdgeOfSuperview(withOffset: offset, priority: priority),
            self.pinToRightEdgeOfSuperview(withOffset: offset, priority: priority)
        )
    }
    
    @discardableResult func pinToTopAndBottomEdgesOfSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> (top: NSLayoutConstraint?, bottom: NSLayoutConstraint?) {
        return (
            self.pinToTopEdgeOfSuperview(withOffset: offset, priority: priority),
            self.pinToBottomEdgeOfSuperview(withOffset: offset, priority: priority)
        )
    }
    
}

// MARK: - Pin: Edges
extension UIView {
    
    @discardableResult func pinTopEdgeToTopEdge(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .top, toAttribute: .top, ofItem: item, offset: offset, priority: priority)
    }
    
    @discardableResult func pinRightEdgeToRightEdge(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .right, toAttribute: .right, ofItem: item, offset: -offset, priority: priority)
    }
    
    @discardableResult func pinBottomEdgeToBottomEdge(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .bottom, toAttribute: .bottom, ofItem: item, offset: -offset, priority: priority)
    }
    
    @discardableResult func pinLeftEdgeToLeftEdge(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .left, toAttribute: .left, ofItem: item, offset: offset, priority: priority)
    }
    
}

// MARK: - Center
extension UIView {
    
    @discardableResult func centerInSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> (horizontal: NSLayoutConstraint?, vertical: NSLayoutConstraint?){
        return (
            self.centerHorizontallyInSuperview(withOffset: offset, priority: priority),
            self.centerVerticallyInSuperview(withOffset: offset, priority: priority)
        )
    }
    
    @discardableResult func centerHorizontallyInSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(edgeAttribute: .centerX, offset: offset, priority: priority)
    }
    
    @discardableResult func centerVerticallyInSuperview(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(edgeAttribute: .centerY, offset: offset, priority: priority)
    }
    
    @discardableResult func centerHorizontally(to item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .centerX, toAttribute: .centerX, ofItem: item, offset: offset, priority: priority)
    }
    
    @discardableResult func centerVertically(to item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .centerY, toAttribute: .centerY, ofItem: item, offset: offset, priority: priority)
    }
    
}

// MARK: - Size
extension UIView {
    
    @discardableResult func size(toWidth width: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        return self.constrain(sizeAttribute: .width, size: width, priority: priority)
    }
    
    @discardableResult func size(toMinWidth width: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        return self.constrain(sizeAttribute: .width, size: width, relatedBy: .greaterThanOrEqual, priority: priority)
    }
    
    @discardableResult func size(toMaxWidth width: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        return self.constrain(sizeAttribute: .width, size: width, relatedBy: .lessThanOrEqual, priority: priority)
    }
    
    @discardableResult func size(toHeight height: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        return self.constrain(sizeAttribute: .height, size: height, priority: priority)
    }
    
    @discardableResult func size(toMinHeight height: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        return self.constrain(sizeAttribute: .height, size: height, relatedBy: .greaterThanOrEqual, priority: priority)
    }
    
    @discardableResult func size(toMaxHeight height: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        return self.constrain(sizeAttribute: .height, size: height, relatedBy: .lessThanOrEqual, priority: priority)
    }
    
    @discardableResult func size(toWidthAndHeight size: CGFloat, priority: UILayoutPriority? = nil) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        return (
            self.size(toWidth: size, priority: priority),
            self.size(toHeight: size, priority: priority)
        )
    }
    
    @discardableResult func size(toMinWidthAndHeight size: CGFloat, priority: UILayoutPriority? = nil) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        return (
            self.size(toMinWidth: size, priority: priority),
            self.size(toMinHeight: size, priority: priority)
        )
    }
    
    @discardableResult func size(toMaxWidthAndHeight size: CGFloat, priority: UILayoutPriority? = nil) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        return (
            self.size(toMaxWidth: size, priority: priority),
            self.size(toMaxHeight: size, priority: priority)
        )
    }
    
    @discardableResult func sizeWidthToWidth(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .width, toAttribute: .width, ofItem: item, offset: -offset, priority: priority)
    }
    
    @discardableResult func sizeHeightToHeight(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .height, toAttribute: .height, ofItem: item, offset: -offset, priority: priority)
    }
    
    @discardableResult func sizeHeightToWidth(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .height, toAttribute: .width, ofItem:item, offset: -offset, priority: priority)
    }
    
    @discardableResult func sizeWidthToHeight(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .width, toAttribute: .height, ofItem:item, offset: -offset, priority: priority)
    }
    
    @discardableResult func sizeWidthAndHeightToWidthAndHeight(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> (width: NSLayoutConstraint?, height: NSLayoutConstraint?) {
        return (
            self.sizeWidthToWidth(of: item, withOffset: offset, priority: priority),
            self.sizeHeightToHeight(of: item, withOffset: offset, priority: priority)
        )
    }
    
    @discardableResult func sizeHeightToWidth(withAspectRatio aspectRatio: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .height, toAttribute: .width, ofItem: self, multiplier: aspectRatio, priority: priority)
    }
    
    @discardableResult func sizeWidthToHeight(withAspectRatio aspectRatio: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .width, toAttribute: .height, ofItem: self, multiplier: aspectRatio, priority: priority)
    }
    
}

// MARK: - Position
extension UIView {
    
    @discardableResult func positionAbove(_ item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .bottom, toAttribute: .top, ofItem: item, offset: -offset, priority: priority)
    }
    
    @discardableResult func positionToTheRight(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .left, toAttribute: .right, ofItem: item, offset: offset, priority: priority)
    }
    
    @discardableResult func positionBelow(_ item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .top, toAttribute: .bottom, ofItem: item, offset: offset, priority: priority)
    }
    
    
    @discardableResult func positionToTheLeft(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        return self.constrain(attribute: .right, toAttribute: .left, ofItem: item, offset: -offset, priority: priority)
    }
    
}

// MARK: - Between
extension UIView {
    
    @discardableResult func fitBetween(top topItem: LayoutItem, andBottom bottomItem: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> (top: NSLayoutConstraint?, bottom: NSLayoutConstraint?){
        return (
            self.positionBelow(topItem, withOffset: offset, priority: priority),
            self.positionAbove( bottomItem, withOffset: offset, priority: priority)
        )
    }
    
    @discardableResult func fitBetween(left leftItem: LayoutItem, andRight rightItem: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> (left: NSLayoutConstraint?, right: NSLayoutConstraint?){
        return (
            self.positionToTheRight(of: leftItem, withOffset: offset, priority: priority),
            self.positionToTheLeft(of: rightItem, withOffset: offset, priority: priority)
        )
    }
    
}

// MARK: - Fill
extension UIView {
    
    func fillHorizontally(withViews views: [UIView], separation: CGFloat = 0, priority: UILayoutPriority? = nil) {
        assert(views.count > 0, "Can only distribute 1 or more views")
        
        if views.count == 1 {
            _ = views.first?.pinToSideEdgesOfSuperview(withOffset: separation, priority: priority)
            return
        }
        
        var lastView: UIView!
        for view in views {
            if lastView != nil{
                _ = lastView.sizeWidthToWidth(of: view)
                _ = view.positionToTheRight(of: lastView, withOffset: separation, priority: priority)
            } else {
                _ = view.pinToLeftEdgeOfSuperview(withOffset: separation, priority: priority)
            }
            lastView = view
        }
        
        _ = lastView?.pinToRightEdgeOfSuperview(withOffset: separation, priority: priority)
    }
    
    func fillVertically(withViews views: [UIView], separation: CGFloat = 0, priority: UILayoutPriority? = nil) {
        assert(views.count > 0, "Can only distribute 1 or more views")
        
        if views.count == 1 {
            _ = views.first?.pinToTopAndBottomEdgesOfSuperview(withOffset: separation, priority: priority)
            return
        }
        
        var lastView: UIView!
        for view in views {
            if lastView != nil{
                _ = lastView.sizeHeightToHeight(of: view)
                _ = view.positionBelow(lastView, withOffset: separation, priority: priority)
            } else {
                _ = view.pinToTopEdgeOfSuperview(withOffset: separation, priority: priority)
            }
            lastView = view
        }
        
        _ = lastView?.pinToBottomEdgeOfSuperview(withOffset: separation, priority: priority)
    }
    
}

// MARK: - Bound
extension UIView {
    
    func boundHorizontally(withViews views: [UIView], separation: CGFloat = 0, priority: UILayoutPriority? = nil) {
        assert(views.count > 0, "Can only distribute 1 or more views")
        
        if views.count > 1 {
            var lastView: UIView!
            for view in views {
                if lastView != nil{
                    _ = view.positionToTheRight(of: lastView, withOffset: separation, priority: priority)
                }
                lastView = view
            }
        }
        
        _ = self.pinLeftEdgeToLeftEdge(of: views.first!, withOffset: -separation, priority: priority)
        _ = self.pinRightEdgeToRightEdge(of: views.last!, withOffset: -separation, priority: priority)
    }
    
    func boundVertically(withViews views: [UIView], separation: CGFloat = 0, priority: UILayoutPriority? = nil) {
        assert(views.count > 0, "Can only distribute 1 or more views")
        
        if views.count > 1 {
            var lastView: UIView!
            for view in views {
                if lastView != nil {
                    _ = view.positionBelow(lastView, withOffset: separation, priority: priority)
                }
                lastView = view
            }
        }
        
        _ = self.pinTopEdgeToTopEdge(of: views.first!, withOffset: -separation, priority: priority)
        _ = self.pinBottomEdgeToBottomEdge(of: views.last!, withOffset: -separation, priority: priority)
    }
    
}

// MARK: - General
extension UIView {
    
    @discardableResult func constrain(item: LayoutItem, attribute itemAttribute: NSLayoutConstraint.Attribute, toItem: LayoutItem? = nil, attribute toAttribute: NSLayoutConstraint.Attribute = .notAnAttribute, relatedBy: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        if let view = item as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(
            item: item, attribute: itemAttribute,
            relatedBy: relatedBy,
            toItem: toItem, attribute: toAttribute,
            multiplier: multiplier, constant: offset
        )
        if priority != nil {
            constraint.priority = priority!
        }
        self.addConstraint(constraint)
        return constraint
    }
}

// MARK: - Array[UIView]
extension Array where Element: UIView {
    
    func centerHorizontally(to item: LayoutItem, withSeparation separation: CGFloat = 0, priority: UILayoutPriority? = nil) {
        assert(self.count > 0, "Can only center 1 or more views")
        
        if self.count % 2 == 0 { // even
            let rightIndex = self.count/2
            let leftIndex = rightIndex-1
            
            _ = self[leftIndex].constrain(attribute: .right, toAttribute: .centerX, ofItem: item, relatedBy: .lessThanOrEqual, offset:-separation/2, priority: priority)
            _ = self[rightIndex].constrain(attribute: .left, toAttribute: .centerX, ofItem: item, relatedBy: .lessThanOrEqual, offset:separation/2, priority: priority)
            
            if self.count > 2 {
                let rightViews = Array(self[rightIndex+1...self.count-1])
                if rightViews.count > 0 {
                    rightViews.positionToTheRight(of: self[rightIndex], withOffset: separation, priority: priority)
                }
                
                let leftViews = Array(self[0...leftIndex-1])
                if leftViews.count > 0 {
                    leftViews.positionToTheLeft(of: self[leftIndex], withOffset: separation, priority: priority)
                }
            }
        } else { // odd
            let centerIndex = self.count/2
            _ = self[centerIndex].centerHorizontally(to: item)
            
            if self.count > 1 {
                let rightViews = Array(self[centerIndex+1...self.count-1])
                if rightViews.count > 0 {
                    rightViews.positionToTheRight(of: self[centerIndex], withOffset: separation, priority: priority)
                }
                
                let leftViews = Array(self[0...centerIndex-1])
                if leftViews.count > 0 {
                    leftViews.positionToTheLeft(of: self[centerIndex], withOffset: separation, priority: priority)
                }
            }
        }
    }
    
    func centerVertically(to item: LayoutItem, withSeparation separation: CGFloat = 0, priority: UILayoutPriority? = nil) {
        assert(self.count > 0, "Can only center 1 or more views")
        
        if self.count % 2 == 0 { // even
            let belowIndex = self.count/2
            let aboveIndex = belowIndex-1
            
            _ = self[aboveIndex].constrain(attribute: .bottom, toAttribute: .centerY, ofItem: item, relatedBy: .lessThanOrEqual, offset:-separation/2, priority: priority)
            _ = self[belowIndex].constrain(attribute: .top, toAttribute: .centerY, ofItem: item, relatedBy: .lessThanOrEqual, offset:separation/2, priority: priority)
            
            if self.count > 2 {
                let belowViews = Array(self[belowIndex+1...self.count-1])
                if belowViews.count > 0 {
                    belowViews.positionBelow(self[belowIndex], withOffset: separation, priority: priority)
                }
                
                let aboveViews = Array(self[0...aboveIndex-1])
                if aboveViews.count > 0 {
                    aboveViews.positionAbove(self[aboveIndex], withOffset: separation, priority: priority)
                }
            }
        }else{ // ood
            let centerIndex = self.count/2
            _ = self[centerIndex].centerVertically(to: item)
            
            if self.count > 1 {
                let belowViews = Array(self[centerIndex+1...self.count-1])
                if belowViews.count > 0 {
                    belowViews.positionBelow(self[centerIndex], withOffset: separation, priority: priority)
                }
                
                let aboveViews = Array(self[0...centerIndex-1])
                if aboveViews.count > 0 {
                    aboveViews.positionAbove(self[centerIndex], withOffset: separation, priority: priority)
                }
            }
        }
    }
    
    func positionAbove(_ item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) {
        var lastItem = item
        for view in self.reversed() {
            _ = view.positionAbove(lastItem, withOffset: offset, priority: priority)
            lastItem = view
        }
    }
    
    func positionToTheRight(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) {
        var lastItem = item
        for view in self {
            _ = view.positionToTheRight(of: lastItem, withOffset: offset, priority: priority)
            lastItem = view
        }
    }
    
    func positionBelow(_ item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) {
        var lastItem = item
        for view in self {
            _ = view.positionBelow(lastItem, withOffset: offset, priority: priority)
            lastItem = view
        }
    }
    
    func positionToTheLeft(of item: LayoutItem, withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) {
        var lastItem = item
        for view in self.reversed() {
            _ = view.positionToTheLeft(of: lastItem, withOffset: offset, priority: priority)
            lastItem = view
        }
    }
    
}

// MARK: - Private
extension UIView {
    
    @discardableResult fileprivate func constrain(sizeAttribute: NSLayoutConstraint.Attribute, size: CGFloat = 0, relatedBy: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        return self.constrain(item: self, attribute: sizeAttribute, relatedBy: relatedBy, multiplier: 0, offset: size, priority: priority)
    }
    
    @discardableResult fileprivate func constrain(edgeAttribute: NSLayoutConstraint.Attribute, offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        assert(self.superview != nil, "Can't create constraints without a super view")
        guard let superview = self.superview else {
            return nil
        }
        
        return superview.constrain(item: self, attribute: edgeAttribute, toItem: superview, attribute: edgeAttribute, offset: offset, priority: priority)
    }
    
    @discardableResult fileprivate func constrain(attribute: NSLayoutConstraint.Attribute, toAttribute itemAttribute: NSLayoutConstraint.Attribute, ofItem item: LayoutItem, relatedBy: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        let commonSuperview: UIView? = {
            guard let view = item as? UIView else {
                return self.superview
            }
            
            return {
                var startView: UIView! = self
                var commonSuperview: UIView?
                repeat {
                    if view.isDescendant(of: startView) {
                        commonSuperview = startView
                    }
                    startView = startView.superview
                } while (startView != nil && commonSuperview == nil)
                return commonSuperview
                }()
        }()
        
        assert(commonSuperview != nil, "Can't create constraints without a common super view")
        if commonSuperview == nil {
            return nil
        }
        
        return commonSuperview!.constrain(item: self, attribute: attribute, toItem: item, attribute: itemAttribute, relatedBy: relatedBy, multiplier: multiplier, offset: offset, priority: priority)
    }
    
}

extension UIView {
    
    @discardableResult func pinToBottomEdgeOfSafeArea() -> NSLayoutConstraint? {
        assert(self.superview != nil, "Can't create constraints without a super view")
        var guide: AnyObject?
        if #available(iOS 11.0, *) {
            guide = self.superview?.safeAreaLayoutGuide
        } else {
            guide = self.superview
        }
        
        let bottomSafeAreaConstraint = guide?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0)
        bottomSafeAreaConstraint?.isActive = true
        return bottomSafeAreaConstraint
    }
    
    @discardableResult func pinToBottomEdgeOfSafeArea(withOffset offset: CGFloat = 0) -> NSLayoutConstraint? {
        assert(self.superview != nil, "Can't create constraints without a super view")
        var guide: AnyObject?
        if #available(iOS 11.0, *) {
            guide = self.superview?.safeAreaLayoutGuide
        } else {
            guide = self.superview
        }
        
        let bottomSafeAreaConstraint = guide?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: offset)
        bottomSafeAreaConstraint?.isActive = true
        return bottomSafeAreaConstraint
    }
    
    @discardableResult func pinToBottomEdgeOfSafeArea(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        assert(self.superview != nil, "Can't create constraints without a super view")
        var guide: AnyObject?
        if #available(iOS 11.0, *) {
            guide = self.superview?.safeAreaLayoutGuide
        } else {
            guide = self.superview
        }
        
        let bottomSafeAreaConstraint = guide?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: offset)
        if let priority = priority {
            bottomSafeAreaConstraint?.priority = priority
        }
        bottomSafeAreaConstraint?.isActive = true
        return bottomSafeAreaConstraint
    }
    
    @discardableResult func pinToTopEdgeOfSafeArea() -> NSLayoutConstraint? {
        assert(self.superview != nil, "Can't create constraints without a super view")
        var guide: AnyObject?
        if #available(iOS 11.0, *) {
            guide = self.superview?.safeAreaLayoutGuide
        } else {
            guide = self.superview
        }
        
        let topSafeAreaConstraint = guide?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0)
        topSafeAreaConstraint?.isActive = true
        return topSafeAreaConstraint
    }
    
    @discardableResult func pinToTopEdgeOfSafeArea(withOffset offset: CGFloat = 0) -> NSLayoutConstraint? {
        assert(self.superview != nil, "Can't create constraints without a super view")
        var guide: AnyObject?
        if #available(iOS 11.0, *) {
            guide = self.superview?.safeAreaLayoutGuide
        } else {
            guide = self.superview
        }
        
        let topSafeAreaConstraint = guide?.topAnchor.constraint(equalTo: self.topAnchor, constant: offset)
        topSafeAreaConstraint?.isActive = true
        return topSafeAreaConstraint
    }
    
    @discardableResult func pinToTopEdgeOfSafeArea(withOffset offset: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint? {
        assert(self.superview != nil, "Can't create constraints without a super view")
        var guide: AnyObject?
        if #available(iOS 11.0, *) {
            guide = self.superview?.safeAreaLayoutGuide
        } else {
            guide = self.superview
        }
        
        let topSafeAreaConstraint = guide?.topAnchor.constraint(equalTo: self.topAnchor, constant: offset)
        if let priority = priority {
            topSafeAreaConstraint?.priority = priority
        }
        topSafeAreaConstraint?.isActive = true
        return topSafeAreaConstraint
    }
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        guard let attributedText = label.attributedText,
            let labelFont = label.font,
            let textCount = label.text?.count else {
                return false
        }
        
        let locationOfTouchInLabel = self.location(in: label)
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let labelFontAttributes = [NSAttributedString.Key.font: labelFont]
        textStorage.setAttributes(labelFontAttributes, range: NSRange.init(location: 0, length: textCount))
        
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer()
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.size = label.bounds.size
        
        layoutManager.addTextContainer(textContainer)
        layoutManager.ensureGlyphs(forCharacterRange: targetRange)
        
        var glyphRange = NSRange()
        layoutManager.characterRange(forGlyphRange: targetRange, actualGlyphRange: &glyphRange)
        
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInLabel, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
