import Foundation
import SwiftUI
import UIKit

final class SingInCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: SignInView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
