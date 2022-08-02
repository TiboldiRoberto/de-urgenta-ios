import Foundation
import SwiftUI
import UIKit

final class MenuCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: MenuView())
        navigationController.pushViewController(viewController, animated: true)
    }
}
