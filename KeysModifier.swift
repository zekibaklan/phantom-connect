//
//  KeysModifier.swift
//  PhantomConnectExample
//
//  Created by Zeki Baklan on 6.10.2023.
//

import SwiftUI
import Solana

struct KeysModifier : ViewModifier {
        let keysname: String
       let publicKeys: String
    
    func body(content: Content) -> some View {
        content
         
            Text(keysname)
                .foregroundStyle(Color("Colorwhite"))
                .font(.title2)
                .fontWeight(.bold)
                .shadow(radius: 1)
                .padding(.horizontal,18)
                .padding(.vertical,4)
                .overlay(
                Rectangle()
                    .fill(.white)
                    .frame(height: 1)
                ,alignment: .bottom
                )
            
            Text(publicKeys)
                .foregroundStyle(.black)
                .font(.footnote)
                .fontWeight(.bold)
                .frame(minWidth: 85)
                .padding(.horizontal,10)
                .padding(.vertical,5)
                .background(
                Capsule()
                    .fill(Color("Colorwhite"))
                )
                .padding(5)
             
        }
        
        
    
    
}
