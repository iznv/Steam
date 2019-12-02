//
//  UIColor+Hex.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

private extension CGFloat {

    static let maxColorComponentValue: CGFloat = 255
}

extension UIColor {

    var hex: String {
        let components = cgColor.components

        let red = components?[0] ?? 0
        let green = components?[1] ?? 0
        let blue = ((components?.count ?? 0) > 2 ? components?[2] : green) ?? 0

        let alpha = cgColor.alpha

        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * .maxColorComponentValue)),
            lroundf(Float(green * .maxColorComponentValue)),
            lroundf(Float(blue * .maxColorComponentValue))
        )

        if alpha < 1 {
            color += String(format: "%02lX", lroundf(Float(alpha)))
        }

        return color
    }
}
