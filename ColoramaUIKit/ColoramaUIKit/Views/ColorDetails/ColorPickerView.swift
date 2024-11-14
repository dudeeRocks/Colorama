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
        subscribeToNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configure(_ configuration: any UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        colorView.backgroundColor = configuration.color
    }
    
    private func layOutViews() {
        let spacing: CGFloat = 10
        let colorViewSize: CGFloat = 30
        
        addSubview(colorView)
        colorView.layer.cornerRadius = colorViewSize / 2
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.borderWidth = 2
        colorView.layer.borderColor = UIColor.separator.cgColor
        
        addSubview(label)
        label.text = "Pick a color"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorView.heightAnchor.constraint(equalToConstant: colorViewSize),
            colorView.widthAnchor.constraint(equalToConstant: colorViewSize),
            colorView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            label.trailingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: -spacing),
            label.centerYAnchor.constraint(equalTo: colorView.centerYAnchor)
        ])
    }
    
    // MARK: - Updating Color View
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColorView), name: .colorChanged, object: nil)
    }
    
    @objc private func updateColorView(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let color = userInfo[NSNotification.colorChanged] as? UIColor,
            var configuration = configuration as? Configuration
        else {
            return
        }
        configuration.color = color
        self.configuration = configuration
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
