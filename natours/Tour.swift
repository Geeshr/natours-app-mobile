import Foundation

struct ToursResponse: Decodable {
    let status: String
    let results: Int
    let data: ToursData
}

struct ToursData: Decodable {
    let data: [Tour]
}

struct Tour: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let duration: Int?
    let price: Double
    let ratingsQuantity: Int?
    let ratingsAverage: Double?
    let maxGroupSize: Int
    let difficulty: String
    // Add other fields as necessary
    // Note: Change data types as per the actual data
}
