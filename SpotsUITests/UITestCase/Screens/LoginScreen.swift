import XCTest

class LoginScreen: BaseScreen {

    var emailInput: Element {
        return self.app.otherElements["login.email.text_input_view"]
    }
    var passwordInput: Element {
        return self.app.otherElements["login.password.text_input_view"]
    }
    var loginButton: Element {
        return self.app.buttons["login.cta.button"]
    }

    override var anchorElements: [Element] {
        return [self.emailInput, self.passwordInput]
    }

    override init() {
        super.init()
    }

    func enterEmail(_ email: String) -> LoginScreen {
        self.emailInput.tap()
        self.emailInput.typeText(email)
        return self
    }

    func enterPassword(_ password: String) -> LoginScreen {
        self.passwordInput.tap()
        self.passwordInput.typeText(password)
        return self
    }

    func login() -> BaseScreen {
        loginButton.tap()

        let alertScreen = AlertScreen(identifier: "login.alert.error")
        if alertScreen.screenLoaded() == true {
            return alertScreen
        }

        return HomeScreen()
    }
}