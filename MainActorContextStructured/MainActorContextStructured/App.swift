//
//  main.swift
//  MainActorContextStructured
//
//  Created by Alejandro Martinez on 28/12/21.
//

import Foundation

/*
 Exploration of what "context" is inherited by Tasks.
 */

let myQueue = DispatchQueue(label: "my queue")

@main
struct App {
    static func main() async throws {
        print("a", Thread.current)
        
//        myQueue.async {
//            print("async", Thread.current)
//        }
        
//        let t = Task { @MainActor in
//            print("b", Thread.current)
//            await MyActor().doSomething()
//            print("b2", Thread.current)
//            await asyncOnSomeQueue()
//            print("b3", Thread.current)
//            await nested()
//            print("b4", Thread.current)
//        }
//        await t.value
        
//        let vc = ViewController()
//        vc.viewModel.delegate = vc
//        vc.viewDidLoad()
//
// https://twitter.com/Catfish_Man/status/1475907026953728002
//        Task { @MainActor in
//            global += 1 // global is annotated @MainActor
//            print("main actor but not main thread?", Thread.current, Thread.isMainThread)
//            global += 1
//        }
//        dispatchMain()
        
        let _: Void = await withUnsafeContinuation { continuation in
            // wait lol
        }
    }
}

@MainActor
var global = 2

@MainActor
class ViewController: Delegate {
    let viewModel = ViewModel()
    
    func viewDidLoad() {
        global += 1
        print("viewDidLoad 1", Thread.current, Thread.isMainThread)
        Task {
            global += 1
            print("viewDidLoad 2", Thread.current, Thread.isMainThread)
            await viewModel.fetch()
            print("viewDidLoad 3", Thread.current, Thread.isMainThread)
        }
    }
    
    nonisolated func loadDidFinish() {
        print("loadDidFinish", Thread.current, Thread.isMainThread)
    }
}

protocol Delegate: AnyObject {
    func loadDidFinish()
}

class ViewModel {
    weak var delegate: Delegate?
    
    func fetch() async {
//        global += 1
        print("fetch 1", Thread.current)
        await nested()
        print("fetch 2", Thread.current)
        delegate?.loadDidFinish()
        print("fetch 3", Thread.current)
    }
}

actor MyActor {
    var value: Int = 0
    
    func doSomething() async {
//        global += 1
        value += 1
        print("MyActor.doSomething", Thread.current)
        await asyncOnSomeQueue()
        print("MyActor.doSomething 2", Thread.current)
        let t = Task {
            print("MyActor.doSomething 3", Thread.current)
            value += 1
            print("MyActor.doSomething 4", Thread.current)
        }
        await t.value
    }
}

func asyncOnSomeQueue() async {
    return await withUnsafeContinuation { continuation in
        myQueue.asyncAfter(deadline: .now() + 1) {
            print("withUnsafeContinuation", Thread.current)
            continuation.resume()
        }
    }
}

func nested() async {
//    global += 1
    print("nested", Thread.current)
    await asyncOnSomeQueue()
    print("nested 2", Thread.current)
}
