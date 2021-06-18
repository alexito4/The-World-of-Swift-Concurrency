

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import AppKit
extension NSSpeechRecognizer {
    func recognizedCommands() -> some AsyncSequence {
        let delegate = CommandDelegate()
        self.delegate = delegate
        return AsyncStream<String> { continuation in
            self.startListening()
//            continuation.onTermination = { termination in
//                self.delegate = nil
//            }

            delegate.onDidRecognizeCommand = { command in
                continuation.yield(command)
            }
        }
    }
    
    class CommandDelegate: NSObject, NSSpeechRecognizerDelegate {
        var onDidRecognizeCommand: ((String) -> ())?
        
        func speechRecognizer(
            _ sender: NSSpeechRecognizer,
            didRecognizeCommand command: String)
        {
            self.onDidRecognizeCommand?(command)
        }
    }
}
