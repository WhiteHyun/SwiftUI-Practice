//
//  ViewItem.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 5/29/24.
//

import SwiftUI

// MARK: - Topic

struct ViewItem: Identifiable {
  let id: UUID
  let category: Category
  let title: String
  let caption: String
  let view: AnyView

  init(id: UUID = .init(), category: Category, title: String, caption: String, view: AnyView) {
    self.id = id
    self.category = category
    self.title = title
    self.caption = caption
    self.view = view
  }
}
