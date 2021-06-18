import Foundation

//@main
struct Scope {
    static func main() async {
        let c = Controller()
        
        c.onViewDidLoad {
            await startCounting("1")
        }
        
        await c.lifecycle()
        
        await Task.sleep(.seconds(9999))
    }
}

func startCounting(_ s: String) async {
    for i in 0... {
        await Task.sleep(.seconds(0.5))
        guard !Task.isCancelled else { return }
        print("\(s) -> \(i)")
    }
}

















final class Controller {
    
    func onViewDidLoad(_ f: @escaping () async -> Void) {
        
    }
    
    func lifecycle() async {
        print("viewDidAppear")
        await Task.sleep(.seconds(5))
        
        print("viewDidDisappear")
    }
}
