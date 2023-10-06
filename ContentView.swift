//
//  ContentView.swift
//  PhantomConnectExample
//
//  Created by Eric McGary on 7/8/22.
//

import SwiftUI
import Solana
import PhantomConnect

struct ContentView: View {
    
    @StateObject var viewModel = PhantomConnectViewModel()
    
    @State var walletConnected = false
    @State var walletPublicKey: PublicKey?
    @State var phantomEncryptionKey: PublicKey?
    @State var session: String?
    @State var transactionSignature: String?
    
    var body: some View {
        
        content
            .onAppear {

                PhantomConnect.configure(
                    appUrl: "https://example.com",
                    cluster: "devnet",
                    redirectUrl: "example://"
                )
                
            }
        
    }
    
    @ViewBuilder
    var content: some View {
        
        if walletConnected {
            ProfileView(viewModel: viewModel,
                        walletConnected: $walletConnected,
                        walletPublicKey: $walletPublicKey,
                        phantomEncryptionKey: $phantomEncryptionKey,
                        session: $session, transactionSignature: $transactionSignature)
        } else {
            HomeView(viewModel: viewModel,
                     walletConnected: $walletConnected,
                     walletPublicKey: $walletPublicKey,
                     phantomEncryptionKey: $phantomEncryptionKey,
                     session: $session, transactionSignature: $transactionSignature)
        }
        
    }
    
    
}
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
