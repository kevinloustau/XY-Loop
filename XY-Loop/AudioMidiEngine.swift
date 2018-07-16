//
//  AudioMidiEngine.swift
//  XY-Music
//
//  Created by kl on 25/11/2017.
//  Copyright © 2017 kl. All rights reserved.
//

import Foundation
import AudioKit


class AudioMidiEngine {
    
    static let sharedInstance = AudioMidiEngine()
    
    let midiOut = AKMIDI()
    var sequencer: AKSequencer!
    var callbackInstrument: AKCallbackInstrument!
    var mixer = AKMixer()
    var drumKit = AKMIDISampler()
    
    let sequenceLength = AKDuration(beats: 8)
    
    var midiEnable: Bool = true
    var audioEnable: Bool = true
    var midiChannel: UInt8 = 1
    
    var currentTempo = 120.0 {
        didSet {
            sequencer.setTempo(currentTempo)
        }
    }
    
    var midiFileInstrument = "Drums" {
        didSet {
            updateMidiFile()
            updateSamplerInstrument()
        }
    }
    
    var midiFileStyle = "HipHop" {
        didSet {
            updateMidiFile()
        }
    }
    
    var midiFileSelectedNumber = "1" {
        didSet {
            updateMidiFile()
        }
    }
    
    var velocityFactor: Double = 80
    
    init() {
        mixer.connect(input: drumKit)
        AudioKit.output = mixer
        midiOut.createVirtualOutputPort()
        midiOut.openOutput()
    
        do {
            try drumKit.loadEXS24("Sounds/Sampler Instruments/\(midiFileInstrument)")
        } catch {
            print("A file was not found")
        }
        
        
        do {
            try AudioKit.start()
        } catch {
            print("Audiokit can't start")
        }
      
        setCallBackInstrument()
        updateMidiFile()
    }

    func updateSamplerInstrument(){
        do {
            try drumKit.loadEXS24("Sounds/Sampler Instruments/\(midiFileInstrument)")
            print("in updateSamplerInstrument: \(midiFileInstrument)")
        } catch {
            print("A file was not found")
        }
    }
    
    func updateMidiFile() {
        loadMidiFile(midiFileInstrument: self.midiFileInstrument, midiFileStyle: self.midiFileStyle, midiFileSelectedNumber: self.midiFileSelectedNumber)
    }
    
    func loadMidiFile(midiFileInstrument: String, midiFileStyle:String, midiFileSelectedNumber: String) {
        
        let path = "Sounds/midi/\(midiFileInstrument)/\(midiFileStyle)/\(midiFileSelectedNumber)"
        sequencer = AKSequencer(filename: path)
        sequencer.setTempo(currentTempo)
        sequencer.enableLooping(sequenceLength)
        
        sequencer.setGlobalMIDIOutput(self.callbackInstrument.midiIn)
    }
    
    func isAudioEnable(){
        if  (mixer.volume == 0) {
            audioEnable = false
        } else {
            audioEnable = true
        }
    }
    
    func playPauseSequence() {
        if sequencer.isPlaying {
            sequencer.stop()
            print("stop")
        } else {
            sequencer.play()
            print("play")
        }
    }
    
    func setCallBackInstrument(){
        self.callbackInstrument = AKCallbackInstrument() { status, note, velocity in
            if (self.midiEnable) {
                switch (status) {
                case .noteOn:
                    self.midiOut.sendNoteOnMessage(noteNumber: note, velocity: MIDIVelocity(self.velocityFactor), channel: MIDIChannel(self.midiChannel))
                case .noteOff:
                    self.midiOut.sendNoteOffMessage(noteNumber: note, velocity: MIDIVelocity(self.velocityFactor), channel: MIDIChannel(self.midiChannel) )
                default:
                    print("did nothing")
                }
            }
            try! self.drumKit.play(noteNumber: note, velocity: velocity, channel: self.midiChannel)
        }
    }

}
