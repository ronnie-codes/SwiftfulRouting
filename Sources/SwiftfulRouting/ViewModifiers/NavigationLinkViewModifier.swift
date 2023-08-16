//
//  NavigationLinkViewModifier.swift
//  
//
//  Created by Nick Sarno on 5/1/22.
//

import Foundation
import SwiftUI

struct NavigationLinkViewModifier: ViewModifier {
    
    let option: SegueOption
    let screens: Binding<[AnyDestination]>
    
    // Must be @State so that this modifier can control the state & not add .navigationDestination twice
    @State var shouldAddNavigationDestination: Bool

    func body(content: Content) -> some View {
        // If we are continuing an existing stack, don't need to add another .navigationDestination modifier
        if shouldAddNavigationDestination {
            ZStack {
                content
            }
            .navigationDestination(for: AnyDestination.self) { value in
                value.destination
            }
        } else {
            content
        }
    }
}

extension View {
    func navigationLink(option: SegueOption, screens: Binding<[AnyDestination]>, shouldAddNavigationDestination: Bool) -> some View {
        modifier(NavigationLinkViewModifier(
            option: option,
            screens: screens,
            shouldAddNavigationDestination: shouldAddNavigationDestination
        ))
    }
}
