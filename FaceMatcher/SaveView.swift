//
//  SaveView.swift
//  FaceMatcher
//
//  Created by Erik Partridge on 8/12/22.
//

import SwiftUI

struct PlayerInformationStats {

    let numberOfDuplicates: UInt64
    let numberOfPlayers: UInt64
    let numberOfPlayersWithoutFaces: UInt64
    
    static func readPlayers(from file: URL, alreadyLoadedPlayers: [PlayerRecord], sourceGame: SavedGame, context: NSManagedObjectContext) throws {
        try autoreleasepool {
            let knownPlayerIdentifiers = Set(alreadyLoadedPlayers.map(\.identifier))
            let fileContents = try String(contentsOfFile: file.path, encoding: .utf8)
            let lines: [Substring] = fileContents.split(whereSeparator: { character in
                guard let unicodeScalar = character.unicodeScalars.first else {
                    // Ignore this as newlines would be single scalar characters
                    return false
                }
                return CharacterSet.newlines.contains(unicodeScalar)
            })
            let lineComponents: [[String]] = lines.map { $0.split(separator: "|").map { String($0) } }.filter { components in
                components.count >= 8
            }
            try lineComponents.forEach { components in
                let components = components.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                guard let uid = Int64(components[0]), !knownPlayerIdentifiers.contains(uid), !components[6].isEmpty else {
                    return
                }
                let record = PlayerRecord(context: context)
                record.parentGame = sourceGame
                record.identifier = uid
                record.nationality = components[1]
                if !components[2].isEmpty {
                    record.secondNationality = components[2]
                }
                record.name = components[3]
                record.ethnicity = Int32(components[4]) ?? -1
                try context.save()
            }
        }
    }
            
    static func computeStats(from knownPlayers: [PlayerRecord]) -> PlayerInformationStats {
        let playerPhotos = knownPlayers.compactMap(\.photoIdentifier)
        return PlayerInformationStats(numberOfDuplicates: UInt64(playerPhotos.count - Set(playerPhotos).count), numberOfPlayers: UInt64(knownPlayers.count), numberOfPlayersWithoutFaces: UInt64(knownPlayers.count - playerPhotos.count))
    }
    
}

struct StatsView: View {
    var stats: PlayerInformationStats
    
    var body: some View {
        VStack {
            Text("Number of Generated Players: \(stats.numberOfPlayers)")
            Text("Number of Players Without Faces: \(stats.numberOfPlayersWithoutFaces)")
            Text("Number of Players With Duplicate Faces: \(stats.numberOfDuplicates)")
        }
    }
}

struct PlayerLoadingView: View {
    @Environment(\.managedObjectContext) private var viewContext

    let savedGame: SavedGame
    @State var filePath: URL? = nil
    
    var body: some View {
        HStack {
            Text("Player information filepath: ")
            if let filePath = filePath {
                Text(filePath.absoluteString)
            } else {
                Button("Select File To Load Players") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseFiles = true
                    panel.canChooseDirectories = false
                    if panel.runModal() == .OK {
                        filePath = panel.url
                        let players = savedGame.players?.allObjects as! [PlayerRecord]
                        if let url = filePath {
                            do {
                                try PlayerInformationStats.readPlayers(from: url, alreadyLoadedPlayers: players, sourceGame: savedGame, context: viewContext)
                            } catch {
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SaveView: View {
    let savedGame: SavedGame
    @State var isPickingFile = false
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "parentGame", ascending: false)]) var allLoadedPlayers: FetchedResults<PlayerRecord>
    var playersInThisSave: [PlayerRecord] {
        return allLoadedPlayers.filter {
            $0.parentGame == savedGame
        }
    }
    var stats: PlayerInformationStats? {
        if playersInThisSave.isEmpty {
            return nil
        }
        return PlayerInformationStats.computeStats(from: playersInThisSave)
    }
    
    var body: some View {
        Text(savedGame.name!)
        if let stats = stats {
            StatsView(stats: stats)
        }
    }
}

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        let savedGame = SavedGame()
        savedGame.timestamp = Date()
        savedGame.name = "Some saved game"
        return SaveView(savedGame: savedGame)
    }
}
