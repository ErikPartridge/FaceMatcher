//
//  ImageFileManager.swift
//  FaceMatcher
//
//  Created by Erik Partridge on 8/13/22.
//

import Foundation

enum ImageError: Error {
    case noInstalledFacepack
}

struct ImageFileManager {
    let ethnicityMap: [Ethnicity: [String]]
    
    init(basePath: URL) throws {
        let ethnicityDirectories = try FileManager.default.contentsOfDirectory(atPath: basePath.path)
        ethnicityMap = try ethnicityDirectories.reduce(into: [Ethnicity: [String]]()) { partial, ethnicityString in
            guard let ethnicity = Ethnicity.from(ethnicityString) else {
                return
            }
            let photoFiles = try FileManager.default.contentsOfDirectory(atPath: basePath.appendingPathComponent(ethnicityString, isDirectory: true).path).filter { $0.hasSuffix(".png") }.map { ethnicityString + "/" + $0 }
            partial[ethnicity] = photoFiles
        }
    }
    
    init() throws {
        let url = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Public", isDirectory: true)
            .appendingPathComponent("Sports Interactive", isDirectory: true)
            .appendingPathComponent("Football Manager 2022", isDirectory: true)
            .appendingPathComponent("Graphics", isDirectory: true)
            .appendingPathComponent("FMNewGANv2 + Update 1", isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            throw ImageError.noInstalledFacepack
        } else {
            try self.init(basePath: url)
        }
    }
    
}
