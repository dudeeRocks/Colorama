// Abstract: a view for cells in the Sort VC. Universal for both layouts – grid and list.

import UIKit

class SortCellView: UIView, UIContentView {
    
    var configuration: any UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }
    
    let colorView = UIView()
    
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
    }
    
    private func layOutViews() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorView)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: topAnchor),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension SortCellView {
    struct Configuration: UIContentConfiguration {
        var color: UIColor = .clear
        var isGrid: Bool = false
        
        func makeContentView() -> any UIView & UIContentView {
            SortCellView(configuration: self)
        }
        
        func updated(for state: any UIConfigurationState) -> SortCellView.Configuration {
            self
        }
    }
}
