
//fetchCards { cards in
//    print("Fetched \(cards.count) cards.")
//    let asset = cards[0].assets[0]
//    fetch(\.gameAbsolutePath, in: asset) { imageResult in
//        switch imageResult {
//        case .success(let data):
//            print("Image size: \(data.count)")
//            fetch(\.fullAbsolutePath, in: asset) { artResult in
//                switch artResult {
//                case .success(let data):
//                    print("Art size: \(data.count)")
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//        case .failure(let error):
//            print("Error: \(error)")
//        }
//    }
//}

//import _Concurrency
//
//func justGo() async {
//    print("go")
//    await waitandgo()
//    print("gone")
//}
//
//func waitandgo() async {
//    print("going to sleep")
//    sleep(5)
//    print("back from sleep")
//}
//
//@asyncHandler
//func main() {
////    Task.runDetached {
////        await justGo()
////    }
//    await justGo()
////    await print("after \(a) \(b)")
//}
//main()


//@asyncHandler
//func main() {
//    let cards = await fetchCards()
//    print("Fetched \(cards.count) cards.")
//    let asset = cards[0].assets[0]
//
//    do {
//        let imageData = try await fetch(\.gameAbsolutePath, in: asset)
//        print("Image size: \(imageData.count)")
//        let artData = try await fetch(\.fullAbsolutePath, in: asset)
//        print("Image size: \(artData.count)")
//    } catch {
//        print("Error: \(error)")
//    }
//}
//main()

//@asyncHandler
//func main() {
//    let cards = await fetchCards()
//    print("Fetched \(cards.count) cards.")
//    let asset = cards[0].assets[0]
//
//    do {
//        async let imageData = try fetch(\.gameAbsolutePath, in: asset)
//        async let artData = try fetch(\.fullAbsolutePath, in: asset)
//
//        let size = try await [imageData, artData]
//            .compactMap { $0 }
//            .map(\.count)
//            .reduce(0, +)
//        print("Assets total size: \(size)")
//
//    } catch {
//        print("Error: \(error)")
//    }
//}
//main()
