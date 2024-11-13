// Abstract: View for section headers in the grid

import UIKit

class ColorGridSectionHeaderView: UICollectionReusableView {
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
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
        
        let spacing: CGFloat = 10
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
