//
//  ExploreStructuredConcurrencyView.swift
//
//
//  Created by 홍승현 on 5/29/24.
//

import Observation
import SwiftUI

// MARK: - ThumbnailFailedError

struct ThumbnailFailedError: Error {
}

// MARK: - Interactor

@Observable
private final class Interactor: NSObject, URLSessionTaskDelegate {
  private(set) var images: [UIImage] = [
    .init(systemName: "photo")!,
    .init(systemName: "photo")!,
    .init(systemName: "photo")!,
    .init(systemName: "photo")!,
    .init(systemName: "photo")!,
  ]

  @ObservationIgnored
  let ids: [String] = [
    "4k-minecraft-37440",
    "4k-minecraft-37441",
    "4k-minecraft-37442",
    "4k-minecraft-37443",
    "4k-minecraft-37444",
  ]
  private(set) var progresses: [Double] = [0, 0, 0, 0, 0]
  private var observations: [NSKeyValueObservation] = []

  func fetchOneThumbnail(withID id: String) async throws -> UIImage {
    let imageReq = imageRequest(for: id)
    let metadataReq = metadataRequest(for: id)

    async let (data, _) = URLSession.shared.data(for: imageReq, delegate: self)
    async let (metadata, _) = URLSession.shared.data(for: metadataReq, delegate: self)

    guard let size = try await parseSize(from: metadata),
          let image = try await UIImage(data: data)?.byPreparingThumbnail(ofSize: size) else {
      throw ThumbnailFailedError()
    }

    return image
  }

  private func reset() {
    images = [
      .init(systemName: "photo")!,
      .init(systemName: "photo")!,
      .init(systemName: "photo")!,
      .init(systemName: "photo")!,
      .init(systemName: "photo")!,
    ]
    progresses = [0, 0, 0, 0, 0]
    for observation in observations {
      observation.invalidate()
    }
    observations.removeAll(keepingCapacity: true)
  }

  func updateImagesSerially() async {
    reset()
    do {
      for (index, id) in ids.enumerated() {
        try Task.checkCancellation()
        images[index] = try await fetchOneThumbnail(withID: id)
      }
    } catch {
      debugPrint("Failed to fetch thumbnails serially: \(error)")
    }
  }

  func updateImagesInParallel() async {
    reset()
    do {
      try await withThrowingTaskGroup(of: (Int, UIImage).self) { group in
        for (index, id) in ids.enumerated() {
          group.addTask {
            try await (index, self.fetchOneThumbnail(withID: id))
          }
        }

        for try await (index, thumbnail) in group {
          self.images[index] = thumbnail
        }
      }

    } catch {
      debugPrint("Failed to fetch thumbnails in parallel: \(error)")
    }
  }

  private func imageRequest(for id: String) -> URLRequest {
    URLRequest(url: URL(string: "https://wallpaperaccess.com/download/\(id)")!)
  }

  private func metadataRequest(for _: String) -> URLRequest {
    URLRequest(url: URL(string: "https://leetcode.com/graphql")!)
  }

  private func parseSize(from _: Data) -> CGSize? {
    CGSize(width: 100, height: 100)
  }

  func urlSession(_: URLSession, didCreateTask task: URLSessionTask) {
    guard let index = ids.enumerated().first(where: { task.currentRequest?.url?.lastPathComponent == $0.element })?.offset else {
      debugPrint("Invalid path")
      return
    }

    let observation = task.progress.observe(\.fractionCompleted) { [weak self] progress, _ in
      self?.progresses[index] = progress.fractionCompleted
    }

    observations.append(observation)
  }
}

// MARK: - ExploreStructuredConcurrencyView

public struct ExploreStructuredConcurrencyView: View {
  @State private var interactor = Interactor()

  public init() {
  }

  public var body: some View {
    VStack {
      ForEach(0 ..< 5, id: \.self) { index in
        HStack {
          Image(uiImage: interactor.images[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)

          ProgressView(value: interactor.progresses[index])
        }
      }
      Group {
        Button("Serial load") {
          Task {
            await interactor.updateImagesSerially()
          }
        }
        .buttonStyle(.borderedProminent)

        Button("Parallel load") {
          Task {
            await interactor.updateImagesInParallel()
          }
        }
        .buttonStyle(.borderedProminent)
      }
    }
  }
}

#Preview {
  ExploreStructuredConcurrencyView()
}
