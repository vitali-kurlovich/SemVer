//
//  Created by Vitali Kurlovich on 20.03.26.
//

import Foundation

public extension Version {
    /// Format ``Version`` using style
    func formatted<S>(_ style: S) -> S.FormatOutput where Self == S.FormatInput, S: FormatStyle {
        style.format(self)
    }
}

public extension Version {
    /// Format ``Version`` using  ``Foundation/FormatStyle/medium`` style
    func formatted() -> String {
        formatted(.medium)
    }
}

public extension Version.VersionCore {
    func formatted() -> String {
        let string = VersionString()
        return string.string(from: self)
    }
}

public extension Version.PreRelease {
    func formatted() -> String {
        let string = VersionString()
        return string.string(from: self)
    }
}
