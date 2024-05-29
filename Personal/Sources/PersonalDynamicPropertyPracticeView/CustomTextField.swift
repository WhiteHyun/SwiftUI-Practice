//
//  CustomTextField.swift
//
//
//  Created by 홍승현 on 5/29/24.
//

import SwiftUI

struct CustomTextField: View {
  let icon: String
  let hint: String
  @Binding var text: String
  let isPassword: Bool

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      if isPassword {
        SecureField(hint, text: $text)
      } else {
        TextField(hint, text: $text)
      }
      Divider()
    }
    .overlay(alignment: .trailing) {
      Image(systemName: icon)
        .foregroundStyle(.gray)
    }
  }
}
