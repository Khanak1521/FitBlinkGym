//
//  Untitled.swift
//  StylishSwiftUI
//
//  Created by Dipang Sheth on 16/05/25.
//
import SwiftUI


enum FontWeight {
    case light
    case regular
    case medium
    case bold
}

extension Font {
    static func appFont(_ font: FontWeight, size: CGFloat = 15) -> Font {
        switch font {
        case .light:
            return Font.custom("Figtree-Light", size: size)
        case .regular:
            return Font.custom("Figtree-Regular", size: size)
        case .medium:
            return Font.custom("Figtree-Medium", size: size)
        case .bold:
            return Font.custom("Figtree-Bold", size: size)

        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight = .regular, size: CGFloat = 15) -> Text {
        return font(Font.appFont(fontWeight, size: size))
    }
}
