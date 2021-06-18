import Foundation

//@main
struct Timeout {
    static func main() async {
        await withTimeout(5) {
            await busyWork()
//            await busyWork()
//            await Task.sleep(.seconds(1))
        }
    }
}

func withTimeout(_ seconds: Double, _ f: @escaping () async -> ()) async {
    enum GroupResult {
        case cancel
        case ok
    }
    await withTaskGroup(of: GroupResult.self) { group in
        _ = group.asyncUnlessCancelled {
//            print("go to sleep")
            await Task.sleep(.seconds(seconds))
//            print("awake")
            return .cancel
        }
        _ = group.asyncUnlessCancelled {
            await f()
            return .ok
        }
        
        let result = await group.next()
        print("\(result!) finished first")
        group.cancelAll()
    }
}

func busyWork() async {
    print("Starting busyWork")
    for i in 0...100 {
        if Task.isCancelled { return }
        print(i)
        await nonCooperativeWork()
    }
//    for i in 1...100 {
//        guard !Task.isCancelled else { return }
//        print(i)
//        await Task.sleep(.seconds(1))
//    }
}

func nonCooperativeWork() async {
    await withUnsafeContinuation { continuation in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            continuation.resume()
        }
    }
}
