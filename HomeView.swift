import SwiftUI
import Solana
import PhantomConnect

struct HomeView: View {
    
    @ObservedObject var viewModel: PhantomConnectViewModel
    @Binding var walletConnected: Bool
    @Binding var walletPublicKey: PublicKey?
    @Binding var phantomEncryptionKey: PublicKey?
    @Binding var session: String?
    @Binding var transactionSignature: String?
    
    var body: some View {
      
        ZStack {
            CustomCardView()
                .frame(width: 350,height: 700)
            VStack {
                
                Text("Wellcome App!")
                    .modifier(TitleModifier())
                Button {
                    try? viewModel.connectWallet()
                } label: {
                    HStack {
                        Text("Connect with")
                            .foregroundStyle(Color("Colorwhite"))
                        
                           Image("phantom-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,height: 50)
                        
                    }
                    .modifier(ButtonModifier())
                    
                }
                .onWalletConnect(viewModel: viewModel) { publicKey, phantomEncryptionPublicKey, session, error in
                    self.walletPublicKey = publicKey
                    self.phantomEncryptionKey = phantomEncryptionPublicKey
                    self.session = session
                    walletConnected.toggle()
                }
            }
        }
        
        
    }
      
    
}

#Preview {
    HomeView(
        viewModel: PhantomConnectViewModel(),
        walletConnected: .constant(false),
        walletPublicKey: .constant(nil),
        phantomEncryptionKey: .constant(nil),
        session: .constant(nil), transactionSignature: .constant(nil)
    )
   
}

