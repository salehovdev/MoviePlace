//
//  SplashView.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 24.05.25.
//

import SwiftUI

struct SplashView: View {
    @State private var nextView = false
    
    var body: some View {
        ZStack {
            if !nextView {
                splashContent
                    .transition(.move(edge: .leading))
            } else {
                ContentView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.5), value: nextView
        )
    }
    
    var splashContent: some View {
        ZStack(alignment: .leading) {
            RadialGradient(colors: [.yellow, .black], center: .topTrailing, startRadius: 5, endRadius: 600)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                Image(systemName: "movieclapper.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.white)
                Text("Welcome to MoviePlace")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .overlay (
                        Capsule(style: .continuous)
                            .frame(height: 3)
                            .offset(y: 5)
                            .foregroundStyle(.white)
                        , alignment: .bottom
                    )
                Text("This is #1 app for finding your favorite movies or series to watch. Let's find out🥳")
                    .fontWeight(.medium)
                Spacer()
                Spacer()
                
                Button {
                    withAnimation {
                        nextView.toggle()
                    }
                } label: {
                    Text("Next".uppercased())
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.yellow.opacity(0.8))
                        .clipShape(.rect(cornerRadius: 10))
                }
                .padding(30)
            }
            .multilineTextAlignment(.center)
        }
    }
}


#Preview {
    SplashView()
}
