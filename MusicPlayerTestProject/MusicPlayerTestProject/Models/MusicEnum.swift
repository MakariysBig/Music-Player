import Foundation

enum AudioURL {
    case miyagiAudio
    case nickiMinajAudio
    case snoopDoggAudio
    
    var getAudio: String {
        switch self {
        case .miyagiAudio:
            return "Miyagi & Andy Panda - Там ревели горы"
        case .nickiMinajAudio:
            return "Nicki Minaj, Labrinth feat. Eminem - Majesty"
        case .snoopDoggAudio:
            return "Jason Derulo feat. Snoop Dogg - Wiggle (feat. Snoop Dogg)"
        }
    } 
}

enum PictureURL: String {
    case miyagi
    case nickiMinaj
    case snoopDogg
    
    var getPicture: String {
        switch self {
        case .miyagi:
            return "miyagiImage"
        case .nickiMinaj:
            return "nicki"
        case .snoopDogg:
            return "SnoopDogg"
        }
    }
}
