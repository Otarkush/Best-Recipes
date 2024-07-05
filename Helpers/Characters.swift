//
//  Characters.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 05.07.2024.
//

import UIKit

func charactersToString(character: String, text: String, size: Int) -> NSMutableAttributedString {
    let attachment = NSTextAttachment()
    attachment.image = UIImage(systemName: character)
    attachment.bounds = CGRect(x: 0, y: 0, width: size, height: size)
    let attachmentString = NSAttributedString(attachment: attachment)
    let complexText = NSMutableAttributedString(string: "")
    complexText.append(attachmentString)
    let textAfterIcon = NSAttributedString(string: " \(text)")
    complexText.append(textAfterIcon)
    return complexText
}
