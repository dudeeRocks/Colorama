// Abstract: the sorting logic for the sort vc.

import UIKit

extension SortViewController {
    @objc func sortColors() {
        sortTask = Task {
            isSorting = true
            configureNavigationBar()
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
                        try? await Task.sleep(for: .seconds(0.25))
                    }
                    
                }
            }
            isSorting = false
            configureNavigationBar()
        }
    }
    
    @objc func shuffleColors() {
        sortTask?.cancel()
        sortTask = nil
        shuffledColors = shuffledColors.shuffled()
        applySnapshot()
    }
}
