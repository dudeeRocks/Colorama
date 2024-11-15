// Abstract: Text field view for Color Details screen

import UIKit

class ColorNameTextFieldView: UIView, UIContentView {
    
    var configuration: any UIContentConfiguration {
        didSet { configure(configuration) }
    }
    
    private let textField = UITextField()
    
    init(configuration: any UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ configuration: any UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
        textField.delegate = configuration.delegate
    }
    
    private func setup() {
        textField.placeholder = "Enter color name"
        textField.textColor = .label
        textField.font = .preferredFont(forTextStyle: .body)
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        
        addSubview(textField)
        
        let spacing: CGFloat = 10
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension ColorNameTextFieldView {
    struct Configuration: UIContentConfiguration {
        
        var text: String = ""
        var delegate: UITextFieldDelegate!
        
        func makeContentView() -> any UIView & UIContentView {
            return ColorNameTextFieldView(configuration: self)
        }
        
        func updated(for state: any UIConfigurationState) -> ColorNameTextFieldView.Configuration {
            return self
        }
    }
}

