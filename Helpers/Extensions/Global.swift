import Foundation

func with<T>(_ initial: T, update: (inout T) throws -> Void) rethrows -> T {
    var copy = initial
    try update(&copy)
    return copy
}
