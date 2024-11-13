// Abstract: custom view for color row in the list.

import UIKit

class ColorRowView: UIView, UIContentView {
    
    var configuration: any UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }
    
    private let colorView = UIView()
    private let label = UILabel()
    
    // MARK: - Initializers
    
    init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        self.layOutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        colorView.backgroundColor = configuration.color
        label.text = configuration.name
    }
    
    private func layOutViews() {
        let spacing: CGFloat = 10
        let colorViewSize: CGFloat = 50
        
        colorView.layer.cornerRadius = 10
        colorView.layer.borderWidth = 1
        colorView.layer.borderColor = UIColor.separator.cgColor
        
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 1
        
        let stackView = UIStackView(arrangedSubviews: [colorView, label])
        stackView.axis = .horizontal
        stackView.spacing = spacing
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            
            colorView.widthAnchor.constraint(equalToConstant: colorViewSize),
            colorView.heightAnchor.constraint(equalToConstant: colorViewSize),
            
        ])
    }
}

extension ColorRowView {
    struct Configuration: UIContentConfiguration {
        
        var color: UIColor = .clear
        var name: String = ""
        
        private var previousColor: UIColor!
        
        func makeContentView() -> any UIView & UIContentView {
            // TODO: let's make this configuration return row or grid based on a flag to demonstrate the power of `makeContentView()` method
            ColorRowView(configuration: self)
        }
        
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
