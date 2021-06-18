
//
//import Foundation
//
////@main
//struct Structured {
//    static func main() async {
//        print("structured")
//        await sequentially()
//        
//        
//    }
//}
//
//func sequentially() async {
//    let handle = detach {
//        await compute(42)
//    }
//    whoKnowsWhatsHappening(handle)
//    print(await handle.get())
//    
//    //    let a = await compute(4)
////    let b = await compute(2)
////    let ansewr = a + b
////    print(ansewr)
////    return
////
////    let answer: Int = await withTaskGroup(of: Int.self) { group in
////        group.spawn {
////            await compute(4)
////        }
////        group.spawn {
////            await compute(2)
////        }
////        var result = 0
////        while let value = await group.next() {
////            result += value
////        }
////        for await value in group {
////          result += value
////        }
////
////        let result: Int = await group.reduce(0, +)
////        return result
////    }
////    print(answer)
//}
//
//func whoKnowsWhatsHappening(_ h: Task.Handle<Int, Never>) {
//    
//}
//
//func compute(_ x: Int) async -> Int {
//    x * 10 + 2
//}
