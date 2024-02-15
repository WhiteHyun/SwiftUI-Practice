//
//  Topic.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/15/24.
//

import Foundation

// MARK: - Subject

enum Subject: String, CaseIterable {
  case canvas
  case path
}

// MARK: - Topic

enum Topic: CaseIterable {
  case clockView
  case bubbleShape
}

// MARK: CustomStringConvertible

extension Topic: CustomStringConvertible {
  var description: String {
    switch self {
    case .clockView:
      "Clock View ⏱️"
    case .bubbleShape:
      "Bubble Shape 💬"
    }
  }
}
