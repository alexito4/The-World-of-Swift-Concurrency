

import UIKit

class AsyncViewController: UIViewController {
    
    var tasks = Set<Task.Handle<Void, Never>>()
    
    func onTask(_ f: @escaping () async -> Void) {
        
        let task = async {
            await f()
        }
        tasks.insert(task)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tasks.forEach({ $0.cancel() })
    }
}
