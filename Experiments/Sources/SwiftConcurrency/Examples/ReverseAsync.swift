import Foundation

//@main
struct ReverseAsync {
    static func main() {
        run {
            await asyncCalculation()
        } onCompletion: {
            print($0)
        }
        dispatchMain()
    }
}

func asyncCalculation() async -> Int {
    await Task.sleep(.seconds(2))
    return 5
}

func run<R>(_ f: @escaping () async -> R, onCompletion: @escaping (R) -> Void) {
    Task.detached {
        onCompletion(await f())
    }
}
