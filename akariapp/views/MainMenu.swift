//
//  File.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI
import AVFoundation

struct MainMenu: View {
    
    @State private var switchedOn = true
    @ObservedObject var model = GameModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack  {
                HStack {
                    Spacer()
                    NavigationLink(destination: Settings(model: model), label: {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                            .font(.system(size: 50, weight: .medium, design: .default))
                            .padding()
                    })
                }
                Spacer()
                
                BulbLogo(switchedOn: $switchedOn)
                
                Spacer()
                MenuButtons(model: model)
                    .padding()
            }
        }
    }
}

struct MenuButtons: View {
    
    @ObservedObject var model: GameModel
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: EasyLevel(model: model), label: {
                Text("Levels")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: HowToPlay(), label: {
                Text("How To Play")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: RateUs(), label: {
                Text("Rate Us")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: HighScores(model: model), label: {
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

struct HowToPlay: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Image("title_logo")
                    .resizable()
                    .scaledToFit()
                Text("The object of the game is to place “lightbulbs” in some grid squares. Each lightbulb illuminates every square in each of the four compass directions (imagine a rook in chess) up until a black cell is hit. Every grid square must be illuminated, but no two lightbulbs may illuminate each other. A black cell with a number indicates how many of the four surrounding cells have a light bulb.")
                    .padding()
                Image("title_logo")
                    .resizable()
                    .scaledToFit()
            }
            
        }
    }
}

struct RateUs: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Image("title_logo")
                    .resizable()
                    .scaledToFit()
                Text("We know you love the app ;)")
                    .padding()
                Image("title_logo")
                    .resizable()
                    .scaledToFit()
                Text("Made by Shaurik; Art by Catherine <3")
                Image("title_logo")
                    .resizable()
                    .scaledToFit()
            }
            
        }
    }
}

struct HighScores: View {
    @ObservedObject var model: GameModel
    
    var body: some View {
        List {
            ForEach(0...model.getPuzzleLibrarySize() - 1, id: \.self) { i in
                let best_time = model.library.getPuzzle(index: i).best_time
                    
                let minutes = best_time / (60 * 100)
                let seconds = best_time / 100
                let mseconds = best_time % 100

                let minutesString = String(format: "%02d", minutes)
                let secondsString = String(format: "%02d", seconds)
                let msecondsString = String(format: "%02d", mseconds)

                let timeText =  "\(minutesString):\(secondsString).\(msecondsString)"
                Text(best_time != Int.max ? "Puzzle \(i + 1): \(timeText)" : "Puzzle \(i + 1) not yet completed!")
            }
        }
        .background(Color("Background"))
    }
}

struct Settings: View {
    @ObservedObject var model: GameModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            Button(action: {
                model.fullReset()
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.black)
                    .frame(width: 200, height: 50)
                    .overlay(
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.red)
                            Text("Reset All Levels")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    )
            }

        }
    }
}
