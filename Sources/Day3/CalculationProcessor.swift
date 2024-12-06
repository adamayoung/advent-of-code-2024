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

    convenience init() async throws {
        guard let inputFileURL = Bundle.module.url(forResource: "input", withExtension: "txt")
        else {
            fatalError("input file missing")
        }

        try await self.init(fileURL: inputFileURL)
    }

    func sumOfAllMultiplications(withConditionals: Bool = false) -> Int {
        var result = 0
        var isEnabled = true
        for instruction in instructions {
            switch instruction {
            case .enable where withConditionals:
                isEnabled = true

            case .disable where withConditionals:
                isEnabled = false

            case .multiple(let i, let j):
                result += (isEnabled ? (i * j) : 0)

            default:
                break
            }
        }

        return result
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
            guard let instruction = Instruction(instructionString) else {
                continue
            }

            instructions.append(instruction)
        }

        self.init(instructions: instructions)
    }

}

extension CalculationProcessor {

    enum Instruction {
        case multiple(Int, Int)
        case enable
        case disable
    }

}

extension CalculationProcessor.Instruction {

    init?(_ instructionString: String) {
        if let instruction = Self.parseDoInstruction(instructionString) {
            self = instruction
            return
        }

        if let instruction = Self.parseDontInstruction(instructionString) {
            self = instruction
            return
        }

        if let instruction = Self.parseMulInstruction(instructionString) {
            self = instruction
            return
        }

        return nil
    }

    private static func parseDoInstruction(_ instructionString: String) -> Self? {
        guard instructionString.starts(with: "do(") else {
            return nil
        }

        return .enable
    }

    private static func parseDontInstruction(_ instructionString: String) -> Self? {
        guard instructionString.starts(with: "don't(") else {
            return nil
        }

        return .disable
    }

    private static func parseMulInstruction(_ instructionString: String) -> Self? {
        guard instructionString.starts(with: "mul(") else {
            return nil
        }

        guard
            let numberPair =
                instructionString
                .split(separator: "(").last?
                .split(separator: ")").first
        else {
            return nil
        }

        let numbers = numberPair.split(separator: ",").compactMap { Int($0) }
        guard numbers.count == 2 else {
            return nil
        }

        return .multiple(numbers[0], numbers[1])
    }

}
