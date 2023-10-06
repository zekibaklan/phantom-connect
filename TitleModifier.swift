//
//  TitleModifier.swift
//  PhantomConnectExample
//
//  Created by Zeki Baklan on 6.10.2023.
//
import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
            .padding(.leading, 4)
            .foregroundColor(Color("Colorwhite"))
    }
}
