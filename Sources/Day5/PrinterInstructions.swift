//
//  PrinterInstructions.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 05/12/2024.
//

import Foundation

final class PrinterInstructions: Sendable {

    private let pageOrderingRulesLookupTable: [Int: [Int]]
    private let pagesToProduceInUpdates: [[Int]]

    convenience init(
        pageOrderingRules: [(Int, Int)],
        pagesToProduceInUpdates: [[Int]]
    ) {
        let pageOrderingRulesLookupTable: [Int: [Int]] = pageOrderingRules.reduce(into: [:]) {
            $0[$1.0, default: []].append($1.1)
        }

        self.init(
            pageOrderingRulesLookupTable: pageOrderingRulesLookupTable,
            pagesToProduceInUpdates: pagesToProduceInUpdates
        )
    }

    init(
        pageOrderingRulesLookupTable: [Int: [Int]],
        pagesToProduceInUpdates: [[Int]]
    ) {
        self.pageOrderingRulesLookupTable = pageOrderingRulesLookupTable
        self.pagesToProduceInUpdates = pagesToProduceInUpdates
    }

    func sumOfMiddlePagesForCorrectlyOrderedUpdates() async -> Int {
        await withTaskGroup(of: Optional<Int>.self, returning: Int.self) { taskGroup in
            for pages in pagesToProduceInUpdates {
                taskGroup.addTask {
                    guard self.arePagesToProduceInCorrectOrder(pages) else {
                        return nil
                    }

                    let middlePageIndex = pages.count / 2
                    let middlePage = pages[middlePageIndex]
                    return middlePage
                }
            }

            return await taskGroup.reduce(into: 0) { sumOfMiddlePages, middlePage in
                if let middlePage {
                    sumOfMiddlePages += middlePage
                }
            }
        }
    }

    func sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrdering() async -> Int {
        await withTaskGroup(of: Optional<Int>.self, returning: Int.self) { taskGroup in
            for pages in pagesToProduceInUpdates {
                taskGroup.addTask {
                    guard !self.arePagesToProduceInCorrectOrder(pages) else {
                        return nil
                    }

                    let orderedPages = self.orderPages(pages)
                    let middlePageIndex = orderedPages.count / 2
                    let middlePage = orderedPages[middlePageIndex]

                    return middlePage
                }
            }

            return await taskGroup.reduce(into: 0) { sumOfMiddlePages, middlePage in
                if let middlePage {
                    sumOfMiddlePages += middlePage
                }
            }
        }
    }

    func sumOfMiddlePagesForIncorrectlyOrderedUpdatesAfterOrderingOld() async -> Int {
        let sum = pagesToProduceInUpdates.reduce(0) { sum, pagesToProduce in
            guard !arePagesToProduceInCorrectOrder(pagesToProduce) else {
                return sum
            }

            let orderedPagesToProduce = orderPages(pagesToProduce)
            let middlePageIndex = orderedPagesToProduce.count / 2
            let middlePage = orderedPagesToProduce[middlePageIndex]

            return sum + middlePage
        }

        return sum
    }

    private func arePagesToProduceInCorrectOrder(_ pages: [Int]) -> Bool {
        for (index, page) in pages.enumerated() {
            guard let pagesAfter = pageOrderingRulesLookupTable[page] else {
                continue
            }

            for pageAfter in pagesAfter {
                guard let pageAfterIndex = pages.firstIndex(of: pageAfter) else {
                    continue
                }

                guard index < pageAfterIndex else {
                    return false
                }
            }
        }

        return true
    }

    private func orderPages(_ pages: [Int]) -> [Int] {
        var orderedPages = pages

        for i in 0..<pages.count {
            let page = pages[i]
            guard let index = orderedPages.firstIndex(of: page) else {
                continue
            }

            guard let pagesAfter = pageOrderingRulesLookupTable[page] else {
                continue
            }

            let indexToMoveTo = pagesAfter.reduce(into: Int.max) { sum, pageAfter in
                if let pageAfterIndex = orderedPages.firstIndex(of: pageAfter) {
                    sum = min(sum, pageAfterIndex)
                }
            }

            guard index > indexToMoveTo else {
                continue
            }

            let pageToMove = orderedPages.remove(at: index)
            orderedPages.insert(pageToMove, at: indexToMoveTo)
        }

        return orderedPages
    }

}

extension PrinterInstructions {

    convenience init(fileURL: URL) async throws {
        guard let handle = try? FileHandle(forReadingFrom: fileURL) else {
            fatalError("cannot open input file")
        }

        defer {
            try? handle.close()
        }

        var pageOrderingRules: [(Int, Int)] = []
        var pagesToProduceInUpdates: [[Int]] = []
        for try await line in handle.bytes.lines {
            if let pageOrderingRule = Self.parsePageOrderingRule(from: line) {
                pageOrderingRules.append(pageOrderingRule)
                continue
            }

            if let pagesToProduce = Self.parsePagesToProduce(from: line) {
                pagesToProduceInUpdates.append(pagesToProduce)
            }
        }

        self.init(
            pageOrderingRules: pageOrderingRules,
            pagesToProduceInUpdates: pagesToProduceInUpdates
        )
    }

    private static func parsePageOrderingRule(from line: String) -> (Int, Int)? {
        guard !line.isEmpty else {
            return nil
        }

        let parts = line.split(separator: "|")
        guard parts.count == 2 else {
            return nil
        }

        guard let page1 = Int(parts[0]), let page2 = Int(parts[1]) else {
            return nil
        }

        return (page1, page2)
    }

    private static func parsePagesToProduce(from line: String) -> [Int]? {
        guard !line.isEmpty else {
            return nil
        }

        let parts = line.split(separator: ",")
        let pages = parts.compactMap { Int($0) }
        guard parts.count == pages.count else {
            return nil
        }

        return pages
    }

}