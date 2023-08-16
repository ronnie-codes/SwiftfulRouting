//
//  AlertViewModifier.swift
//  
//
//  Created by Nick Sarno on 5/1/22.
//

import Foundation
import SwiftUI

struct AlertViewModifier: ViewModifier {

    let option: AlertOption
    let item: Binding<AnyAlert?>

    func body(content: Content) -> some View {
        content
            .alert(item.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: Binding(if: option, is: .alert, value: item))) {
                item.wrappedValue?.buttons
            } message: {
                if let subtitle = item.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            }
    }
}

extension View {
    func alert(option: AlertOption, item: Binding<AnyAlert?>) -> some View {
        modifier(AlertViewModifier(option: option, item: item))
    }
}
