//
//  ContentView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/10/24.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
  private let topics: [Subject: [Topic]]

  init(topics: [Subject: [Topic]]) {
    self.topics = topics
  }

  var body: some View {
    NavigationStack {
      List {
        ForEach(Subject.allCases, id: \.self) { section in
          Section(section.rawValue) {
            ForEach(topics[section] ?? [], id: \.self) { topic in
              NavigationLink(destination: destinationView(section: topic)) {
                Text("\(topic.description)")
              }
            }
          }
        }
      }
      .navigationTitle("SwiftUI-Practice")
    }
  }

  @ViewBuilder
  private func destinationView(section topic: Topic) -> some View {
    switch topic {
    case .clockView:
      ClockView()
    case .bubbleShape:
      BubbleView()
    case .dataEssentialsInSwiftUI:
      BookCardListView()
    case .dynamicProperty:
      DynamicPropertyPracticeView()
    }
  }
}

#Preview {
  ContentView(topics: RootComponent().topics)
}
