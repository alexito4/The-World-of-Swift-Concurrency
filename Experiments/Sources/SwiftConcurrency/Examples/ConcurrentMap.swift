import Foundation


//@main
struct ConcurrentMap {
    static func main() async {
        let result = await Array(1...500).concurrentMap { i -> Int in
            await Task.sleep(.seconds(Double((1...3).randomElement()!)))
            return i * 2
        }
        print(result)
    }
}

extension Array {
    func concurrentMap<R>(_ f: @escaping (Element) async -> R) async -> Array<R> {
        return await withTaskGroup(of: (Index, R).self, returning: Array<R>.self) { group in
            for (i, element) in self.enumerated() {
                group.async {
                    return await (i, f(element))
                }
            }
            
            var results = Array<(Index, R)>()
            results.reserveCapacity(self.count)
            return await group.reduce(into: results) { $0.append($1) }
                .sorted(by: { $0.0 < $1.0 })
                .map(\.1)
        }
    }
}
