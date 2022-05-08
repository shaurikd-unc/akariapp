//
//  ContentView.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct MainView: View {
    
    @State private var switchedOn = true
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack  {
                HStack {
                    Spacer()
                    NavigationLink(destination: Text("tbd - settings"), label: {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                            .font(.system(size: 50, weight: .medium, design: .default))
                            .padding()
                    })
                }
                Spacer()
                
                BulbLogo(switchedOn: $switchedOn)
                
                Spacer()
                MenuButtons()
                    .padding()
            }
        }
    }
}

struct MenuButtons: View {
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: Text("tbd - levels"), label: {
                Text("Levels")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: Text("tbd - how to play"), label: {
                Text("How To Play")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: Text("tbd - rate us"), label: {
                Text("Rate Us")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: Text("tbd - high scores"), label: {
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

struct BulbLogo: View {
    
    @Binding var switchedOn: Bool
    
    var body: some View {
        Image("title_logo")
            .resizable()
            .scaledToFit()
        
        Image(switchedOn ? "lit_bulb" : "bulb_logo")
            .padding(.horizontal)
            .onTapGesture {
                switchedOn.toggle()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
