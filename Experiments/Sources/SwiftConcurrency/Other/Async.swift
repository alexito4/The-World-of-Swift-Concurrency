import _Concurrency
import Foundation

func fetchCards() async -> [Card] {
    await withUnsafeContinuation() { c in
        fetchCards() { cards in
            c.resume(returning: cards)
        }
    }
}

func fetch(_ kp: KeyPath<Card.Asset, URL>, in asset: Card.Asset) async throws -> Data {
    try await withUnsafeThrowingContinuation() { c in
        fetch(kp, in: asset) { result in
            // very nice api on the continuation
            c.resume(with: result)
        }
    }
}
