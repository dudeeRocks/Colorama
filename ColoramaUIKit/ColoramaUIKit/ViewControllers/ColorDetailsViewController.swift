// Abstract: View for the color details.

import UIKit

private let reuseIdentifier = "Cell"

class ColorDetailsViewController: UIViewController {

    var colorItem: ColorItem
    
    init(colorItem: ColorItem) {
        self.colorItem = colorItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorItem.color
    }
}
