//
//  File.swift
//  akariapp
//
//  Created by Shaurik Deshpande on 5/9/22.
//

import SwiftUI


struct MainView: View {
    var body: some View {
        NavigationView {
            MainMenu()
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}
