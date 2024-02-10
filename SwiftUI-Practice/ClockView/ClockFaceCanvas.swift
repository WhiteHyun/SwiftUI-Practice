//
//  ClockFaceCanvas.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/10/24.
//

import SwiftUI

// MARK: - ClockFaceCanvas

struct ClockFaceCanvas: View {
  var body: some View {
    Canvas { context, size in
      drawFace(context: context, size: size)
      drawTicks(context: context, size: size)
      drawNumbers(context: context, size: size)
      drawBrand(context: context, size: size)
    }
  }

  private func drawFace(context: GraphicsContext, size: CGSize) {
    let rect: CGRect = .init(origin: .zero, size: size)
      .insetBy(dx: size.width * Metrics.inset, dy: size.height * Metrics.inset)

    let circlePath = Circle().path(in: rect)

    // Border
    context.stroke(
      circlePath,
      with: .linearGradient(
        .init(colors: [.gray, .black]),
        startPoint: .zero,
        endPoint: .init(x: size.width, y: size.height)
      ),
      lineWidth: size.width * Metrics.clockLineWidth
    )

    // Background
    let gradient: Gradient = .init(
      stops: [
        .init(color: .white, location: 0),
        .init(color: .white, location: 0.9),
        .init(color: .gray, location: 0.95),
        .init(color: .black, location: 1.05),
      ]
    )
    context.fill(
      circlePath,
      with: .radialGradient(
        gradient,
        center: .init(x: size.width * 0.5, y: size.height * 0.5),
        startRadius: .zero,
        endRadius: size.width * 0.5 - size.width * 0.5 * Metrics.inset
      )
    )
  }

  private func drawTicks(context: GraphicsContext, size: CGSize) {
    let thinWidth = size.width * Metrics.tickThinWidth
    let thickWidth = size.width * Metrics.tickThickWidth

    let thinPath: Path = .init(
      .init(
        origin: .init(x: -thinWidth * 0.5, y: size.height * 0.41),
        size: .init(width: thinWidth, height: size.height * 0.025)
      )
    )
    let thickPath: Path = .init(
      .init(
        origin: .init(x: -thickWidth * 0.5, y: size.height * 0.40),
        size: .init(width: thickWidth, height: size.height * 0.038)
      )
    )

    for tick in 0 ..< 60 {
      var context = context
      context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
      context.rotate(by: .degrees(Double(tick) * (360 / 60) + 180))
      context.fill(tick % 5 == 0 ? thickPath : thinPath, with: .color(.black))
    }
  }

  private func drawNumbers(context: GraphicsContext, size: CGSize) {
    for h in 1 ... 12 {
      let hour = Double(h)
      let angle: Angle = .degrees(360 / (12 / (12 - hour)) + 180)

      let numberText: Text = .init("\(h)")
        .font(.custom("Futura", size: size.width * 0.1))
        .foregroundStyle(.black)

      let offset: CGPoint = .init(
        x: size.width * 0.5 + sin(Double(angle.radians)) * size.width * 0.33,
        y: size.height * 0.5 + cos(angle.radians) * size.width * 0.33
      )

      context.draw(numberText, at: offset, anchor: .center)
    }
  }

  private func drawBrand(context: GraphicsContext, size: CGSize) {
    let location: CGPoint = .init(
      x: size.width * 0.5,
      y: size.height * 0.65
    )

    let text = Text("SwiftUI-Lab")
      .font(
        .custom(
          "Futura Bold",
          size: size.width * 0.03
        )
      )

    context.draw(text, at: location, anchor: .center)
  }
}

// MARK: ClockFaceCanvas.Metrics

private extension ClockFaceCanvas {
  enum Metrics {
    /// Clock
    static let inset: CGFloat = 0.04
    static let clockLineWidth: CGFloat = 0.08

    /// Tick
    static let tickThinWidth: CGFloat = 0.004
    static let tickThickWidth: CGFloat = 0.012
  }
}

#Preview {
  ClockView()
    .background(.gray)
}
