//
//  DataLayer.swift
//  AutoLayoutIBApp
//
//  Created by Michael Nguyen on 10/20/21.
//  Copyright © 2021 Michael Nguyen. All rights reserved.
//

import Foundation
import SQLite

class Database {
    var conn : Connection!
    var tbl : Table!
    var songCol : Expression<String>!
    
    init() {
        let rootPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let dbPath = rootPath.appendingPathComponent("MelodyDB.sqlite").path
        print("Database location: \(dbPath)")
        conn = try! Connection(dbPath)
        
        initialize()
    }
    
    private func initialize() {
        tbl = Table("Song")
        songCol = Expression<String>("song_title")
        
        let createTbl = tbl.create(ifNotExists: true) {t in
            t.column(songCol)
        }
        try! conn.run(createTbl)
        
    }
    
}

// Create Singleton Object
class MelodyRepository {
    
    var db = Database()
    
    static private var repository : MelodyRepository!
    
    static func get() -> MelodyRepository {
        if repository == nil {
            repository = MelodyRepository()
        }
        return repository
    }
    
    func createSong(stObj: Song) {
        let conn = db.conn!
        let tbl = db.tbl!
        let insertTbl = tbl.insert(db.songCol <- stObj.song_name)
        try! conn.run(insertTbl)
    }
    
    // Retrieve list of songs in Database
    func getSong() -> [Song] {
        var list = [Song]()
        let tbl = db.tbl!
        let result = try! db.conn.prepare(tbl)
        
        // Loop through and grab the songs
        for i in result {
            try! list.append(Song(i.get(db.songCol)))
            
        }
        return list
    }
    
    func deleteSong(sObj: Song) {
        let tbl = db.tbl.filter(db.songCol == sObj.song_name)
        try! db.conn.run(tbl.delete())
    }
    
}
