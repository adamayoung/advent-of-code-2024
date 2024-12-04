//
//  NumberOfXxMASOccurencesTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Testing

@testable import Day4

@Suite("Number of X-MAS occurences tests")
struct NumberOfXxMASOccurencesTests {

    @Test("numberOfXxMASOccurrences when using test data 1 returns correct result")
    func xxMASOccurrencesWhenWhenUsingTestData1ReturnsCorrectResult() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["M", ".", "S"],
                [".", "A", "."],
                ["M", ".", "S"]
            ]
        )

        let count = await wordsearch.numberOfXxMASOccurrences()

        #expect(count == 1)
    }

    @Test("numberOfXxMASOccurrences when using test data 2 returns correct result")
    func xxMASOccurrencesWhenWhenUsingTestData2ReturnsCorrectResult() async {
        let wordsearch = Wordsearch(
            characterMap: [
                [".", "M", ".", "S", ".", ".", ".", ".", ".", "."],
                [".", ".", "A", ".", ".", "M", "S", "M", "S", "."],
                [".", "M", ".", "S", ".", "M", "A", "A", ".", "."],
                [".", ".", "A", ".", "A", "S", "M", "S", "M", "."],
                [".", "M", ".", "S", ".", "M", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                ["S", ".", "S", ".", "S", ".", "S", ".", "S", "."],
                [".", "A", ".", "A", ".", "A", ".", "A", ".", "."],
                ["M", ".", "M", ".", "M", ".", "M", ".", "M", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
            ]
        )

        let count = await wordsearch.numberOfXxMASOccurrences()

        #expect(count == 9)
    }

}
