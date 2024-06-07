struct ToursResponse: Codable {
    let status: String
    let results: Int
    let data: TourData
}

struct TourData: Codable {
    let data: [Tour]
}

struct Tour: Codable, Identifiable {
    let id: String
    let name: String
    let difficulty: String
    let price: Int
    let summary: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case difficulty
        case price
        case summary
    }
}
