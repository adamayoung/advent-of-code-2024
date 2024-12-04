//
//  XmasSearchTests.swift
//  advent-of-code-2024
//
//  Created by Adam Young on 04/12/2024.
//

import Testing

@testable import Day4

@Suite("Number of XMAS occurences tests")
struct NumberOfXMASOccurencesTests {

    @Test("numberOfXMASOccurrences when contains XMAS from left to right returns 1")
    func xmasOccurrencesWhenContainsXMASFromLeftToRightReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["X", "M", "A", "S"]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test("numberOfXMASOccurrences when contains XMAS from right to left returns 1")
    func xmasOccurrencesWhenContainsXMASFromRightToLeftReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["S", "A", "M", "X"]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test("numberOfXMASOccurrences when contains XMAS from top to bottom returns 1")
    func xmasOccurrencesWhenContainsXMASFromTopToBottomReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["X"],
                ["M"],
                ["A"],
                ["S"]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test("numberOfXMASOccurrences when contains XMAS from bottom to top returns 1")
    func xmasOccurrencesWhenContainsXMASFromBottomToTopReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["S"],
                ["A"],
                ["M"],
                ["X"]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test(
        "numberOfXMASOccurrences when contains XMAS from diagonal top left to bottom right returns 1"
    )
    func xmasOccurrencesWhenContainsXMASFromDiagonalTopLeftToBottomRightReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["X", ".", ".", "."],
                [".", "M", ".", "."],
                [".", ".", "A", "."],
                [".", ".", ".", "S"]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test(
        "numberOfXMASOccurrences when contains XMAS from diagonal top right to bottom left returns 1"
    )
    func xmasOccurrencesWhenContainsXMASFromDiagonalTopRightToBottomLeftReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                [".", ".", ".", "X"],
                [".", ".", "M", "."],
                [".", "A", ".", "."],
                ["S", ".", ".", "."]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test(
        "numberOfXMASOccurrences when contains XMAS from diagonal bottom left to top right returns 1"
    )
    func xmasOccurrencesWhenContainsXMASFromDiagonalBottomLeftToTopRightReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                [".", ".", ".", "S"],
                [".", ".", "A", "."],
                [".", "M", ".", "."],
                ["X", ".", ".", "."]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test(
        "numberOfXMASOccurrences when contains XMAS from diagonal bottom right to top left returns 1"
    )
    func xmasOccurrencesWhenContainsXMASFromDiagonalBottomRightToTopLeftReturns1() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["S", ".", ".", "."],
                [".", "A", ".", "."],
                [".", ".", "M", "."],
                [".", ".", ".", "X"]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 1)
    }

    @Test("numberOfXMASOccurrences when using subset of test data 1 returns correct result")
    func xmasOccurrencesWhenUsingSubsetOfTestData1ReturnsCorrectResult() async {
        let wordsearch = Wordsearch(
            characterMap: [
                [".", ".", ".", ".", ".", "."],
                [".", "S", ".", ".", ".", "."],
                [".", "A", ".", ".", ".", "."],
                ["X", "M", "A", "S", ".", "."],
                [".", "X", ".", ".", ".", "."]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 2)
    }

    @Test("numberOfXMASOccurrences when 2 XMASes start from same coordinate returns 2")
    func xmasOccurrencesWhen2XMASesStartFromSameCoordinateReturns2() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["X", "M", "A", "S", ".", "."],
                ["M", ".", ".", ".", ".", "."],
                ["A", ".", ".", ".", ".", "."],
                ["S", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", "."]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 2)
    }

    @Test("numberOfXMASOccurrences when using test data 1 returns correct result")
    func xmasOccurrencesWhenUsingTestData1ReturnsCorrectResult() async {
        let wordsearch = Wordsearch(
            characterMap: [
                [".", ".", "X", ".", ".", "."],
                [".", "S", "A", "M", "X", "."],
                [".", "A", ".", ".", "A", "."],
                ["X", "M", "A", "S", ".", "S"],
                [".", "X", ".", ".", ".", "."]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 4)
    }

    @Test("numberOfXMASOccurrences when using test data 2 returns correct result")
    func xmasOccurrencesWhenUsingTestData2ReturnsCorrectResult() async {
        let wordsearch = Wordsearch(
            characterMap: [
                ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
                ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
                ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
                ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
                ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
                ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
                ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
                ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
                ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
                ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]
            ]
        )

        let count = await wordsearch.numberOfXMASOccurrences()

        #expect(count == 18)
    }

}
