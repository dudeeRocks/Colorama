// Abstract: root view controller of the app.

import UIKit

class RootViewController: UITabBarController {
    
    let model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        
        // MARK: List VC setup
        let listViewController = ListViewController(model: model)
        let listNavigationController = UINavigationController(rootViewController: listViewController)
        listNavigationController.tabBarItem.image = UIImage(systemName: "list.bullet")
        listNavigationController.tabBarItem.title = "List"
        listNavigationController.navigationBar.prefersLargeTitles = true
        
        // MARK: Grid VC setup
        let gridViewController = GridViewController(model: model)
        let gridNavigationController = UINavigationController(rootViewController: gridViewController)
        gridNavigationController.tabBarItem.image = UIImage(systemName: "square.grid.2x2.fill")
        gridNavigationController.tabBarItem.title = "Grid"
        gridNavigationController.navigationBar.prefersLargeTitles = true
        
        // MARK: Sort VC setup
        let sortViewController = SortViewController(model: model)
        let sortNavigationController = UINavigationController(rootViewController: sortViewController)
        sortNavigationController.tabBarItem.image = UIImage(systemName: "shuffle")
        sortNavigationController.tabBarItem.title = "Sort"
        sortNavigationController.navigationBar.prefersLargeTitles = false
        
        viewControllers = [listNavigationController, gridNavigationController, sortNavigationController]
    }


}
