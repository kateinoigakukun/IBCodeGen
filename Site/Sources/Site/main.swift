import CoreFoundation
#if canImport(FoundationXML)
    import FoundationXML
#endif
import IBCodeGenKit
#if canImport(JavaScriptKit)
import JavaScriptKit
#endif

class ContentWriter: TextOutputStream {
    private(set) var content: String = ""
    func write(_ string: String) {
        content += string
    }
}

let generator = IBCodeGenerator()

#if canImport(JavaScriptKit)
let document = JSObject.global.document
let fileSelect = document.getElementById("ib-select").object!
let dragBox = document.getElementById("drag-box").object!
let codeArea = document.getElementById("code-area").object!
let errorArea = document.getElementById("error-area").object!

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
            _ = editor.setValue(JSValue.string(writer.content))
            errorArea.innerText = .string("")
        } catch {
            errorArea.innerText = .string("🔴 " + String(describing: error))
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
#else

var writer = ContentWriter()
let xmlContent = """
<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="17506" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <device id="retina6_1" orientation="portrait" appearance="light"/>
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="17504.1"/>
        <capability name="Safe area layout guides" minToolsVersion="9.0"/>
        <capability name="System colors in document resources" minToolsVersion="11.0"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
        <view contentMode="scaleToFill" id="iN0-l3-epB">
            <rect key="frame" x="0.0" y="0.0" width="414" height="896"/>
            <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
            <subviews>
                <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="0Nc-s8-VTj">
                    <rect key="frame" x="20" y="44" width="374" height="818"/>
                    <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                    <subviews>
                        <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="CS1-Qk-Vmy">
                            <rect key="frame" x="8" y="8" width="358" height="802"/>
                            <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                            <subviews>
                                <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="xTZ-SP-w9T">
                                    <rect key="frame" x="8" y="8" width="342" height="786"/>
                                    <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                    <subviews>
                                        <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="0zC-WS-O2V">
                                            <rect key="frame" x="10" y="8" width="323" height="362"/>
                                            <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                            <color key="backgroundColor" systemColor="systemTealColor"/>
                                        </view>
                                        <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="d7r-AA-zCd">
                                            <rect key="frame" x="8" y="381" width="323" height="397"/>
                                            <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                            <color key="backgroundColor" systemColor="systemBlueColor"/>
                                        </view>
                                    </subviews>
                                    <color key="backgroundColor" systemColor="systemOrangeColor"/>
                                </view>
                            </subviews>
                            <color key="backgroundColor" systemColor="systemPurpleColor"/>
                        </view>
                    </subviews>
                    <color key="backgroundColor" systemColor="systemRedColor"/>
                </view>
            </subviews>
            <viewLayoutGuide key="safeArea" id="vUN-kp-3ea"/>
            <color key="backgroundColor" systemColor="systemGreenColor"/>
            <point key="canvasLocation" x="137.68115942028987" y="152.67857142857142"/>
        </view>
    </objects>
    <resources>
        <systemColor name="systemBlueColor">
            <color red="0.0" green="0.47843137254901963" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
        </systemColor>
        <systemColor name="systemGreenColor">
            <color red="0.20392156862745098" green="0.7803921568627451" blue="0.34901960784313724" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
        </systemColor>
        <systemColor name="systemOrangeColor">
            <color red="1" green="0.58431372549019611" blue="0.0" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
        </systemColor>
        <systemColor name="systemPurpleColor">
            <color red="0.68627450980392157" green="0.32156862745098042" blue="0.87058823529411766" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
        </systemColor>
        <systemColor name="systemRedColor">
            <color red="1" green="0.23137254901960785" blue="0.18823529411764706" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
        </systemColor>
        <systemColor name="systemTealColor">
            <color red="0.35294117647058826" green="0.78431372549019607" blue="0.98039215686274506" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
        </systemColor>
    </resources>
</document>
"""

_ = try generator.generate(
    from: xmlContent, fileBaseName: "Temp",
    target: &writer
)
print(writer.content)
#endif
