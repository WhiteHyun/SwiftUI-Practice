//
//  View+heightChangePreference.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 5/18/24.
//

import SwiftUI

extension View {
  @ViewBuilder
  func heightChangePreference(completion: @escaping (CGFloat) -> Void) -> some View {
    overlay {
      GeometryReader { geometry in
        Color.clear
          .preference(key: SizeKey.self, value: geometry.size.height)
          .onPreferenceChange(SizeKey.self) { value in
            completion(value)
          }
      }
    }
  }
}
