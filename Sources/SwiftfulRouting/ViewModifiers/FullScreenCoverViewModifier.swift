//
//  FullScreenCoverViewModifier.swift
//  
//
//  Created by Nick Sarno on 5/1/22.
//

import Foundation
import SwiftUI

struct FullScreenCoverViewModifier: ViewModifier {

    let option: SegueOption
    let screens: Binding<[AnyDestination]>

    func body(content: Content) -> some View {
        #if os(macOS)
        content
        #else
        content
            .fullScreenCover(item: Binding(if: option, is: .fullScreenCover, value: Binding(toLastElementIn: screens)), onDismiss: nil) { _ in
                if let view = screens.wrappedValue.last?.destination {
                    view
                }
            }
        #endif
    }
}

extension View {
    func fullScreenCover(option: SegueOption, screens: Binding<[AnyDestination]>) -> some View {
        modifier(FullScreenCoverViewModifier(option: option, screens: screens))
    }
}
