//
//  BubbleShape.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/15/24.
//

import SwiftUI

struct BubbleShape: Shape {
  private let cornerRadius: CGFloat = 12
  private let arrowRectSize: CGFloat = 20
  private let arcLength: CGFloat = 12

  /// 0.0 = left, 0.5 = center, 1.0 = right
  private let arrowOffsetFraction: CGFloat = 0.5

  private func baseXPos(for rect: CGRect) -> CGFloat {
    (rect.maxX - cornerRadius - cornerRadius - arrowRectSize) * arrowOffsetFraction + cornerRadius
  }

  func path(in rect: CGRect) -> Path {
    let roundedRect = Path(roundedRect: rect, cornerRadius: cornerRadius)
    let arrowPath = Path { p in
      p.move(to: .init(x: baseXPos(for: rect), y: rect.maxY))
      p.addLine(to: .init(
        x: baseXPos(for: rect) + arrowRectSize - arcLength,
        y: rect.maxY + arrowRectSize - arcLength
      ))
      p.addQuadCurve(
        to: .init(
          x: baseXPos(for: rect) + arrowRectSize,
          y: rect.maxY + arrowRectSize - arcLength
        ),
        control: .init(
          x: baseXPos(for: rect) + arrowRectSize,
          y: rect.maxY + arrowRectSize
        )
      )
      p.addLine(to: .init(x: baseXPos(for: rect) + arrowRectSize, y: rect.maxY))
      p.closeSubpath()
    }
    let combinedCGPath = roundedRect.cgPath.union(arrowPath.cgPath)
    let combinedPath = Path(combinedCGPath)
    return combinedPath
  }
}
