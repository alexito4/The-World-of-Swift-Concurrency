import Foundation

// completion, non throwing
func fetchCards(_ completion: @escaping ([Card]) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        let jsonURL = Bundle.module.url(forResource: "set4-en_us", withExtension: "json")!
        let data = try! Data(contentsOf: jsonURL)
        let cards = try! JSONDecoder().decode([Card].self, from: data)
        DispatchQueue.main.async {
            completion(cards)
        }
    }
}

struct NoData: Error {}

func fetch(_ kp: KeyPath<Card.Asset, URL>, in asset: Card.Asset, _ completion: @escaping (Result<Data, Error>) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        do {
            let data = try Data(contentsOf: asset[keyPath: kp])
            DispatchQueue.main.async {
                completion(.success(data))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(NoData()))
            }
        }
    }
}
