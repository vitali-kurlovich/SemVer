# swift-semver
[![MacOS](https://github.com/vitali-kurlovich/swift-semver/actions/workflows/macos.yml/badge.svg)](https://github.com/vitali-kurlovich/swift-semver/actions/workflows/macos.yml)
[![Linux](https://github.com/vitali-kurlovich/swift-semver/actions/workflows/linux.yml/badge.svg)](https://github.com/vitali-kurlovich/swift-semver/actions/workflows/linux.yml)
[![Generate DocC](https://github.com/vitali-kurlovich/swift-semver/actions/workflows/doc.yml/badge.svg)](https://github.com/vitali-kurlovich/swift-semver/actions/workflows/doc.yml)


# Semantic Versioning

 Swift implementation of the [Semantic Versioning Specification](https://semver.org/)

 ## Features
 
  - Parsing semver formated string into [Version](https://vitali-kurlovich.github.io/swift-semver/documentation/semanticversioning/version)
  - [Version](https://vitali-kurlovich.github.io/swift-semver/documentation/semanticversioning/version) comparison using [semiver comparison rules](https://semver.org/#spec-item-11)
  - Customized formatting by using  [VersionFormatStyle](https://vitali-kurlovich.github.io/swift-semver/documentation/semanticversioning/versionformatstyle) and 
  [VersionFormatStyle.Attributed](https://vitali-kurlovich.github.io/swift-semver/documentation/semanticversioning/versionformatstyle/attributed-swift.struct) 

### SemanticVersioning API

For more info, you can read [SemanticVersioning API](https://vitali-kurlovich.github.io/swift-semver/documentation/semanticversioning/)


## Adding dependencies and getting started

### Step 1: Add a package dependency to the **Package.swift**
Update your **Package.swift**, add the [swift-semver](https://github.com/vitali-kurlovich/swift-semver) dependencies to your package:
```swift
    dependencies: [
        .package(url: "https://github.com/vitali-kurlovich/swift-semver.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: [
                .product(name: "SemanticVersioning", package: "swift-semver"),
         ]
        ),
]

```

### Step 2: Import **SemanticVersioning**

```swift
import SemanticVersioning

let version = try? Version("1.2.3")
```

 


