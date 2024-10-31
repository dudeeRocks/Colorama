// Abstract: View to display when there are no custom colors.

import UIKit

/// There are two main objects that you need to create a custom content view in UIKit:
///     **i. View** – This is the definition of your view represented as a a subclass of a `UIView` that conforms to `UIContentView` protocol.
///     **ii. Configuration** – This is the definition of the content and settings of the view, represented as object that conforms to the `UIContentConfiguration` protocol. Configuration is used to populated the view and to tell it how it should be rendered.

/// **View**
/// 1. You create custom views  by subclassing `UIView` and conforming it to the `UIContentView` protocol.
class EmptyStateView: UIView, UIContentView {
    
    /// 2. Conforming `UIContentView` protocol is as simple as declating a `configuration` variable property of type `any UIContentConfiguration`.  The word `any` in this case means that theoretically you could pass any configuration to create your custom content view, but in practice for every custom view there's a custom configuration object.
    var configuration: any UIContentConfiguration {
        /// XX. To make sure your custom view is updated accordingly every time the configuration is changed use `didSet` to configure the view.
        didSet {
            
        }
    }
    
    /// 3. Provide the initializer that takes and sets the configuration, and the required `init(coder:)`.
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        /// 4. Don't forget to initialize the UIView superclass with dedicated `init(frame:)` initializer. It's okay to set the frame's `CGRect` to `.zero`, since the size of the view is set intrinsicly by its subviews.
        super.init(frame: .zero)
    }
    
    /// 5. Make sure to include the `init(coder:)`initializer as it is required by the `UIView`. We won't be using this initilizer, however, so it's safe to invoke a fatal error here for the purposes of this article.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 6. At this point it's a good idea to define the content and the properties of our custom view so that we know exactly what subviews will constitute our custom view and how they will behave. We'll do that in a `UIContentConfiguration` object.
    /// As mentioned above, theoretically you can design your view to accept many kinds of configurations, such as UIKit's default list configuration of the `UIListContentConfiguration` type.
    /// However, more often than not, you'll want a specific configuration for your a specific view.
    /// Thus it makes sense to declare the configuration within our custom view type as a nested type.
    /// We'll call this simply `Configuration` and adapt the `UIContentConfiguration` protocol.
    
    struct Configuration: UIContentConfiguration {
        /// 7. The `UIContentConfiguration` protocol requires the conforming types to define two methods:
        ///     **i.** `makeContentView()` – This method is called every time the cell needs to appear on screen and is used to create the custom view that displays the data defined by this configuration.
        ///     This method can be used to perform any additional setup or return a relevant view based on some condition.
        ///     The simplest implementation returns the custom view with the configuration passed to it like so:
        func makeContentView() -> any UIView & UIContentView {
            EmptyStateView(configuration: self)
        }
        ///     We'll get to applying our configuration in the later in this article.
        
        ///     **ii.** `updated(for:)` – The system calls this method when the state of the cell changes,  such as when the cell is selected or disabled, and passes the relevant `UIConfigurationState` state to it.
        ///     You can use this method to check the state that's being passed and adjust your configuration accordingly.
        ///     However, if you don't plan on checking the state of the cell, you can simply return the configuration itself like so:
        
        func updated(for state: UIConfigurationState) -> Self {
            self
        }
    }
}
