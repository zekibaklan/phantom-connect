//
//  CustomCardView.swift
//  PhantomConnectExample
//
//  Created by Zeki Baklan on 6.10.2023.
//

import SwiftUI

struct CustomCardView: View {
    var body: some View {
      ZStack {
        // MARK: - 3. DEPTH
        
        Color("Colorblack")
          .cornerRadius(40)
          .offset(y: 12)
        
        // MARK: - 2. LIGHT
        
          Color("Colorpurple")
          .cornerRadius(40)
          .offset(y: 3)
          .opacity(0.85)
        
        // MARK: - 1. SURFACE
        
        LinearGradient(
          colors: [
            Color("Colorblack"),
            Color("Colorblack")],
          startPoint: .top,
          endPoint: .bottom
        )
        .cornerRadius(40)
      }
    }
}

#Preview {
    CustomCardView()
}
