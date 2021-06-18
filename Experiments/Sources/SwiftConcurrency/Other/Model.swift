import Foundation

struct Card: Decodable {
    let name: String
    let cardCode: String
    let assets: [Asset]
    
    struct Asset: Decodable {
        let gameAbsolutePath: URL
        let fullAbsolutePath: URL
    }
}
