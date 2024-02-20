//
//  RingProgressView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/19/24.
//

import SwiftUI

// MARK: - RingProgressView

struct RingProgressView: View {
  private let value: Double

  init(value: Double) {
    self.value = value
  }

  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: Metrics.lineWidth)
        .frame(width: Metrics.size, height: Metrics.size)
        .foregroundStyle(.gray.opacity(0.1))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)

      Circle()
        .stroke(lineWidth: 0.34)
        .frame(width: Metrics.size - Metrics.lineWidth - 1, height: Metrics.size - Metrics.lineWidth - 1)
        .foregroundStyle(
          LinearGradient(
            gradient: .init(
              colors: [
                .black.opacity(0.3),
                .clear,
              ]
            ),
            startPoint: .bottomTrailing,
            endPoint: .topLeading
          )
        )
        .overlay {
          Circle()
            .stroke(.black.opacity(0.1), lineWidth: 2)
            .blur(radius: 5)
            .mask {
              Circle()
                .foregroundStyle(
                  LinearGradient(
                    gradient: .init(
                      colors: [
                        .black,
                        .clear,
                      ]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                  )
                )
            }
        }

      Circle()
        .trim(from: 0, to: value)
        .stroke(style: .init(lineWidth: Metrics.lineWidth, lineCap: .round))
        .frame(width: Metrics.size, height: Metrics.size)
        .rotationEffect(.degrees(-90))
        .foregroundStyle(
          LinearGradient(
            gradient: .init(
              colors: [
                .purple,
                .blue,
              ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .shadow(radius: 3)
    }
    .padding()
  }
}

// MARK: RingProgressView.Metrics

private extension RingProgressView {
  enum Metrics {
    static let size: CGFloat = 40
    static let lineWidth: CGFloat = 6
  }
}

#Preview {
  RingProgressView(value: 23 / 100)
}
