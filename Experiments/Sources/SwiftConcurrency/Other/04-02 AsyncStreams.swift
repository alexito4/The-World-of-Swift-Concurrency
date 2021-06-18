
//
//import Foundation
//
////@main
//struct AsyncStreamExample {
//    static var timer: Timer!
//    static func main() async throws {
//        print("Start")
//        for try await date in Timer.repeating(every: 1).prefix(5) {
//            print(date)
//        }
//        print("Done!")
//        RunLoop.main.run()
//    }
//}
//
//extension Timer {
//
//    static func repeating(every: TimeInterval) -> some AsyncSequence {
//        AsyncStream<Date> { continuation in
//            let timer = scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
//                print("timer!")
//                continuation.yield(Date())
//            })
//            continuation.onTermination = { @Sendable _ in
//                timer.invalidate()
//            }
//        }
//    }
//}
////extension Timer: @unchecked Sendable {}
//
//
//
//import AppKit
////let recognizer = NSSpeechRecognizer()!
////recognizer.commands = ["hello"]
////for try await command in recognizer.recognizedCommands() {
////    print("Detected command: \(command)")
////}
//extension NSSpeechRecognizer {
//    func recognizedCommands() -> some AsyncSequence {
//        let delegate = CommandDelegate()
//        self.delegate = delegate
//        return AsyncStream<String> { continuation in
//            self.startListening()
////            continuation.onTermination = { termination in
////                self.delegate = nil
////            }
//
//            delegate.onDidRecognizeCommand = { command in
//                continuation.yield(command)
//            }
//        }
//    }
//
//    class CommandDelegate: NSObject, NSSpeechRecognizerDelegate {
//        var onDidRecognizeCommand: ((String) -> ())?
//
//        func speechRecognizer(
//            _ sender: NSSpeechRecognizer,
//            didRecognizeCommand command: String)
//        {
//            self.onDidRecognizeCommand?(command)
//        }
//    }
//}
