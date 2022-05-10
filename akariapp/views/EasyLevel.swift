//
//  EasyLevel.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI

struct EasyLevel: View {
    
    let model = GameModel()
    
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

                EasyGameGrid(controller: GameController(model: model))
                
            }
        }
    }
}

struct EasyGameGrid: View {
    
    let controller: GameController
    
    var body: some View {
        VStack {
            ForEach(0...6, id: \.self) {r in
                HStack {
                    ForEach(0...6, id: \.self) {c in
//                        switch(controller.getActivePuzzle().getCellType(r: r, c: c)) {
//                            case .CORRIDOR:
//                                break
//                            case .CLUE:
//                                break
//                            case .WALL:
//                                break
//                        }

                        Button(action: {
                            controller.clickCell(r: r, c: c)
                            }) {
                                Text("")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color.white, lineWidth: 2)
                                )
                            }
                    }
                }
            }
        }
    }
}
