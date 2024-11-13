// Abstract: View for section headers in the grid

import UIKit

class ColorGridSectionHeaderView: UICollectionReusableView {
    var text: String? {
        didSet {
            label.text = text?.uppercased()
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let spacing: CGFloat = 20
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(spacing / 2))
        ])
    }
}
