//
//  ConfirmationDialogViewModifier.swift
//  
//
//  Created by Nick Sarno on 5/1/22.
//

import Foundation
import SwiftUI

struct ConfirmationDialogViewModifier: ViewModifier {

    let option: AlertOption
    let item: Binding<AnyAlert?>

    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                item.wrappedValue?.title ?? "",
                isPresented: Binding(ifNotNil: Binding(if: option, is: .confirmationDialog, value: item)),
                titleVisibility: item.wrappedValue?.title.isEmpty ?? true ? .hidden : .visible
            ) {
                item.wrappedValue?.buttons
            } message: {
                if let subtitle = item.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            }
    }
}

extension View {
    func confirmationDialog(option: AlertOption, item: Binding<AnyAlert?>) -> some View {
        modifier(ConfirmationDialogViewModifier(option: option, item: item))
    }
}
