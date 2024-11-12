// Abstract: Supplementary view for delete button that appears on top of color grid cell when Edit button is pressed in the nav.bar.

import UIKit

class ColorGridDeleteButtonView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let icon = UIImageView(image: UIImage(systemName: "xmark"))
        let spacing: CGFloat = 4.0
        let size: CGFloat = 20.0
        
        addSubview(icon)
        icon.tintColor = .white
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            icon.heightAnchor.constraint(equalToConstant: size),
            icon.widthAnchor.constraint(equalToConstant: size)
        ])
        
        layer.cornerRadius = (size + spacing) / 2
        layer.borderColor = UIColor.separator.cgColor
        layer.borderWidth = 2.0
        
        backgroundColor = .black.withAlphaComponent(0.8)
    }
}
