//
//  ClockView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/10/24.
//

import SwiftUI

// MARK: - ClockView

public struct ClockView: View {
  @State private var isEditing: Bool = false
  @State private var timeInterval: TimeInterval = Constants.timeLineInterval
  public init() {
  }

  public var body: some View {
    GeometryReader { proxy in
      VStack {
        HStack {
          Spacer()
          ZStack {
            ClockFaceCanvas()
            TimelineView(.animation(minimumInterval: timeInterval)) { timeline in
              ClockHandsCanvas(date: timeline.date)
            }
          }
          .frame( // 항상 정사각형 모양이 되도록.
            width: min(proxy.size.width, proxy.size.height),
            height: min(proxy.size.width, proxy.size.height)
          )
          Spacer()
        }
        Spacer()
          .frame(height: 100)
        Text("\(timeInterval)")
          .foregroundStyle(isEditing ? .orange : .green)
        Slider(
          value: $timeInterval,
          in: 0.05 ... 1
        ) { editing in
          isEditing = editing
        }
      }
    }
    .padding(Metrics.padding)
    .background(.gray)
  }
}

private extension ClockView {
  enum Constants {
    static let timeLineInterval: TimeInterval = 1
  }

  enum Metrics {
    static let padding: CGFloat = 20
  }
}
