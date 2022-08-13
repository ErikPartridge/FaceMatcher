//
//  PlayerRecord+Ethnicity.swift
//  FaceMatcher
//
//  Created by Erik Partridge on 8/13/22.
//

import Foundation

extension PlayerRecord {
    
    var resolvedEthnicity: Ethnicity! {
        return Ethnicity(rawValue: self.resolvedEthnicityIntValue)
    }
    
    func resolveAndUpdateEthnicity() {
        guard resolvedEthnicity == nil else { return }
        var playerNationalEthnicities = [Ethnicity]()
        if let nationality = nationality, let firstNationalityEthnicity = nationalityEthnicityMap[nationality] {
            playerNationalEthnicities.append(firstNationalityEthnicity)
        }
        if let nationality = secondNationality, let secondNationalityEthnicity = nationalityEthnicityMap[nationality] {
            playerNationalEthnicities.append(secondNationalityEthnicity)
        }
        switch self.ethnicity {
        case 0:
            if playerNationalEthnicities.contains(.scandinavian) {
                self.resolvedEthnicityIntValue = Ethnicity.scandinavian.rawValue
            } else if playerNationalEthnicities.contains(.caucasian) {
                self.resolvedEthnicityIntValue = Ethnicity.caucasian.rawValue
            } else {
                self.resolvedEthnicityIntValue = Ethnicity.centralEuropean.rawValue
            }
        case 1:
            if !Set(playerNationalEthnicities).intersection(Ethnicity.southAmericanProvidingEthnicities).isEmpty || playerNationalEthnicities.contains(.southAmerican) {
                self.resolvedEthnicityIntValue = Ethnicity.southAmerican.rawValue
            } else if playerNationalEthnicities.contains(.yugoGreek) {
                self.resolvedEthnicityIntValue = Ethnicity.yugoGreek.rawValue
            } else if playerNationalEthnicities.contains(.spanMed) {
                self.resolvedEthnicityIntValue = Ethnicity.spanMed.rawValue
            } else if playerNationalEthnicities.contains(.samed) {
                self.resolvedEthnicityIntValue = Ethnicity.samed.rawValue
            } else if playerNationalEthnicities.contains(.italMed) {
                self.resolvedEthnicityIntValue = Ethnicity.italMed.rawValue
            } else if playerNationalEthnicities.contains(.eeca) {
                self.resolvedEthnicityIntValue = Ethnicity.eeca.rawValue
            }
        case 2:
            if playerNationalEthnicities.contains(.mesa) {
                self.resolvedEthnicityIntValue = Ethnicity.mesa.rawValue
            } else {
                self.resolvedEthnicityIntValue = Ethnicity.mena.rawValue
            }
        case 4:
            self.resolvedEthnicityIntValue = Ethnicity.mesa.rawValue
        case 5:
            self.resolvedEthnicityIntValue = Ethnicity.seasian.rawValue
        case 7:
            if playerNationalEthnicities.first == .samed {
                self.resolvedEthnicityIntValue = Ethnicity.samed.rawValue
            } else if playerNationalEthnicities.first == .southAmerican {
                self.resolvedEthnicityIntValue = Ethnicity.southAmerican.rawValue
            } else {
                self.resolvedEthnicityIntValue = Ethnicity.african.rawValue
            }
        case 10:
            if playerNationalEthnicities.first == .southAmerican {
                self.resolvedEthnicityIntValue = Ethnicity.southAmerican.rawValue
            } else {
                self.resolvedEthnicityIntValue = Ethnicity.asian.rawValue
            }
        default:
            guard [3, 6, 8, 9].contains(self.ethnicity) else {
                assert(false)
            }
            self.resolvedEthnicityIntValue = Ethnicity.african.rawValue
        }
    }
    
    func assignPhoto(imageManager: ImageFileManager, overwriting: Bool = false) {
        if !overwriting && self.photoIdentifier != nil {
            return
        }
        let options = imageManager.ethnicityMap[resolvedEthnicity]!
        self.photoIdentifier = options.randomElement()!
    }
}
