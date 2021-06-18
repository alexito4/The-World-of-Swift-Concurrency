//import Foundation
//defer { dispatchMain() }

enum Judgment {
    case noIdea
    case goodIdea
    case badIdea
}

actor DecisionMaker {
    init(friend: DecisionMaker?) {
        self.friend = friend
    }
    
    let friend: DecisionMaker!
    var opinion: Judgment = .noIdea
    
    func thinkOfGoodIdea() async -> Judgment {
        opinion = .goodIdea
        await friend.tell(opinion, heldBy: self)
        return opinion
    }
    
    func thinkOfBadIdea() async -> Judgment {
        opinion = .badIdea
        await friend.tell(opinion, heldBy: self)
        return opinion
    }
}
extension DecisionMaker {
    func tell(_ opinion: Judgment, heldBy friend: DecisionMaker) async {
        if opinion == .badIdea {
            print("\(#function) - \(#line)")
            await friend.convinceOtherwise(opinion)
            print("\(#function) - \(#line)")
        }
        print("\(#function) - \(#line)")
    }
    
    func convinceOtherwise(_ opinion: Judgment) async {
        if opinion == .goodIdea {
            self.opinion = .badIdea
        } else {
            self.opinion = .goodIdea
        }
    }
}

//func test() async {
//    let person = DecisionMaker(friend: DecisionMaker(friend: nil))
//    
//    let goodThink = detach { await person.thinkOfGoodIdea() }  // runs async
//    let badThink = detach { await person.thinkOfBadIdea() } // runs async
//    print("\(#function) - \(#line)")
//    let shouldBeGood = await goodThink.get()
//    print("\(#function) - \(#line)")
//    let shouldBeBad = await badThink.get()
//    print("\(#function) - \(#line)")
//    
//    // i'm seeing that sometimes it doesn't get here becuase one of the gets doesn't return.
//    // the actor proposal says that this should work, but that the result of ideas can be wrong.
//    // but i don't know why it doesn't finish sometimes, that's weird.
//    print(shouldBeGood)
//    print(shouldBeBad)
//}

//async {
//    await test()
//}
