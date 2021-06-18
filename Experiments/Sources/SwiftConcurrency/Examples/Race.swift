import Foundation

@main
struct Race {
    static func main() async {
        print("Start")
//        print(await doSomething("first", for: .seconds(2)))
        let value = await firstOf {
            await doSomething("first", for: .seconds(10))
        } or: {
            await doSomething("second", for: .seconds(1))
        }
        
        print(value)
    }
}

func doSomething(_ name: String, for duration: UInt64) async -> String {
    await Task.sleep(duration)
    return name
}

func firstOf<R>(
    _ f1: @escaping () async -> R,
    or f2: @escaping () async -> R
) async -> R {
    await withTaskGroup(of: R.self, body: { group in
        group.spawn {
            await f1()
        }
        group.spawn {
            await f2()
        }
        guard let first = await group.next() else {
            fatalError()
        }
        print("got \(first)")
        group.cancelAll()
        return first
    })
}
