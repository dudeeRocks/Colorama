// Abstract: root view controller of the app.

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        guard let controllers = viewControllers else {
            print("Tab Bar has no view controllers.")
            return
        }
        
        for controller in controllers {
            guard let navigationController = controller as? UINavigationController else {
                print("This controller isn't a UINavigationController.")
                continue
            }
            switch navigationController.topViewController {
            case is ColorsListViewController:
                navigationController.tabBarItem.image = UIImage(systemName: "list.bullet")
                navigationController.tabBarItem.title = "List"
            default:
                navigationController.tabBarItem.image = UIImage(systemName: "square.grid.2x2.fill")
                navigationController.tabBarItem.title = "Grid"
            }
        }
    }


}

