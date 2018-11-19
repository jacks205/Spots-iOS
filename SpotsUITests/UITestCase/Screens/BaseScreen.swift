import XCTest

typealias Element = XCUIElement
typealias Application = XCUIApplication
typealias ElementType = XCUIElement.ElementType

class BaseScreen {

    let app = Application()
    var anchorElements: [Element] {
        return []
    }

    func screenLoaded(_ timeout: TimeInterval = 5.0) -> Bool {
        return self.waitForElementsToAppear(elements: self.anchorElements, timeout: timeout)
    }

    func descendents(of element: Element? = nil, for type: ElementType) -> [Element] {
        let elementQuery: XCUIElementQuery
        if let element = element {
            elementQuery = element.descendants(matching: type)
        } else {
            elementQuery = self.app.descendants(matching: type)
        }

        var elements: [Element] = []
        for index in 0...elementQuery.count {
            let currentElement = elementQuery.element(boundBy: index)
            elements.append(currentElement)
        }
        return elements
    }

    func waitForElementsToAppear(elements: [Element], timeout: TimeInterval = 5.0) -> Bool {
        var expectations: [XCTestExpectation] = []
        let predicate = NSPredicate(format: "exists == true")

        elements.forEach {
            let expectation = XCTNSPredicateExpectation(predicate: predicate, object: $0)
            expectations.append(expectation)
        }

        let result = XCTWaiter().wait(for: expectations, timeout: timeout)
        return result == .completed
    }

}