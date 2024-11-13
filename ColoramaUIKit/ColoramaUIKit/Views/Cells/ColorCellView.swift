// Abstract: a view for a cell in the colors grid

import UIKit

class ColorCellView: UIView, UIContentView {
    
    var configuration: any UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }
    
    private let colorView = UIView()
    private let label = UILabel()
    
    // MARK: - Initializers
    
    init(configuration: UIContentConfiguration) {
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
        colorView.layer.cornerRadius = 20
        colorView.layer.borderWidth = 1
        colorView.layer.borderColor = UIColor.separator.cgColor
        
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.numberOfLines = 1
        
        let stackView = UIStackView(arrangedSubviews: [colorView, label])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
}

extension ColorCellView {
    struct Configuration: UIContentConfiguration {
        var color: UIColor = .clear
        var name: String = ""
        
        func makeContentView() -> any UIView & UIContentView {
            ColorCellView(configuration: self)
        }
        
        func updated(for state: any UIConfigurationState) -> ColorCellView.Configuration {
            self
        }
    }
}

extension UICollectionViewCell {
    func gridItemConfiguration() -> ColorCellView.Configuration {
        return ColorCellView.Configuration()
    }
}
