//
//  EasyLevel.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI

struct EasyLevel: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Background")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image("lit_bulb")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    Text("1:25")
                }
                //grid
                
            }
        }
    }
}
