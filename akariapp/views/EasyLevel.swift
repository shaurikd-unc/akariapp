//
//  EasyLevel.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI

struct EasyLevel: View {
    
    @ObservedObject var model = GameModel()
    
    @State var time_taken = 0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text("\(Int(time_taken / 100)):\(time_taken % 100) secs")
                    .onReceive(timer) { _ in
                        if !model.isSolved() {
                            time_taken += 1
                        }
                    }
                EasyGameGrid(model: model)
                    .padding()
                HStack {
                    Button(action: {
                        model.resetPuzzle()
                        time_taken = 0
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: "repeat.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                )
                    }
                    
                    NavigationLink(destination: Text("tbd - easy level select"), label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .frame(width: 200, height: 50)
                                .overlay(
                                    Text("Levels")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                )
                    })
                    
                    Button(action: {
                        model.clickNextPuzzle()
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                )
                    }
                    
                }
                    .padding()
            }
        }
    }
}

struct EasyGameGrid: View {
    
    @ObservedObject var model: GameModel
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(0...6, id: \.self) {r in
                HStack(spacing: 1){
                    ForEach(0...6, id: \.self) {c in
                        switch(model.getActivePuzzle().getCellType(r: r, c: c)) {
                            case .CORRIDOR:
                                Button(action: {
                                    model.clickCell(r: r, c: c)
                                    }) {
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(model.isLamp(r: r, c: c) ? (model.isLampIllegal(r: r, c: c) ? .red : .black) : .black, lineWidth: 2)
                                            .frame(width: 45, height: 45)
                                            .background(model.isLit(r: r, c: c) ? .init(red: 1, green: 1, blue: 1, opacity: 0.5) : Color("Background"))
                                            .overlay(
                                                !model.isLamp(r: r, c: c) ? nil : Image("drawn_bulb")
                                                    .resizable()
                                                    .frame(width: 45, height: 45)
                                            )
                                    }
                            case .CLUE:
                                Rectangle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(model.isClueSatisfied(r: r, c: c) ? .black : .blue)
                                    .overlay(
                                        Text("\(model.getActivePuzzle().getClue(r: r, c: c))")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                    )
                            case .WALL:
                                Rectangle()
                                    .frame(width: 45, height: 45)
                        }
                    }
                }
            }
        }
    }
}
