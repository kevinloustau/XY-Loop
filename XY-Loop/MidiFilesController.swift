//
//  MidiFilesController.swift
//  EASY-X
//
//  Created by kl on 10/12/2017.
//  Copyright © 2017 kl. All rights reserved.
//

import Foundation

class MidiFilesController {
    
    static let sharedInstance = MidiFilesController()
    var instrumentAndStyleDictionary = [String: [String]]()
    
    init() {
        let instrumentList = getInstrumentList()
        //MARK: build the instrument<->style dictionary
        for instrument in instrumentList {
            instrumentAndStyleDictionary[instrument] = getInstrumentStyleList(instrument: instrument)
        }
        for index in instrumentAndStyleDictionary {
            print(index)
        }
    }
    
    func getInstrumentList() -> [String] {
        let midiRootPath = Bundle.main.resourcePath! + "/Sounds/midi"
        let fileManager = FileManager.default
        let emptyArrayString : [String] = [""]
        do {
            let instrumentArray = try fileManager.contentsOfDirectory(atPath: midiRootPath)
            return instrumentArray
        } catch {
            print(error)
        }
        return emptyArrayString
    }
    
    func getInstrumentStyleList(instrument: String) -> [String] {
        let midiInstrumentRootPath = Bundle.main.resourcePath! + "/Sounds/midi/\(instrument)"
        let fileManager = FileManager.default
        let emptyArrayString : [String] = [""]
        do {
            let instrumentStyleArray = try fileManager.contentsOfDirectory(atPath: midiInstrumentRootPath)
            return instrumentStyleArray
        } catch {
            print(error)
        }
        return emptyArrayString
    }
    
    func getMidiFileNumber(instrument: String, style: String) -> Int {
        let midiFilesRootPath = Bundle.main.resourcePath! + "/Sounds/midi/\(instrument)/\(style)"
        let fileManager = FileManager.default
        do {
            let midiFiles = try fileManager.contentsOfDirectory(atPath: midiFilesRootPath)
            return midiFiles.count - 1 
        } catch {
            print(error)
        }
        return 0
    }
}
