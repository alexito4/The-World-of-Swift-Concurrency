
//
//import Foundation
//
////@main
//struct AsyncSequenceExample {
//    static func main() async {
//        // async just let's you return one thing asyncronosuly,
//        // we need a sequence to return multiple things.
//        // AsyncSequence let's us await on each element instead of the entire sequence.
//        let url = Bundle.module.url(forResource: "set4-en_us", withExtension: "json")!
//        for line in await url.lines() {
//            print(line)
//        }
//        for await line in url.lines() {
//            print(line)
//        }
//        var iterator = url.lines().makeAsyncIterator()
//        while let line = await iterator.next() {
//            print(line)
//        }
//        // for await in
////        async {
////            for await i in Naturals() {
////                print("-> \(i)")
////            }
////        }
////        for await i in Naturals() {
////            print(i)
////        }
//        // Most Sequence functions are available on AsyncSequences
//        // for example to limit the number we get we can prefix
//        for await i in Naturals().prefix(10) {
//            print(i)
//        }
//        // but we also have the high order functions that let's us replace loops with succint functions like reduce
//        print("Counting...")
//        let total = await Naturals()
//            .prefix(5)
//            .map({ $0 * 2 })
//            .reduce("", { $0 + "\($1)" }) // ! one liner, no loops
//        print(total)
//    }
//}
//
//struct Naturals: AsyncSequence {
//    typealias Element = Int
//    
//    func makeAsyncIterator() -> Iterator { // can't use some AsyncIteratorProtocol because of the associated type
//        Iterator()
//    }
//    
//    struct Iterator: AsyncIteratorProtocol {
//        var i = 0
//        mutating func next() async -> Int? {
//            guard !Task.isCancelled else { return nil }
//            await Task.sleep(seconds: Double.random(in: 0.4...1.1))
//            i += 1
//            return i
//        }
//    }
//}
//
//extension URL {
//    func lines() async -> Lines {
//        Lines(url: self)
//    }
//    
//    func lines() -> AsyncLines {
//        AsyncLines(url: self)
//    }
//}
//struct Lines: Sequence {
//    let url: URL
//    
//    func makeIterator() -> some IteratorProtocol {
//        var lines = (try? String(contentsOf: url)
//            .split(separator: "\n")) ?? []
//        return AnyIterator<String>() {
//            if lines.isEmpty {
//                return nil
//            }
//            return String(lines.removeFirst())
//        }
//    }
//}
//
//struct AsyncLines: AsyncSequence {
//    typealias Element = String
//
//    let url: URL
//    
//    func makeAsyncIterator() -> Iterator {
//        Iterator(url: url)
//    }
//    
//    struct Iterator: AsyncIteratorProtocol {
//        let url: URL
//        var lines: [String.SubSequence] // FAKE
//        
//        init(url: URL) {
//            self.url = url
//            self.lines = (try? String(contentsOf: url)
//                .split(separator: "\n")) ?? []
//        }
//        
//        mutating func next() async -> String? {
//            if lines.isEmpty {
//                return nil
//            }
//            return String(lines.removeFirst())
//        }
//    }
//}
//
//extension Task where Success == Never, Failure == Never {
//    static func sleep(seconds: Double) async {
//        await Self.sleep(.seconds(seconds))
//    }
//}
//

