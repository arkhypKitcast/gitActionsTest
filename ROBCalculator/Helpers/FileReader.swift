//
//  FileReader.swift
//  ROBCalculator
//
//  Created by arkhyp on 27.04.2022.
//

import Foundation

class FileReader {
    let bundle: Bundle
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = bundle.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
