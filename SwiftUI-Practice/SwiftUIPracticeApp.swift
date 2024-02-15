//
//  SwiftUIPracticeApp.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/10/24.
//

import SwiftUI

@main
struct SwiftUIPracticeApp: App {
  private let components: RootComponent = .init()

  var body: some Scene {
    WindowGroup {
      ContentView(topics: components.topics)
    }
  }
}
