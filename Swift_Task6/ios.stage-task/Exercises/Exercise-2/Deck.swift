import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {
    
    //MARK: - Properties
    
    var cards = [Card]()
    var type: DeckType
    var trump: Suit?
    
    var total:Int {
        return type.rawValue
    }
}

extension Deck {
    
    init(with type: DeckType) {
        self.type = type
        cards = createDeck(suits: [.clubs,.diamonds,.hearts,.spades],
                           values: [.six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace])
    }
    
    public mutating func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var deckCards = [Card]()
        for value in values.sorted(by: {$0.rawValue < $1.rawValue}) {
            for suit in suits.sorted(by: {$0.rawValue < $1.rawValue}) {
                deckCards.append(Card(suit: suit, value: value))
            }
        }
        return deckCards
    }
    
    public mutating func shuffle() {
        cards.shuffle()
    }
    
    public mutating func defineTrump() {
        trump = cards.first!.suit
        setTrumpCards(for: trump!)
    }
    
    public mutating func initialCardsDealForPlayers(players: [Player]) {
        for player in players {
            player.hand = [cards.removeFirst()]
            for _ in 2...6 {
                if player.hand != nil {
                    player.hand?.append(cards.removeFirst())
                }
            }
        }
    }
    
    public mutating func setTrumpCards(for suit:Suit) {
        for index in cards.indices {
            if cards[index].suit == trump {
                cards[index].isTrump = true
            }
        }
    }
}

