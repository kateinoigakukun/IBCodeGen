//
//  DefaultDefinition.swift
//  IBCodeGenKit
//
//  Created by Yuta Saito on 2021/01/24.
//

enum DefaultDefinition {
    case UIImageSymbolConfiguration

    var reference: SwiftValueRepresentable {
        switch self {
        case .UIImageSymbolConfiguration:
            return EnumCase("interfaceBuilderDefault")
        }
    }

    func writeValue<Target>(target: inout Target) throws where Target : IndentTextOutputStream {
        switch self {
        case .UIImageSymbolConfiguration:
            let content = """

            @available(iOS 13.0, *)
            fileprivate extension UIImage.Configuration {
                static var interfaceBuilderDefault: UIImage.SymbolConfiguration {
                    let traits = UITraitCollection(traitsFrom: [
                        UITraitCollection(userInterfaceIdiom: .pad),
                        UITraitCollection(displayScale: 1),
                        UITraitCollection(displayGamut: .SRGB),
                    ])

                    return  UIImage.SymbolConfiguration.unspecified
                        .withTraitCollection(traits)
                }
            }

            """
            target.write(content)
        }
    }
}
