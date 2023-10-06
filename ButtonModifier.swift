//
//  ButtonModifier.swift
//  PhantomConnectExample
//
//  Created by Zeki Baklan on 6.10.2023.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding()
            .frame(minWidth: 0,maxWidth: 200)
            .background(
                Capsule().fill(Color("Colorpurple"))
            )
            .foregroundColor(.white)
    }
}
