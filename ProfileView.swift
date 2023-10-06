//
//  ProfileView.swift
//  PhantomConnectExample
//
//  Created by Zeki Baklan on 6.10.2023.
//

import SwiftUI
import PhantomConnect
import Solana
struct ProfileView: View {
    @ObservedObject var viewModel: PhantomConnectViewModel
    @Binding var walletConnected: Bool
    @Binding var walletPublicKey: PublicKey?
    @Binding var phantomEncryptionKey: PublicKey?
    @Binding var session: String?
    @Binding var transactionSignature: String?
    var body: some View {
        ZStack {
            Spacer()
           
            CustomCardView()
                .ignoresSafeArea(.all)
                
            
            VStack(spacing: 24) {
                
                
                Group {
                    Text("CONNECT SUCCESS!")
                        .modifier(TitleModifier())
                    
                        .modifier(KeysModifier(keysname: "Wallet Public Key:", publicKeys: walletPublicKey?.base58EncodedString ?? "--"))
                        
                        
                        .modifier(KeysModifier(keysname: "Transaction Signature:", publicKeys: transactionSignature ?? "--"))
                }
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                
                
                Spacer(minLength: 200)
                HStack(alignment: .center ,spacing: 5) {
                    Spacer()
                    Button {
                        
                        createTransaction { serializedTransaction in
                            
                            try? viewModel.sendAndSignTransaction(
                                serializedTransaction: serializedTransaction,
                                dappEncryptionKey: viewModel.linkingKeypair?.publicKey,
                                phantomEncryptionKey: phantomEncryptionKey,
                                session: session,
                                dappSecretKey: viewModel.linkingKeypair?.secretKey
                            )
                            
                        }
                        
                    } label: {
                        
                        Text("Send Transaction")
                            .modifier(ButtonModifier())
                        
                    }
                    .onWalletTransaction(
                        phantomEncryptionPublicKey: phantomEncryptionKey,
                        dappEncryptionSecretKey: viewModel.linkingKeypair?.secretKey
                    ) { signature, _ in
                        
                        transactionSignature = signature
                        
                    }
                    Spacer()
                    Button {
                        
                        try? viewModel.disconnectWallet(
                            dappEncryptionKey: viewModel.linkingKeypair?.publicKey,
                            phantomEncryptionKey: phantomEncryptionKey,
                            session: session,
                            dappSecretKey: viewModel.linkingKeypair?.secretKey
                        )
                        
                    } label: {
                        
                        Text("Disconnect")
                            .modifier(ButtonModifier())
                                                    
                    }
                    
                    .onWalletDisconnect { error in
                        
                        walletConnected.toggle()
                        
                    }
                    Spacer()
                    
                }
                
            }
            
        }
        
    }
    
    func createTransaction(completion: @escaping ((_ serializedTransaction: String) -> Void)) {
        
        let solana = Solana(router: NetworkingRouter(endpoint: RPCEndpoint.devnetSolana))
        
        solana.api.getRecentBlockhash { result in
            
            let blockhash = try? result.get()
            
            var transaction = Transaction(
                feePayer: walletPublicKey!,
                instructions: [
                    SystemProgram.transferInstruction(
                        from: walletPublicKey!,
                        to: walletPublicKey!,
                        lamports: 100
                    )
                ],
                recentBlockhash: blockhash!
            )
            
            let serializedTransaction = try? transaction.serialize().get()
            
            DispatchQueue.main.async {
                completion(Base58.encode(serializedTransaction!.bytes))
            }
            
        }
        
    }
    }


#Preview {
    ProfileView(
        viewModel: PhantomConnectViewModel(),
        walletConnected: .constant(false),
        walletPublicKey: .constant(nil),
        phantomEncryptionKey: .constant(nil),
        session: .constant(nil), transactionSignature: .constant(nil)
    )
}
