//
//  Book.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/19/24.
//

import Foundation

// MARK: - Book

struct Book: Hashable, Identifiable {
  let id: UUID = .init()
  let coverName: String
  let title: String
  let author: String
}

extension [Book] {
  static var dummy: [Book] {
    [
      .init(
        coverName: "https://cdn.kobo.com/book-images/d1d264bb-edf9-4405-ab53-eb13f82342ab/1200/1200/False/great-expectations-398.jpg",
        title: "Great Expectations",
        author: "Charles Dickens"
      ),
      .init(
        coverName: "https://m.media-amazon.com/images/I/71Q1tPupKjL._AC_UF1000,1000_QL80_.jpg",
        title: "Pride and Prejudice",
        author: "Jane Austen"
      ),
      .init(
        coverName: "https://m.media-amazon.com/images/I/71KztWdDVEL._AC_UF1000,1000_QL80_.jpg",
        title: "Little Women",
        author: "Louisa May Alcott"
      ),
      .init(
        coverName: "https://m.media-amazon.com/images/I/81unikMK30L._AC_UF1000,1000_QL80_.jpg",
        title: "Wuthering Heights",
        author: "Emily Bronte"
      ),
      .init(
        coverName: "https://m.media-amazon.com/images/I/51aV053NRjL._AC_UF1000,1000_QL80_.jpg",
        title: "Moby Dick",
        author: "Herman Melville"
      ),
    ]
  }
}
