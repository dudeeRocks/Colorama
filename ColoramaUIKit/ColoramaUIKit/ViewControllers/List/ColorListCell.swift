// Abstract: custom view for colors list table cell.

import UIKit

class ColorListCell: UITableViewCell {

    var color: UIColor! {
        didSet {
            setupColorView()
        }
    }
    var name: String! {
        didSet {
            setUpLabel()
        }
    }
    
    override class func awakeFromNib() {
        return
    }
    
    private let colorView = UIView()
    private let label = UILabel()
    
    private func setupColorView() {
        addSubview(colorView)
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = 10
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpLabel() {
        addSubview(label)
        label.text = name
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
