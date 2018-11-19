import Foundation

func info(items: Any...) {
    Log.shared.info(items: items)
}

func debug(items: Any...) {
    Log.shared.debug(items: items)
}

func verbose(items: Any...) {
    Log.shared.verbose(items: items)
}

func error(items: Any...) {
    Log.shared.error(items: items)
}

struct Log {
    
    static let shared = Log()
    
    var logLevel: LogLevel = []
    
    init() {
        #if DEBUG
            logLevel = [.debug, .error, .info, .verbose]
        #endif
    }
}

extension Log {
    
    struct LogLevel: OptionSet {
        let rawValue: Int
        static let debug = LogLevel(rawValue: 1 << 0)
        static let error = LogLevel(rawValue: 1 << 1)
        static let info = LogLevel(rawValue: 1 << 2)
        static let verbose = LogLevel(rawValue: 1 << 3)
    }
}

extension Log {
    func info(items: Any...) {
        guard Log.shared.logLevel.contains(.info) else {
            return
        }
        let printed: String = items.reduce("❕ ") { (old, new) -> String in
            return old + "\(new)" + " "
        }
        print(printed)
        
    }
    
    func debug(items: Any...) {
        guard Log.shared.logLevel.contains(.debug) else {
            return
        }
        let printed = items.reduce("🔶 ") { (old, new) -> String in
            return old + "\(new)" + " "
        }
        print(printed)
    }
    
    func verbose(items: Any...) {
        guard Log.shared.logLevel.contains(.verbose) else {
            return
        }
        let printed = items.reduce("🔵 ") { (old, new) -> String in
            return old + "\(new)" + " "
        }
        print(printed)
    }
    
    func error(items: Any...) {
        guard Log.shared.logLevel.contains(.error) else {
            return
        }
        let printed = items.reduce("❌ ") { (old, new) -> String in
            return old + "\(new)" + " "
        }
        print(printed)
    }
}
