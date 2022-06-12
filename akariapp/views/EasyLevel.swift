//
//  EasyLevel.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI

struct EasyLevel: View {
        
    @ObservedObject var model: GameModel
    @State private var showSheet: Bool = false
    @State private var logoDragAmount = CGSize.zero
    
    var timeText: String {
        
        let minutes = model.time_taken / (60 * 100)
        let seconds = model.time_taken / 100
        let mseconds = model.time_taken % 100

        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        let msecondsString = String(format: "%02d", mseconds)

        return model.isSolved() ? "\(minutesString):\(secondsString).\(msecondsString)" : "\(minutesString):\(secondsString)"
    }
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Image("title_logo")
                    .resizable()
                    .scaledToFit()
                    .offset(logoDragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged {logoDragAmount = $0.translation}
                            .onEnded { _ in
                                withAnimation {
                                    logoDragAmount = .zero
                                }
                            }
                    )
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black)
                        .frame(width: 75, height: 50)
                        .overlay(
                            Text("Puzzle \(model.getActivePuzzleIndex() + 1)")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        )
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(model.isSolved() ? .green : .black)
                        .frame(width: 150, height: 50)
                        .overlay(
                            Text(timeText)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        )
                        .animation(.default, value: model.isSolved())
                }
                EasyGameGrid(model: model)
                    .onReceive(timer) { _ in
                        if !model.isSolved() {
                            model.time_taken += 1
                        }
                    }
                    .padding()
                HStack {
                    Button(action: {
                        model.resetPuzzle()
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
                    
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .overlay(
                                Text("Levels")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            )
                    }
                    .sheet(isPresented: $showSheet) {
                        List {
                            ForEach((0...model.progress), id: \.self) { number in
                                    Button(action: {
                                        model.setActivePuzzleIndex(index: number)
                                        showSheet.toggle()
                                        }) {
                                            Text("Puzzle \(number + 1)")
                                                .foregroundColor(.black)
                                    }
                            }
                            ForEach((model.progress + 1...model.getPuzzleLibrarySize() - 1), id: \.self) { number in
                                    Text("Puzzle \(number + 1)")
                                        .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Button(action: {
                        model.clickNextPuzzle()
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(model.canProgress() ? .black : .gray)
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
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(.black, lineWidth: 2)
                                    .frame(width: 45, height: 45)
                                    .background(model.isClueSatisfied(r: r, c: c) ? .black : .blue)
                                    .overlay(
                                        Text("\(model.getActivePuzzle().getClue(r: r, c: c))")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                    )
                            case .WALL:
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(.black, lineWidth: 2)
                                    .frame(width: 45, height: 45)
                                    .background(.black)
                        }
                    }
                }
            }
        }
    }
}
