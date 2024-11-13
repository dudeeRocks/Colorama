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
        let icon = UIImageView(image: UIImage(systemName: "minus.circle.fill"))
        let size: CGFloat = 32.0
        
        addSubview(icon)
        icon.tintColor = .systemRed
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: size),
            icon.widthAnchor.constraint(equalToConstant: size),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = .white
        layer.cornerRadius = size / 2.0
    }
}
