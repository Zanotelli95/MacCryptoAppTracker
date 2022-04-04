//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Fabian Zanotelli Oviedo on 03/04/22.
//

import Cocoa

class ViewController: NSViewController {
    var apitIMER: Timer?
    
    let increase: NSColor = NSColor(red: 0.2, green: 0.5, blue: 1.0, alpha: 1.0)
    let decrease: NSColor = NSColor(red: 0.72, green: 0.25, blue: 0.96, alpha: 1.0)

    
  
    @IBOutlet weak var btcUsd: NSTextField!
    @IBOutlet weak var ethUsd: NSTextField!
    @IBOutlet weak var ltcUsd: NSTextField!
    
    @IBOutlet weak var btcPercent: NSTextField!
    
    @IBOutlet weak var ethPercent: NSTextField!
    
    @IBOutlet weak var ltcPercent: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startCheckingPrices()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func quitBottom(_ sender: Any) {
        NSApplication.shared.terminate(sender)
    }
    
}

extension ViewController {
    func setTextColor(label: [NSTextField], increased: Bool){
        if increased {
            for l in label {
                l.textColor = increase
            }
        } else {
            for l in label {
                l.textColor = decrease
            }
        }
    }
}

extension ViewController{
    func startCheckingPrices(){
        let btcLabels: [NSTextField] = [btcUsd, btcPercent]
        let ethLabels: [NSTextField] = [ethUsd, ethPercent]
        let ltcLabels: [NSTextField] = [ltcUsd, ltcPercent]
        
        apitIMER = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            
            for ticker in Ticker.allCases{
                Task {
                    let crypto = try await BlockchainAPI.getCryto(ticker: ticker)
                    
                    let lastTradePrice = crypto.lastTradePrice
                    let price24H = crypto.price24H
                    
                    let percentChange = (lastTradePrice - price24H) / price24H * 100
                    let percentString = String(format: "%.2f", percentChange)
                    
                    switch ticker {
                    case .btc:
                        self.setTextColor(label: btcLabels, increased: (lastTradePrice > price24H))
                        self.btcUsd.stringValue = String("$" + String(lastTradePrice))
                        self.btcPercent.stringValue = "\(lastTradePrice > price24H ? "+" : "") \(percentString) %"

                    case .eth:
                        self.setTextColor(label: ethLabels, increased: (lastTradePrice > price24H))
                        self.ethUsd.stringValue = String("$" + String(lastTradePrice))
                        self.ethPercent.stringValue = "\(lastTradePrice > price24H ? "+" : "") \(percentString) %"
                        
                    case .ltc:
                        self.setTextColor(label: ltcLabels, increased: (lastTradePrice > price24H))
                        self.ltcUsd.stringValue = String("$" + String(lastTradePrice))
                        self.ltcPercent.stringValue = "\(lastTradePrice > price24H ? "+" : "") \(percentString) %"
                    }

                }
            }
        }
    }
}

