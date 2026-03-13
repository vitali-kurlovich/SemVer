//
//  Created by Vitali Kurlovich on 13.03.26.
//

public extension CoreVersion {
    init(_ string: String) throws {
        let parser = VersionParser()
        self = try parser.parseCoreVersion(string)
    }
}
