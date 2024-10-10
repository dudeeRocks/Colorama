// Abstract: List actions

import UIKit

extension ColorsListViewController {
    @objc func addColor() {
        let detailsVC = ColorDetailsViewController()
        
        let navigationVC = UINavigationController(rootViewController: detailsVC)
        present(navigationVC, animated: true)
    }
}
