//
//  CalculationsDataset.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 03/12/2024.
//

import Foundation

final class CalculationProcessor: Sendable {

    private let instructions: [Instruction]

    init(instructions: [Instruction]) {
        self.instructions = instructions
    }

    func sumOfAllMultiplications() -> Int {
        instructions.reduce(0) { result, instruction in
            switch instruction {
            case .multiple(let i, let j):
                return result + (i * j)
            default:
                return result
            }
        }
    }

    func sumOfAllMultiplicationsWithConditionals() -> Int {
        var result = 0
        var isEnabled = true
        for instruction in instructions {
            switch instruction {
            case .enable:
                isEnabled = true
            case .disable:
                isEnabled = false
            case .multiple(let i, let j):
                result += (isEnabled ? (i * j) : 0)
            }
        }

        return result
    }

}

extension CalculationProcessor {

    enum Instruction {
        case multiple(Int, Int)
        case enable
        case disable
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
        let ranges = data.ranges(of: /(mul\(\d+,\d+\)|do\(\)|don't\(\))/)
        var instructions: [Instruction] = []

        for range in ranges {
            let instructionString = String(data[range])

            if instructionString.starts(with: "do(") {
                instructions.append(.enable)
                continue
            }

            if instructionString.starts(with: "don't(") {
                instructions.append(.disable)
                continue
            }

            guard
                let numberPair =
                    instructionString
                    .split(separator: "(").last?
                    .split(separator: ")").first
            else {
                continue
            }

            let numbers = numberPair.split(separator: ",").compactMap { Int($0) }
            guard numbers.count == 2 else {
                continue
            }

            instructions.append(.multiple(numbers[0], numbers[1]))
        }

        self.init(instructions: instructions)
    }

}
