//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tareq Mia on 1/2/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static var vehicleEmojis = ["๐", "๐ด", "โ๏ธ", "๐ต", "โต๏ธ", "๐", "๐",
                                        "๐", "๐ป", "๐", "๐", "๐", "๐", "๐",
                                        "๐ข", "๐ถ", "๐ฅ", "๐", "๐", "๐"]
    
    private static var animalEmojis = ["๐ถ", "๐ฑ", "๐ญ", "๐น", "๐ฐ", "๐ฆ", "๐ป", "๐ผ",
                                       "๐ปโโ๏ธ", "๐จ", "๐ฏ", "๐ฆ", "๐ฎ", "๐ท", "๐ต"]
    
    private static var foodEmojis = ["๐", "๐ฅ", "๐", "๐ฅ", "๐ฅ", "๐ฃ", "๐ช",
                                     "๐", "๐", "๐ฅ", "๐ญ", "๐ค", "๐ฅ", "๐ฆ",
                                     "๐", "๐"]
    
    private static var heartEmojis = ["โค๏ธ", "๐งก", "๐",
                                      "๐", "๐", "๐"]
    
    private static var sportsEmojis = ["โฝ๏ธ", "๐", "๐", "โพ๏ธ", "๐พ", "๐", "๐ฅ", "๐",
                                       "๐", "๐ฑ", "๐", "๐ธ", "๐", "๐ฅ", "๐ดโโ๏ธ",
                                       "๐งโโ๏ธ", "๐คบ", "๐", "๐๏ธโโ๏ธ", "โธ", "โท", "๐คผ","๐"]
    
    private static var weatherEmojis = ["โ๏ธ", "๐ช", "โ๏ธ", "โ๏ธ", "โ๏ธ"]
    
    
    private static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        var numberOfPairsOfCards = theme.numberOfPairsOfCards
        if theme.name == "Vehicles" || theme.name == "Animals" {
            numberOfPairsOfCards = Int.random(in: 2...theme.emojis.count)
        }
        return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards) { theme.emojis[$0] }
    }
    
    private static let colors = ["gray", "red", "green", "blue", "orange",
                                 "yellow", "pink", "purple", "fushia", "beige", "gold"]
    
    
    private static func createTheme(_ name: String, _ emojis: [String], _ numberOfPairsOfCards: Int)  -> Theme {
        let color = colors.randomElement()
        var pairsOfCards = numberOfPairsOfCards
        if emojis.count < numberOfPairsOfCards {
            pairsOfCards = emojis.count
        }
        return Theme(name: name, emojis: emojis, color: color!, numberOfPairsOfCards: pairsOfCards)
    }
    
    private static var themes: [Theme] = {
        var themes = [Theme]()
        let numberOfPairsOfCards = 5
        
        themes.append(createTheme("Vehicles", vehicleEmojis, numberOfPairsOfCards))
        themes.append(createTheme("Animals", animalEmojis, numberOfPairsOfCards))
        themes.append(createTheme("Food", foodEmojis, numberOfPairsOfCards))
        themes.append(createTheme("Hearts", heartEmojis, numberOfPairsOfCards))
        themes.append(createTheme("Sports", sportsEmojis, numberOfPairsOfCards))
        themes.append(createTheme("Weather", weatherEmojis, numberOfPairsOfCards))
        return themes
    }()
    
    private static func getTheme() -> Theme {
        return EmojiMemoryGame.themes.randomElement()!
    }
    
    private static func getColor(_ chosenColor: String) -> Color {
        switch chosenColor {
        case "black":
            return .black
        case "gray":
            return .gray
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "pink":
            return .pink
        case "purple":
            return .purple
        default:
            return .red
        }
    }
    
    private(set) var theme: Theme
    private(set) var color: Color?
    @Published private var model: MemoryGame<String>
    
    init() {
        theme = EmojiMemoryGame.getTheme()
        model = EmojiMemoryGame.createMemoryGame(of: theme)
        color = EmojiMemoryGame.getColor(theme.color)
    }
    
    var cards: [Card]  {
        model.cards
    }
    
    var points: Int {
        model.points
    }
    
    // MARK: Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func createNewGame() -> Void {
        theme = EmojiMemoryGame.getTheme()
        model = EmojiMemoryGame.createMemoryGame(of: theme)
        color = EmojiMemoryGame.getColor(theme.color)
    }
    
    func shuffle() -> Void {
        model.shuffle()
    }
}
