//
//  ContentView.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct MainView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack  {
                HStack {
                    Spacer()
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                        .font(.system(size: 50, weight: .medium, design: .default))
                        .padding()
                }
                Spacer()
                Image("title_logo")
                    .resizable()
                    .scaledToFit()
                Image("lit_bulb")
                    .padding(.horizontal)
                
                Spacer()
                MenuButtons()
                    .padding()
            }
        }
    }
}

struct MenuButtons: View {
    var body: some View {
        VStack(spacing: 30) {
            NavigationLink(destination: Text("Levels"), label: {
                Text("Levels")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: Text("How to play"), label: {
                Text("How To Play")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: Text("Rate us"), label: {
                Text("Rate Us")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: Text("High scores"), label: {
                Text("High Scores")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
