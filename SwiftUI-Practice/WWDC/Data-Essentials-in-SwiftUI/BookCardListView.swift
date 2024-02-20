//
//  BookCardListView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/19/24.
//

import SwiftUI

struct BookCardListView: View {
  private var books: [Book] = .dummy

  var body: some View {
    List {
      ForEach(books) { book in
        let value = Double.random(in: 0 ... 1)
        NavigationLink {
          BookView(book: book, progress: value)
        } label: {
          BookCard(book: book, progress: value)
        }
      }
    }
    .listStyle(.plain)
    .navigationTitle("Currently Reading")
  }
}

#Preview {
  BookCardListView()
}
