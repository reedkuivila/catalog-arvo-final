//
//  ContentView.swift
//  Final Project AG RK
//
//  Created by reed kuivila on 2/27/23.
//

// README
// color RGB valiues can be found here
// https://www.schemecolor.com/70s-retro.php


import SwiftUI
import AVKit
import AVFoundation

struct InitialSelectionView: View {
    @State private var showInitial = true
    
    
    var body: some View {
        // display name and user prompt
        // should brainstorm better options
        // should edit font and consider logo
        NavigationStack{
            GeometryReader{ geo in
                ZStack {
                    PlayerView()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height+100)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(Color.black.opacity(0.2))
                        .blur(radius: 1)
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack{
                    Text("loku")
                        .font(.custom("times", fixedSize: 100.0))
                        .fontWeight(.bold)
                        .padding(.top, 150)
                        .opacity(0.7)
                    
                    Text("movies done better")
                        .font(.custom("times", fixedSize: 35.0))
                        .opacity(0.7)
                    
                    // VStack to add login or sign up button
                    // should consider language of "sign in" or "login" and figure out which sounds better
                    VStack(alignment: .leading) {
                        Spacer()
                        // create account button
                        // TODO: to make create account page and add navigation link
                        NavigationLink(destination: SignUpView()) {
                            Button {
                                print("go to create account page")
                            } label: {
                                Text("create account")
                                    .font(.custom("times", fixedSize: 35))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color.purple.opacity(0.6))
                            .cornerRadius(15)
                            .padding(20)
                        }
                        
                        // login button
                        NavigationLink(destination: SignInView()){
                            Button {
                                print("go to sign in page")
                            } label: {
                                Text("sign in")
                                    .font(.custom("times", fixedSize: 35))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .cornerRadius(15)
                            .padding(20)
                            
                        }
                        
                        
                    }
                }
            }
            
            // cream color background - whole page
            //                .background(Color(red: 255.0/255.0,
            //                                  green: 231.0/255.0,
            //                                  blue: 180.0/255.0))
            //                .opacity(0.4)
            //                .navigationViewStyle(.automatic)
            
        }
    }
}

// class to make the video loop
class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Load the resource -> h
        let fileUrl = Bundle.main.url(forResource: "FilmNegatives", withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
        // Start the movie
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}


struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}
struct InitialSelectionView_Preview: PreviewProvider {
    static var previews: some View {
        InitialSelectionView()
    }
}


