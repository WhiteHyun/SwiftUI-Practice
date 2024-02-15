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
}

// MARK: - Topic

enum Topic: CaseIterable {
  case clockView
}

extension Topic: CustomStringConvertible {
  var description: String {
    switch self {
    case .clockView:
      return "Clock View ⏱️"
    }
  }
}
