//
//  ContentView.swift
//  BunnyJump
//
//  Created by 김상준 on 6/13/24.
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
