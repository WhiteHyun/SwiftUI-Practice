//
//  BookCard.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/19/24.
//

import SwiftUI

// MARK: - BookCover

struct BookCover: View {
  let imageURL: String

  init(_ imageURL: String) {
    self.imageURL = imageURL
  }

  var body: some View {
    AsyncImage(url: URL(string: imageURL)) { image in
      image.resizable()
        .aspectRatio(contentMode: .fit)
    } placeholder: {
      ProgressView()
    }
    .frame(width: 60)
    .shadow(radius: 3)
    .padding()
  }
}

// MARK: - TitleText

struct TitleText: View {
  private let title: String

  init(_ title: String) {
    self.title = title
  }

  var body: some View {
    Text(title)
      .font(.headline)
  }
}

// MARK: - AuthorText

struct AuthorText: View {
  private let author: String

  init(_ author: String) {
    self.author = author
  }

  var body: some View {
    Text(author)
      .font(.subheadline)
      .foregroundStyle(.gray)
  }
}

// MARK: - BookCard

struct BookCard: View {
  let book: Book
  let progress: Double

  var body: some View {
    HStack {
      BookCover(book.coverName)
      VStack(alignment: .leading) {
        TitleText(book.title)
        AuthorText(book.author)
      }
      Spacer()
      RingProgressView(value: progress)
    }
  }
}

#Preview {
  BookCard(
    book: .init(
      coverName: "https://cdn.kobo.com/book-images/d1d264bb-edf9-4405-ab53-eb13f82342ab/1200/1200/False/great-expectations-398.jpg",
      title: "Great Expectations",
      author: "Charles Dickens"
    ),
    progress: 0.23
  )
}
