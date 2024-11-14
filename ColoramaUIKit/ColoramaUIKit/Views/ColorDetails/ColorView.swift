// Abstract: content view for color on details screen

import UIKit

class ColorView: UIView, UIContentView {
    
    var configuration: any UIContentConfiguration {
        didSet { configure(configuration) }
    }
    
    private let colorView = UIView()
    
    private func configure(_ configuration: any UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        colorView.backgroundColor = configuration.color
    }
    
    private func layOutViews() {
        addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: topAnchor),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorView.widthAnchor.constraint(equalTo: widthAnchor),
            colorView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    // MARK: - Initializers
    
    init(configuration: any UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        layOutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorView {
    struct Configuration: UIContentConfiguration {
        
        var color: UIColor!
        
        func makeContentView() -> any UIView & UIContentView {
            ColorView(configuration: self)
        }
        
        func updated(for state: any UIConfigurationState) -> ColorView.Configuration {
            self
        }
    }
}
