//
//  ClockHandsCanvas.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/10/24.
//

import SwiftUI

struct ClockHandsCanvas: View {
  private let calendar: Calendar = .current
  private let date: Date

  init(date: Date) {
    self.date = date
  }

  var body: some View {
    Canvas { context, size in
      drawHands(context: context, size: size, date: date)
    }
  }

  private func drawHands(context: GraphicsContext, size: CGSize, date: Date) {
    // Date 컴포넌트 획득
    let components = calendar.dateComponents(in: .current, from: date)

    // The hour component is kept in the 0-11 range. For example, for 15:00:00, h is 3
    let hour: Double = .init(components.hour! % 12)

    // The minute component is in the 0-59 range
    let minute: Double = .init(components.minute!)

    // Nanoseconds are converted into seconds and added to the `s` variable.
    let second: Double = .init(components.second!) + .init(components.nanosecond!) / 1_000_000 / 1000

    // Angles for each clock hand, Angles include fractions of hour, minute and second.
    // For example for 14:30:00, the angle of the hour hand, will be exactly in the middle
    // between the 2 and 3 hour positions
    let secondAngle = second / 60 * 360
    let minuteAngle = (minute + (secondAngle / 360)) / 60 * 360
    let hourAngle = (hour + (minuteAngle / 360)) / 12 * 360

    // Canvas center point
    let middlePoint: CGPoint = .init(
      x: size.width * 0.5,
      y: size.height * 0.5
    )

    // Hour
    context.drawLayer { context in
      let width: CGFloat = size.width * 0.016 // clock hand width
      let offset: CGFloat = size.width * 0.075 // clock hand offset from center

      let path: Path = .init(
        .init(
          origin: .init(
            x: -width * 0.5,
            y: -offset
          ),
          size: .init(
            width: width,
            height: size.height * 0.5 * 0.58 + offset
          )
        )
      )
      context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
      context.rotate(by: .degrees(hourAngle + 180))
      context.addFilter(.shadow(radius: 3))
      context.fill(path, with: .color(.black))
    }

    // Minute
    context.drawLayer { context in
      let width: CGFloat = size.width * 0.016 // clock hand width
      let offset: CGFloat = size.width * 0.075 // clock hand offset from center

      let path: Path = .init(
        .init(
          origin: .init(
            x: -width * 0.5,
            y: -offset
          ),
          size: .init(
            width: width,
            height: size.height * 0.5 * 0.76 + offset
          )
        )
      )
      context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
      context.rotate(by: .degrees(minuteAngle + 180))
      context.addFilter(.shadow(radius: 3))
      context.fill(path, with: .color(.black))
    }

    // == Center black dot ==
    let dot1Diameter: CGFloat = size.width * 0.048
    let dot1Size: CGSize = .init(width: dot1Diameter, height: dot1Diameter)
    let dot1Origin: CGPoint = .init(
      x: middlePoint.x - dot1Diameter * 0.5,
      y: middlePoint.y - dot1Diameter * 0.5
    )
    let dot1Path: Path = Circle().path(in: .init(origin: dot1Origin, size: dot1Size))
    context.fill(dot1Path, with: .color(.black))

    // Second
    context.drawLayer { context in
      let width: CGFloat = size.width * 0.008 // clock hand width
      let offset: CGFloat = size.width * 0.15 // clock hand offset from center

      let path: Path = .init(
        .init(
          origin: .init(
            x: -width * 0.5,
            y: -offset
          ),
          size: .init(
            width: width,
            height: size.height * 0.5 * 0.7 + offset
          )
        )
      )
      context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
      context.rotate(by: .degrees(secondAngle + 180))
      context.addFilter(.shadow(radius: 3))
      context.fill(path, with: .color(.red))
    }

    // == Center gray dot ==
    let dot2Diameter: CGFloat = size.width * 0.02
    let dot2Size: CGSize = .init(width: dot2Diameter, height: dot2Diameter)
    let dot2Origin: CGPoint = .init(
      x: middlePoint.x - dot2Diameter * 0.5,
      y: middlePoint.y - dot2Diameter * 0.5
    )
    let dot2Path: Path = Circle().path(in: .init(origin: dot2Origin, size: dot2Size))
    context.fill(dot2Path, with: .color(.gray))
  }
}

#Preview {
  ClockView()
    .background(.gray)
}
