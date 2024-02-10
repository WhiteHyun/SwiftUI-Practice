//
//  ContentView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/10/24.
//

import SwiftUI

enum NavigatingViewEnum: String, CaseIterable {
  case canvasView
}

struct ContentView: View {

  var body: some View {
    NavigationStack {
      List(NavigatingViewEnum.allCases, id: \.rawValue) { subject in
        NavigationLink(subject.rawValue) {
          switch subject {
          case .canvasView:
            ClockView()
          }
        }
      }
    }
    .navigationTitle("Practice")
  }
}

#Preview {
  ContentView()
}
