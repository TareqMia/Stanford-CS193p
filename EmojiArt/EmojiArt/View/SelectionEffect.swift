//
//  SelectionEffect.swift
//  EmojiArt
//
//  Created by Tareq Mia on 2/8/23.
//

import SwiftUI

struct SelectionEffect: ViewModifier {
    
    var emoji: EmojiArtModel.Emoji
    var selectedEmojis: Set<EmojiArtModel.Emoji>
    func body(content: Content) -> some View {
        content
            .overlay(selectedEmojis.contains(emoji) ? RoundedRectangle(cornerRadius: 0).strokeBorder(lineWidth: 1.2).foregroundColor(.blue) : nil)
    }
}

extension View {
    
    func selectionEffect(for emoji: EmojiArtModel.Emoji, in selectedEmojis: Set<EmojiArtModel.Emoji>) -> some View {
        modifier(SelectionEffect(emoji: emoji, selectedEmojis: selectedEmojis))
    }
}


