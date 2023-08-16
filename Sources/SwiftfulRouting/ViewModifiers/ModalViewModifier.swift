//
//  ModalViewModifier.swift
//  
//
//  Created by Nick Sarno on 5/1/22.
//

import Foundation
import SwiftUI

struct ModalViewModifier: ViewModifier {
    
    let configuration: ModalConfiguration
    let item: Binding<AnyDestination?>
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if let view = item.wrappedValue?.destination {
                        
                        if let backgroundColor = configuration.backgroundColor {
                            backgroundColor
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .edgesIgnoringSafeArea(.all)
                                .transition(AnyTransition.opacity.animation(configuration.animation))
                                .onTapGesture {
                                    item.wrappedValue = nil
                                }
                                .zIndex(1)
                        }

                        view
                            .frame(configuration: configuration)
                            .edgesIgnoringSafeArea(configuration.useDeviceBounds ? .all : [])
                            .transition(configuration.transition)
                            .zIndex(2)
                    }
                }
                .zIndex(999)
                .animation(configuration.animation, value: item.wrappedValue?.destination == nil)
            )
    }
}

extension View {
    @ViewBuilder func frame(configuration: ModalConfiguration) -> some View {
        if configuration.useDeviceBounds {
            #if os(macOS)
            frame(width: NSScreen.main!.frame.width, height: NSScreen.main!.frame.height, alignment: configuration.alignment)
            #else
            frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: configuration.alignment)
            #endif
        } else {
            frame(maxWidth: .infinity, maxHeight: .infinity, alignment: configuration.alignment)
        }
    }
}

extension View {
    func modal(configuration: ModalConfiguration, item: Binding<AnyDestination?>) -> some View {
        modifier(ModalViewModifier(configuration: configuration, item: item))
    }
}
