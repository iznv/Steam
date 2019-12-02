//
//  SteamBBCodeHtmlTagTransformer.swift
//  Steam
//
//  Created by Ivan Zinovyev on 02/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import WEBBCode

class SteamBBCodeHtmlTagTransformer: NSObject, WEBBCodeHtmlTagTransformer {
    
    var tagTransformationDictionary: [String: WEBBCodeHtmlTagsTransformationDescriptor?] {
        return [
            "b": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "strong"),
            "i": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "em"),
            "u": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "ins"),
            "s": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "del"),
            "quote": WEBBCodeHtmlTagsTransformationDescriptor(byTranslatingTagNameToTagNames: ["blockquote", "p"]),
            "code": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "pre"),
            "list": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "ul"),
            "url": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "a",
                                                            withDefaultAttributeName: "href"),
            "ul": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "ol": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "li": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "*": WEBBCodeHtmlTagsTransformationDescriptor(byCopyingAttributesAndTranslatingTagNameTo: "li")
                .withCloseTag(onLineBreak: true)?
                .withIgnoreLineBreak(afterTag: true),
            "table": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "tr": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "th": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "td": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "center": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "left": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "right": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "justify": WEBBCodeHtmlTagsTransformationDescriptor.copyingTagsAndAttributes(),
            "img": WEBBCodeHtmlTagsTransformationDescriptor(transformationBlock: { tag -> [WEBBCodeTag]? in
                var attributes = [WEBBCodeAttribute]()
                
                if let url = tag?.content {
                    attributes.append(WEBBCodeAttribute(name: "src", value: url))
                }
                
                return [WEBBCodeTag(tagName: "img",
                                    attributes: WEBBCodeAttributes(attributes: attributes))]
            }).withBufferTagContent(true),
            "previewyoutube": WEBBCodeHtmlTagsTransformationDescriptor(transformationBlock: { tag -> [WEBBCodeTag]? in
                var attributes = [WEBBCodeAttribute]()

                tag?.attributes?.attributes?.forEach { attribute in
                    if attribute.isDefault(),
                       let value = attribute.value {
                        
                        let fixedValue = value.replacingOccurrences(of: ";full", with: "")
                        
                        attributes.append(WEBBCodeAttribute(name: "src",
                                                            value: "https://www.youtube.com/embed/\(fixedValue)"))
                    }
                }

                return [WEBBCodeTag(tagName: "iframe",
                                    attributes: WEBBCodeAttributes(attributes: attributes))]
            })
        ]
    }
    
    func htmlTags(for tag: WEBBCodeTag?) -> [WEBBCodeTag]? {
        guard let tag = tag else { return nil }
        return tagTransformationDictionary[tag.tagName]??.htmlTags(for: tag)
    }
    
    func shouldCloseTag(forLineBreak tag: String?) -> Bool {
        guard let tag = tag else { return false}
        return tagTransformationDictionary[tag]??.closeTagOnLineBreak ?? false
    }
    
    func shouldIgnoreLineBreak(afterTag tag: String?) -> Bool {
        guard let tag = tag else { return false}
        return tagTransformationDictionary[tag]??.ignoreLineBreakAfterTag ?? false
    }
    
    func shouldBufferContent(forTag tag: String?) -> Bool {
        guard let tag = tag else { return false}
        return tagTransformationDictionary[tag]??.bufferTagContent ?? false
    }

}
