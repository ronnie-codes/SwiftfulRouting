//
//  OnFirstAppearViewModifier.swift
//  
//

import SwiftUI

struct OnFirstAppearViewModifier: ViewModifier {
    let action: @MainActor () -> Void
    @State private var isFirstAppear = true
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if isFirstAppear {
                    action()
                    isFirstAppear = false
                }
            }
    }
}

extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearViewModifier(action: action))
    }
}
