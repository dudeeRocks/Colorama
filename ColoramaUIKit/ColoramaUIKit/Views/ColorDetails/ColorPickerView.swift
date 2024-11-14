// Abstract: view for editing color on color details screen in ADD/EDIT state

import UIKit

class ColorPickerView: UIView, UIContentView {
    
    var configuration: any UIContentConfiguration {
        didSet { configure(configuration) }
    }
    
    private let colorView = UIView()
    private let label = UILabel()
    
    // MARK: - Initializers
    
    init(configuration: any UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        layOutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ configuration: any UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        colorView.backgroundColor = configuration.color
    }
    
    private func layOutViews() {
        let spacing: CGFloat = 10
        let colorViewSize: CGFloat = 50
        
        label.text = "Pick a color"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        
        colorView.layer.cornerRadius = colorViewSize / 2
        
        let stackView = UIStackView(arrangedSubviews: [label, colorView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            colorView.widthAnchor.constraint(equalToConstant: colorViewSize),
            colorView.heightAnchor.constraint(equalToConstant: colorViewSize)
        ])
    }
}

extension ColorPickerView {
    struct Configuration: UIContentConfiguration {
        
        var color: UIColor!
        
        func makeContentView() -> any UIView & UIContentView {
            ColorPickerView(configuration: self)
        }
        
        func updated(for state: any UIConfigurationState) -> ColorPickerView.Configuration {
            self
        }
    }
}
