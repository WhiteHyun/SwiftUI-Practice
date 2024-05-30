//
//  Component.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/15/24.
//

import CanvasClockView
import PathBubbleShapeView
import PersonalDynamicPropertyPracticeView
import SwiftUI
import WWDC_Data_Essentials_in_SwiftUI
import WWDC_Explore_Structured_Concurrency_in_Swift

// MARK: - RootComponent

struct RootComponent {
  let topics: [ViewItem] = [
    .init(
      category: .canvas,
      title: "Clock View ⏱️",
      caption: "Canvas를 활용한 시계 뷰",
      view: AnyView(ClockView())
    ),
    .init(
      category: .path,
      title: "Bubble Shape 💬",
      caption: "말풍선 Path 그리고 지우기",
      view: AnyView(BubbleView())
    ),
    .init(
      category: .wwdc,
      title: "Data Essentials in SwiftUI",
      caption: try! .init(markdown: "WWDC 영상 중 `Data Essentials in SwiftUI`에 관해 공부"),
      view: AnyView(BookCardListView())
    ),
    .init(
      category: .personal,
      title: "Dynamic Property ",
      caption: "Dynamic Property 학습",
      view: AnyView(DynamicPropertyPracticeView())
    ),
    .init(
      category: .wwdc,
      title: "Explore Structured Concurrency in Swift",
      caption: try! .init(markdown: "WWDC 영상 중 `Structured Concurrency`에 관해 공부"),
      view: AnyView(ExploreStructuredConcurrencyView())
    ),
  ]
}
