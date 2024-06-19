//
//  ContentView.swift
//  NC2_SpriteKitGame
//
//  Created by 김상준 on 6/19/24.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    var body: some View {
        SpriteView(scene: StartScene())
//        SpriteView(scene: GameOverScene())
            .ignoresSafeArea()

    }
}

#Preview {
    HomeView()
}
