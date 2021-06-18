
//
//import SwiftUI
//
////@main
//struct rxlulApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .frame(maxWidth: 300)
//        }
//    }
//}
//
//class VM: ObservableObject {
//    @Published var numbers: [Int] = []
//    @Published var hide = false
//    
//    init() {
//        
//    }
//    
//    func start() {
//        async { @MainActor in
////            for await n in Naturals()
////                .doOn(next: { print($0) })
////                .prefix(while: { $0 < 100 })
////                .filter({ _ in !self.hide })
////                .delay(1000000000)
////                .filter({ $0.isMultiple(of: 2) })
////                .map({ $0 * 2 })
////                .doOn(end: { print("end") })
////            {
////                self.numbers.insert(n, at: 0)
////            }
//            
//            try await Naturals()
//                .doOn(next: { print($0) })
//                .prefix(while: { $0 < 100 })
//                .filter({ _ in !self.hide })
//                .delay(1000000000)
//                .filter({ $0.isMultiple(of: 2) })
//                .map({ $0 * 2 })
//                .doOn(end: { print("end") })
//                .collect { element in
//                    self.numbers.insert(element, at: 0)
//                }
//        }
//    }
//}
//    
//struct ContentView: View {
//    @StateObject var vm = VM()
//    
//    var body: some View {
//        List {
//            Button("Start") {
//                vm.start()
//            }
//            Button(vm.hide ? "Show" : "Hide") {
//                vm.hide.toggle()
//            }
//            ForEach(vm.numbers, id: \.self) { n in
//                Text("\(n)")
//                    .font(.title)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//extension AsyncSequence {
//    func delay(_ duration: UInt64) -> DelaySequence<Self> {
//        DelaySequence(other: self, delay: duration)
//    }
//}
//
//struct DelaySequence<Other: AsyncSequence>: AsyncSequence {
//    typealias AsyncIterator = Iterator
//    typealias Element = Other.Element
//    
//    let other: Other
//    let delay: UInt64
//    
//    func makeAsyncIterator() -> Iterator {
//        Iterator(other: other.makeAsyncIterator(), delay: delay)
//    }
//    
//    struct Iterator: AsyncIteratorProtocol {
//        var other: Other.AsyncIterator
//        let delay: UInt64
//        
//        mutating func next() async rethrows -> Other.Element? {
//            guard let next = try await other.next() else { return nil }
//            await Task.sleep(delay)
//            return next
//        }
//    }
//}
//
//extension AsyncSequence {
//    func doOn(
//        next: @escaping (Element) -> Void = { _ in },
//        end: @escaping () -> Void = {}
//    ) -> OnAsyncSequence<Self> {
//        OnAsyncSequence(other: self, next: next, end: end)
//    }
//}
//struct OnAsyncSequence<Other: AsyncSequence>: AsyncSequence {
//    typealias AsyncIterator = Iterator
//    typealias Element = Other.Element
//    
//    let other: Other
//    let next: (Element) -> Void
//    let end: () -> Void
//    
//    func makeAsyncIterator() -> Iterator {
//        Iterator(other: other.makeAsyncIterator(), nextf: next, end: end)
//    }
//    
//    struct Iterator: AsyncIteratorProtocol {
//        var other: Other.AsyncIterator
//        let nextf: (Element) -> Void
//        let end: () -> Void
//        
//        mutating func next() async rethrows -> Other.Element? {
//            guard let value = try await other.next() else {
//                end()
//                return nil
//            }
//            nextf(value)
//            return value
//        }
//    }
//}
//
//extension AsyncSequence {
//    func collect(onNext: (Element) -> Void) async throws {
//        for try await element in self {
//            onNext(element)
//        }
//    }
//}
