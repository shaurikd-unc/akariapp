//
//  Levels.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI

struct LevelSelect: View {
    
    @ObservedObject var model: GameModel

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                NavigationLink(destination: EasyLevel(model: model), label: {
                    Text("EASY")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                NavigationLink(destination: Text("tbd - medium levels"), label: {
                    Text("MEDIUM - coming soon!")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                NavigationLink(destination: Text("tbd - hard levels"), label: {
                    Text("HARD - coming soon!")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
    }
}
