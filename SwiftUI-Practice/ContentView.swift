//
//  ContentView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/10/24.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
  private let topics: [ViewItem]

  init(topics: [ViewItem]) {
    self.topics = topics
  }

  var body: some View {
    NavigationStack {
      List {
        ForEach(Category.allCases, id: \.self) { category in
          Section(category.rawValue.capitalized) {
            ForEach(topics.filter { $0.category == category }) { item in
              NavigationLink(destination: item.view) {
                VStack(alignment: .leading) {
                  Text(item.title)
                    .font(.headline)
                  Text(item.caption)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
              }
            }
          }
        }
      }
      .navigationTitle("SwiftUI-Practice")
    }
  }
}

#Preview {
  ContentView(topics: RootComponent().topics)
}
