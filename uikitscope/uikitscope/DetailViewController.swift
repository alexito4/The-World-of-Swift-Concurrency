

import UIKit

class DetailViewController: AsyncViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        async {
//            let posts = await fetchPosts()
//            print(posts)
//        }
        
        onTask {
            let posts = await fetchPosts()
            print(posts)
        }
    }
    
    

}

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

func fetchPosts() async -> [Post] {
    do {
        let (data, _) = try await URLSession.shared
            .data(from: URL(string: "https://run.mocky.io/v3/880ef387-45bc-4dc3-8166-d9cfe440e75d?mocky-delay=5s")!)
        return try JSONDecoder().decode([Post].self, from: data)
    } catch {
        print(error)
        return []
    }
}
