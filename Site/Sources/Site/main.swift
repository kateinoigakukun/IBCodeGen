import CoreFoundation
#if canImport(FoundationXML)
    import FoundationXML
#endif
import IBCodeGenKit
import JavaScriptKit

class ContentWriter: TextOutputStream {
    private(set) var content: String = ""
    func write(_ string: String) {
        content += string
    }
}

let generator = IBCodeGenerator()

let document = JSObject.global.document
let fileSelect = document.getElementById("ib-select").object!
let dragBox = document.getElementById("drag-box").object!
let codeArea = document.getElementById("code-area").object!

let ace = JSObject.global.ace.object!
let editor = ace.edit!(codeArea)
_ = editor.session.setMode("ace/mode/swift")

func handleFileSelect(_ file: JSValue) {
    let fileName = file.name.string!
    let baseName = String(fileName.split(separator: ".").dropLast().joined(separator: "."))

    JSPromise(file.text().object!)!.then { value in
        var writer = ContentWriter()
        print(value.string!)
        do {
            _ = try generator.generate(
                from: value.string!, fileBaseName: baseName,
                target: &writer
            )
//            _ = editor.setValue(JSValue.string(writer.content))
        } catch {
            print(error)
        }
        return JSValue.undefined
    }
}

let fileSelectHandler = JSClosure { arguments in
    let file = fileSelect.files.item(0)
    handleFileSelect(file)
    return .undefined
}

_ = fileSelect.addEventListener!("change", fileSelectHandler)

let fileDragOver = JSClosure { args in
    let event = args[0]
    _ = event.preventDefault()
    _ = dragBox.classList.add("border-yellow-300")
    return .undefined
}
let fileDragLeave = JSClosure { args in
    let event = args[0]
    _ = event.preventDefault()
    _ = dragBox.classList.remove("border-yellow-300")
    return .undefined
}
let fileDrop = JSClosure { args in
    let event = args[0]
    _ = event.preventDefault()
    _ = dragBox.classList.remove("border-yellow-300")
    let file = event.dataTransfer.files.item(0)
    handleFileSelect(file)
    return .undefined
}
_ = dragBox.addEventListener!("dragover", fileDragOver)
_ = dragBox.addEventListener!("dragleave", fileDragLeave)
_ = dragBox.addEventListener!("drop", fileDrop)
