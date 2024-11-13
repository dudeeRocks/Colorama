// Abstract: View to display when there are no custom colors.

import UIKit

class EmptyStateView: UIView, UIContentView {
    
    var configuration: any UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }
    
    private func configure(_ configuration: any UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        
        // MARK: Label
        let label = UILabel()
        label.text = "No custom colors yet."
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        
        // MARK: Call-to-Action Button
        let addColorButton = UIButton()
        addColorButton.setTitle("Add a color", for: .normal)
        addColorButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.imagePadding = 10
        
        addColorButton.configuration = buttonConfiguration
        
        // MARK: Stack View
        let stackView = UIStackView(arrangedSubviews: [label, addColorButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Constraints
        
        let spacing: CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: (spacing)),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
        
        // MARK: Grid Setup
        if configuration.isGrid {
            backgroundColor = .systemBackground
            layer.cornerRadius = 24
        }

    }
    
    // MARK: - Initialization
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    struct Configuration: UIContentConfiguration {
        
        var isGrid: Bool = false
        
        func makeContentView() -> any UIView & UIContentView {
            EmptyStateView(configuration: self)
        }
        
        func updated(for state: UIConfigurationState) -> Self {
            self
        }
    }
}

// MARK: - Extensions for UIKit Cells

extension UITableViewCell {
    func emptyStateConfiguration() -> EmptyStateView.Configuration {
        return EmptyStateView.Configuration()
    }
}

extension UICollectionViewCell {
    func emptyStateConfiguration() -> EmptyStateView.Configuration {
        return EmptyStateView.Configuration()
    }
}
