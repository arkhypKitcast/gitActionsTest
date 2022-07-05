//
//  Data+Extensions.swift
//  ROBCalculator
//
//  Created by arkhyp on 27.04.2022.
//

import Foundation

extension Data {
    func parseJson<T: Decodable>() -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            print("Decode Error: \(error.localizedDescription)")
            return nil
        }
    }
}
