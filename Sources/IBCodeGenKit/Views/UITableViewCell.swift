//
//  UITableViewCell.swift
//  IBCodeGenKit
//
//  Created by kateinoigakukun on 2021/01/28.
//

import IBDecodable

extension TableViewCell: CodeGenTargetView {
    func codegen(builder: ViewCodeBuilder, rootView: RootClassBuilder) throws {
        let b = ViewBinder(view: self, builder: builder)
        if let style = style, style.hasPrefix("IBUITableViewCellStyle") {
            let caseName = style.dropFirst("IBUITableViewCellStyle".count)
            guard let firstLetter = caseName.first?.lowercased() else {
                throw Error.invalidTableViewCellStyle(style)
            }
            builder.setInit(arguments: [
                ("style", EnumCase(String(firstLetter + caseName.dropFirst()))),
                ("reuseIdentifier", RawValueString("reuseIdentifier"))
            ])
        } else {
            builder.setInit(arguments: [
                ("style", RawValueString("style")),
                ("reuseIdentifier", RawValueString("reuseIdentifier"))
            ])
        }

        b.bindIfPresent(\.indentationWidth, name: "indentationWidth")
        b.bindIfPresent(\.indentationLevel, name: "indentationLevel")
        b.bindIfPresent(\.shouldIndentWhileEditing, name: "shouldIndentWhileEditing")
        b.bindIfPresent(\.selectionStyle, name: "selectionStyle", transform: EnumCase.init)
        b.bindIfPresent(\.accessoryType, name: "accessoryType", transform: EnumCase.init)
        b.bindIfPresent(\.editingAccessoryType, name: "editingAccessoryType", transform: EnumCase.init)
        b.bindIfPresent(\.focusStyle, name: "focusStyle", transform: EnumCase.init)
        b.bindIfPresent(\.separatorInset, name: "separatorInset")
    }
}
