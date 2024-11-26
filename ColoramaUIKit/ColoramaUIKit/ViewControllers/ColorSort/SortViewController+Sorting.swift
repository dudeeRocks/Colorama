// Abstract: the sorting logic for the sort vc.

import UIKit

extension SortViewController {
    func sortColors() async {
        for iteration in 0..<shuffledColors.count {
            for index in 0..<shuffledColors.count - iteration - 1 {
                
                let nextIndex = index + 1
                
                guard
                    let currentColorHue = shuffledColors[index].colorItem?.hue,
                    let nextColorHue = shuffledColors[nextIndex].colorItem?.hue
                else {
                    print("Couldn't get the color hue to sort.")
                    return
                }
                
                if currentColorHue > nextColorHue {
                    shuffledColors.swapAt(index, nextIndex)
                    applySnapshot()
                    try! await Task.sleep(for: .seconds(1))
                }
                
            }
        }
    }
}
