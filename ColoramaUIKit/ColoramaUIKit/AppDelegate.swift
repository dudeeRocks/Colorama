//  ColoramaUIKit
//  Simple app to showcase the use of diffable data source in UIKit.
//
//  Created by David Katsman on 08/10/2024 as a complimentary to the following articles:
//  1. https://dudee.rocks/2024/11/28/how-to-use-diffable-data-source-in-uikit/
//  2. https://dudee.rocks/2024/11/28/how-to-use-diffable-data-source-with-uitableview/
//  3. https://dudee.rocks/2024/11/28/how-to-create-grid-layout-in-uikit/
//  4. https://dudee.rocks/2024/11/28/how-to-use-uicontentview-in-uikit/

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

