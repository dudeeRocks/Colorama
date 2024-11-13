// Abstract: Supplementary view for delete button that appears on top of color grid cell when Edit button is pressed in the nav.bar.

import UIKit

class ColorGridDeleteButtonView: UICollectionReusableView {
    
    weak var delegate: ColorGridDeleteButtonViewDelegate?
    
    var onTap: () -> Void = { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let size: CGFloat = 32.0
        let button = UIButton()
        let image = UIImage(systemName: "minus.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        addSubview(button)
        
        button.addTarget(delegate, action: #selector(buttonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: size),
            button.heightAnchor.constraint(equalToConstant: size),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = .white
        layer.cornerRadius = size / 2.0
    }
    
    @objc private func buttonAction() {
        onTap()
    }
}

protocol ColorGridDeleteButtonViewDelegate: AnyObject { }
