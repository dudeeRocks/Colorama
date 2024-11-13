// Abstract: custom view for color row in the list.

import UIKit

/// To create your custom contentn view you subclass a UIView and conform it to UIContentView protocol.
class ColorRowView: UIView, UIContentView {
    
    /// As part of `UIContentView` protocol conformance you must provide a `configuration` property. The type is required to be of `any UIContentConfiguration`, but this is where we'll be setting our config.
    ///
    /// To conform to `UIContentView` protocol your custom view is required to declare a `configuration` property of the `any UIContentConfiguration` type.
    var configuration: any UIContentConfiguration {
        /// This pattern of configuration when on didSet is a trick I learned in Apple's official tutorial.
        /// This pattern ensures that the content of the view is updated anytime the configuration changes.
        didSet {
            configure(configuration)
        }
    }
    
    /// Declare your subviews in your content view. Let the content viww handle the subviews and layout, while config will handle the data.
    private let colorView = UIView()
    private let label = UILabel()
    
    // MARK: - Initializers
    
    /// Init is a good place to set up your view.
    init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    /// Use your custom configuration to populate the views with relevant data.
    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        colorView.backgroundColor = configuration.color
        label.text = configuration.name
    }
    
    private func setup() {
        setupColorView()
        setUpLabel()
        setupConstraints()
    }
    
    private func setupColorView() {
        addSubview(colorView)
        colorView.layer.cornerRadius = 10
        colorView.layer.borderWidth = 1
        colorView.layer.borderColor = UIColor.separator.cgColor
        colorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLabel() {
        addSubview(label)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// When you're creating custom table view cells without storyboard or subclassing it's very important to make sure that UIKit is able to calculate the intrinsic size of your cell view based on constraints set by the subviews.
    /// This means that you need to make sure that the tallest view has the vertical anchors (top and bottom) set, while the views that touch the sides have their leading and trailing anchors set accordingly.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            colorView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor),
            
            label.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

/// Since the config is gonna be used by your custom view only it's safe and useful to wrap it inside an extension.
extension ColorRowView {
    
    /// As I see it the `UIContentConfiguration` fits perfectly the MVVM pattern and that's how I think about it.
    /// This is the place where you define the data you need to serve the cells.
    /// This separation of concerns is really helpful when organizing your codebase and helps to reason about the code.
    struct Configuration: UIContentConfiguration {
        
        /// Declare any props that you may need to display your view.
        /// You can also use config for presentation customization if you'd like
        var color: UIColor = .clear
        var name: String = ""
        
        private var previousColor: UIColor!
        
        /// This function is called every time the cell needs to appear on screen.
        /// The key here is to return the proper view and make sure the configuration is passed to it and applied.
        /// You could use this function to create your custom view ehre, and configure it, but I prefer offloading it to the view init.
        func makeContentView() -> any UIView & UIContentView {
            // TODO: let's make this configuration return row or grid based on a flag to demonstrate the power of `makeContentView()` method
            ColorRowView(configuration: self)
        }
        
        /// This function is called any time the state of the table cell changes.
        /// You can use this funciton to check if the cell is selected for example and change it's background color.
        func updated(for state: any UIConfigurationState) -> ColorRowView.Configuration {
            self
        }
    }
}

extension UITableViewCell {
    func listItemConfiguration() -> ColorRowView.Configuration {
        ColorRowView.Configuration()
    }
}
