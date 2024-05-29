//
//  BubbleView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/15/24.
//

import SwiftUI

public struct BubbleView: View {
  @State var drawFraction: CGFloat = 0

  public init() {
  }

  public var body: some View {
    VStack {
      BubbleShape()
        .trim(from: 0, to: drawFraction)
        .stroke(.gray, lineWidth: 3)
        .animation(.default, value: drawFraction)
        .frame(width: 150, height: 100)
        .padding(.bottom, 50)

      Button(drawFraction > 0.0 ? "Hide" : "Show") {
        drawFraction = drawFraction > 0.0 ? 0.0 : 1.0
      }
      .tint(Color.gray)
    }
  }
}
