import XCTest

class BaseUITestCase: XCTestCase {

    internal let app = XCUIApplication()

    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        self.app.launchArguments = [
            "UI_TEST_MODE",
        ]
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        self.app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
    }

}