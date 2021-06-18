
actor BankAccount {
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, initialDeposit: Double) {
        self.accountNumber = accountNumber
        self.balance = initialDeposit
    }
    
    enum BankError: Error {
        case insufficientFunds
    }
}

extension BankAccount {
    func transfer(amount: Double, to other: BankAccount) async throws {
        if amount > balance {
            throw BankError.insufficientFunds
        }

        balance = balance - amount
        
        await other.deposit(amount: amount)
//        other.balance = other.balance + amount
    }
    
    func deposit(amount: Double) {
        assert(amount >= 0)
        balance = balance + amount
    }
}

//extension BankAccount: CustomDebugStringConvertible {
//    nonisolated var debugDescription: String {
//        "Account: \(accountNumber): \(balance)"
//    }
//}
extension BankAccount {
    func printDescription() async {
        print("Account: \(accountNumber): \(balance)")
    }
}

@MainActor func touchAUIView() {
    
}

//@MainActor func saveResults() {
//  view.startSavingSpinner()                            // executes on the main actor, immediately
//  detach(priority: .userInitiated) { @MainActor in  // task on the main actor
//    await self.ioActor.save()                          // hop to ioActor to save
//    self.view.stopSavingSpinner()                      // back on main actor to update UI
//  }
//}


//@main
struct ActorsDemo {
    static func doTest() async throws {
        let account1 = BankAccount(accountNumber: 1, initialDeposit: 100)
        let account2 = BankAccount(accountNumber: 2, initialDeposit: 0)
        let account3 = BankAccount(accountNumber: 3, initialDeposit: 0)
        
        let a = asyncDetached {
            await try account1.transfer(amount: 90, to: account2)
        }
        let b = asyncDetached {
            await try account1.transfer(amount: 90, to: account3)
        }
        
        await try a.get()
        await try b.get()
        
        await account1.printDescription()
        await account2.printDescription()
        await account3.printDescription()
//        print(account1)
//        print(account2)
//        print(account3)
    }
    static func main() async {
        var bum = false
        while !bum {
            do {
                await try doTest()
                bum = true
                print("💣")
            } catch {
                print(error)
            }
            await Task.sleep(10)
        }
    }
}
