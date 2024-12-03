//
//  CalculationsDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 03/12/2024.
//

import Foundation

final class CalculationProcessor: Sendable {

    private let multiplications: [(Int, Int)]

    init(multiplications: [(Int, Int)]) {
        self.multiplications = multiplications
    }

    func sumOfAllMultiplications() -> Int {
        multiplications.reduce(0) { result, m in
            result + (m.0 * m.1)
        }
    }

}

extension CalculationProcessor {

    convenience init(fileURL: URL) async throws {
        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var data: String = ""
        for try await line in handle.bytes.lines {
            data += line + "\n"
        }

        self.init(data: data)
    }

    convenience init(data: String) {
        let ranges = data.ranges(of: /mul\(\d+,\d+\)/)
        var multiplications: [(Int, Int)] = []
        for range in ranges {
            let mul = String(data[range])
            guard let numberPair = mul.split(separator: "(").last?.split(separator: ")").first
            else {
                continue
            }

            let numbers = numberPair.split(separator: ",").compactMap { Int($0) }
            guard numbers.count == 2 else {
                continue
            }

            multiplications.append((numbers[0], numbers[1]))
        }

        self.init(multiplications: multiplications)
    }

}
