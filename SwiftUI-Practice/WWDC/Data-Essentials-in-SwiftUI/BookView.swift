//
//  BookView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 2/19/24.
//

import SwiftUI

private let numberFormatter: NumberFormatter = {
  let formatter = NumberFormatter()
  formatter.numberStyle = .decimal
  return formatter
}()

// MARK: - EditorConfig

struct EditorConfig {
  var isEditorPresented = false
  var note = ""
  var progress: Double = 0

  mutating func present(initialProgress: Double) {
    progress = initialProgress
    note = ""
    isEditorPresented = true
  }
}

// MARK: - BookView

struct BookView: View {
  @State private var editorConfig = EditorConfig()

  private let book: Book
  private let progress: Double

  init(book: Book, progress: Double) {
    self.book = book
    self.progress = progress
  }

  var body: some View {
    VStack {
      BookCard(book: book, progress: progress)
      Divider()
      Button(action: presentEditor) {
        Label(
          title: { Text("Update Progress") },
          icon: { Image(systemName: "book.circle") }
        )
      }
      .padding(.vertical, 10)
      .sheet(isPresented: $editorConfig.isEditorPresented) {
        ProgressEditor(editorConfig: $editorConfig)
          .presentationDetents([.fraction(0.4)])
      }
      Divider()
      HStack {
        Text("\(numberFormatter.string(from: (progress * 100).rounded() as NSNumber)!)%")
        Spacer()
        Text(.now, style: .date)
      }
      .padding(10)
      Divider()
        .padding(.leading, 10)
      Spacer()
    }
  }

  private func presentEditor() {
    editorConfig.present(initialProgress: progress)
  }
}

// MARK: - ProgressEditor

struct ProgressEditor: View {
  @Environment(\.dismiss) private var dismiss
  @Binding var editorConfig: EditorConfig
  var body: some View {
    VStack {
      HStack {
        Button("Cancel") {
          dismiss()
        }
        Spacer()
        Button("Save") {
          dismiss()
        }
      }
      Divider()
      HStack {
        Slider(value: $editorConfig.progress)
        Text("\(numberFormatter.string(from: (editorConfig.progress * 100).rounded() as NSNumber)!)%")
          .bold()
      }
      Text("NOTES:")
        .frame(maxWidth: .infinity, alignment: .leading)
      TextEditor(text: $editorConfig.note)
        .border(.gray)
    }
    .padding()
  }
}

#Preview {
  BookView(book: [Book].dummy.first!, progress: Double.random(in: 0 ... 1))
}
