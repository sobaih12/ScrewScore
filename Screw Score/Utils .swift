//
//  Utils .swift
//  Screw Score
//
//  Created by Abdullah Essam on 17/05/2024.
//

import Foundation
import UIKit
class Utils {
    
    static let colorArray: [UIColor] = {
            var colors = [UIColor]()
            let hueIncrement: CGFloat = 1.0 / 10.0 // 10 distinct hues
            let saturationIncrement: CGFloat = 0.2 // 5 distinct saturations
            let brightnessIncrement: CGFloat = 0.2 // 5 distinct brightness levels

            for hueIndex in 0..<10 {
                for saturationIndex in 0..<5 {
                    for brightnessIndex in 0..<5 {
                        let hue = CGFloat(hueIndex) * hueIncrement
                        let saturation = CGFloat(saturationIndex) * saturationIncrement + 0.5
                        let brightness = CGFloat(brightnessIndex) * brightnessIncrement + 0.5
                        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                        colors.append(color)
                    }
                }
            }

            return colors
        }()
    
}
