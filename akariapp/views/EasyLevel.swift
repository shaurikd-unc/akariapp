//
//  EasyLevel.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI

struct EasyLevel: View {
    
    @ObservedObject var model = GameModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
//                HStack {
//                    Image("lit_bulb")
//                        .resizable()
//                        .scaledToFit()
//                    Spacer()
//                    Text("1:25")
//                }

                EasyGameGrid(model: model)
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
                                        Text(model.isLamp(r: r, c: c) ? "l" : " ")
                                            .frame(minWidth: 0, maxWidth: 15)
                                            .font(.system(size: 16))
                                            .padding()
                                            .foregroundColor(.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 0)
//                                                    .stroke(.white, lineWidth: 2)
                                                    .stroke(model.isLit(r: r, c: c) ? .yellow : .white, lineWidth: 2)
                                        )
                                    }
                            case .CLUE:
                                Text("\(model.getActivePuzzle().getClue(r: r, c: c))")
                                    .frame(minWidth: 0, maxWidth: 15)
                                    .font(.system(size: 16))
                                    .padding()
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color.black, lineWidth: 2)
                                )
                            case .WALL:
                                Text("w")
                                    .frame(minWidth: 0, maxWidth: 15)
                                    .font(.system(size: 16))
                                    .padding()
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                }
            }
        }
    }
}
