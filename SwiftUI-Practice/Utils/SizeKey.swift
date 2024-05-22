//
//  SizeKey.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 5/18/24.
//

import SwiftUI

struct SizeKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
