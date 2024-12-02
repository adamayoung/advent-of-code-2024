import Testing
@testable import Day1

@Suite
struct Day1Tests {

    @Test
    func totalDistanceWithOneSetOfLocationsWhichAreZeroReturnsZero() {
        let locations1 = [0]
        let locations2 = [0]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        let result = dataset.totalDistance

        #expect(result == 0)
    }

    @Test
    func totalDistanceWithOneSetOfLocationsWhichHaveADistanceOfOneReturnsOne() {
        let locations1 = [0]
        let locations2 = [1]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        let result = dataset.totalDistance

        #expect(result == 1)
    }

    @Test
    func totalDistanceWithOneSetOfLocationsWhichHaveADistanceOfNegativeOneReturnsOne() {
        let locations1 = [1]
        let locations2 = [0]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        let result = dataset.totalDistance

        #expect(result == 1)
    }

    @Test
    func totalDistanceWithOneSetOfLocationsReturnsCorrectResult() {
        let locations1 = [1, 5, 2, 9, 1]
        let locations2 = [5, 8, 10, 2, 123]

        let dataset = LocationDataset(locations1: locations1, locations2: locations2)

        let result = dataset.totalDistance

        #expect(result == 130)
    }

}
