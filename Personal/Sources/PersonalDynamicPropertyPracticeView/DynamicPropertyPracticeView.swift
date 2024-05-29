//
//  DynamicPropertyPracticeView.swift
//  SwiftUI-Practice
//
//  Created by 홍승현 on 5/18/24.
//

import OSLog
import SwiftUI

// MARK: - Capitalized

@propertyWrapper
struct Capitalized: DynamicProperty {
  @State private var value: String = ""

  init(wrappedValue: String) {
    self.wrappedValue = wrappedValue
  }

  var wrappedValue: String {
    get { value }
    nonmutating set {
      Logger().debug("\(newValue) updated")
      value = newValue.capitalized
    }
  }

  var projectedValue: Binding<String> {
    .init(
      get: { wrappedValue },
      set: { wrappedValue = $0 }
    )
  }
}

// MARK: - DynamicPropertyPracticeView

public struct DynamicPropertyPracticeView: View {
  @Capitalized var name = ""
  @State private var password: String = ""
  @State private var sheetHeight: CGFloat = .zero
  @State private var showSheet: Bool = false

  public init() {
  }

  public var body: some View {
    ZStack {
      Image(.background)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .ignoresSafeArea()

      Spacer()
        .background(
          .linearGradient(
            stops: [
              .init(color: .black, location: 0.01),
              .init(color: .clear, location: 0.5),
            ],
            startPoint: .bottom,
            endPoint: .top
          )
        )

      VStack {
        Spacer()
        Button("Create Account") {
          showSheet.toggle()
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
      }
      .padding(30)
    }
    .sheet(isPresented: $showSheet) {
      GeometryReader { proxy in
        let size = proxy.size

        signUpView(size)
      }
      .presentationCornerRadius(30)
      .presentationDetents(sheetHeight == .zero ? [.medium] : [.height(sheetHeight)])
    }
    .navigationBarBackButtonHidden()
  }

  var attributedSubtitle: AttributedString {
    let string = "Join our community\nto support a greener future"
    var attributeString = AttributedString(stringLiteral: string)
    if let range = attributeString.range(of: "a greener future") {
      attributeString[range].foregroundColor = .black
      attributeString[range].font = .callout.bold()
    }

    return attributeString
  }

  @ViewBuilder
  private func signUpView(_ size: CGSize) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Embrace the serenity of nature's green sanctuary")
        .font(.title.bold())
        .fixedSize(horizontal: false, vertical: true)

      // Custom Attributed SubTitle
      Text(attributedSubtitle)
        .font(.callout)
        .foregroundStyle(.gray)
        .fixedSize(horizontal: false, vertical: true)

      CustomTextField(icon: "person", hint: "Name", text: $name, isPassword: false)
        .padding(.top, 20)
      CustomTextField(icon: "lock", hint: "*****", text: $password, isPassword: true)
        .padding(.top, 20)
    }
    .padding(15)
    .padding(.horizontal, 10)
    .padding(.top, 15)
    .padding(.bottom, 130)
    .overlay(alignment: .bottom) {
      VStack(spacing: 15) {
        Group {
          HStack(spacing: 4) {
            Text("Already having an account?")
              .foregroundStyle(.gray)
            Button("Login") {
            }
            .tint(.green)
          }
        }
        .font(.callout)
        .textScale(.secondary)
        .padding(.bottom, 15)

        Text("By signing up, you're agreeing to our **[Terms & Condition](https://apple.com)** and **[Privacy Policy](https://apple.com)**")
          .font(.caption)
          .tint(.red)
          .foregroundStyle(.gray)
          .transition(.offset(y: 100))
      }
      .padding(.bottom, 15)
      .padding(.horizontal, 20)
      .multilineTextAlignment(.center)
      .frame(width: size.width)
    }
    .frame(width: size.width, alignment: .leading)
    .heightChangePreference { height in
      sheetHeight = height
    }
  }
}
