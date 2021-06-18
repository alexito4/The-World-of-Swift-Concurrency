extension Result {
    
    var failure: Failure? {
        switch self {
        case .failure(let error): return error
        case .success: return nil
        }
    }
    
    var success: Success? {
        switch self {
        case .failure: return nil
        case .success(let value): return value
        }
    }
}

extension UInt64 {
    static func seconds(_ seconds: Double) -> Self {
        UInt64(seconds * 1000000000)
    }
}
