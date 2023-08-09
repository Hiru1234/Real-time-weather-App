//
//  AirModelData.swift
//  CourseWork2Starter
//
//

import Foundation

struct AirModelData: Codable {
    let coord: Coord
    let list: [AirPollutionDataList]
    ;
}

// cooding keys

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct AirPollutionDataList: Codable {
    let main: AirPollutionMain
    let components: Component
    let dt: Int
}

struct AirPollutionMain: Codable {
    let aqi: Int
}

struct Component: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}
