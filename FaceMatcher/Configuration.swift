//
//  Configuration.swift
//  FaceMatcher
//
//  Created by Erik Partridge on 8/12/22.
//

import Foundation

enum Ethnicity: Int16, CustomStringConvertible {
    
    static func from(_ stringValue: String) -> Ethnicity? {
        switch stringValue {
        case "MENA": return .mena
        case "MESA": return .mesa
        case "Scandinavian": return .scandinavian
        case "YugoGreek": return .yugoGreek
        case "African": return .african
        case "SpanMed": return .spanMed
        case "EECA": return .eeca
        case "Central European": return .centralEuropean
        case "South American": return .southAmerican
        case "Asian": return .asian
        case "Seasian": return .seasian
        case "Caucasian": return .caucasian
        case "ItalMed": return .italMed
        case "SAMed": return .samed
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .mena: return "MENA"
        case .mesa: return "MESA"
        case .scandinavian: return "Scandinavian"
        case .yugoGreek: return "YugoGreek"
        case .african: return "African"
        case .spanMed: return "SpanMed"
        case .eeca: return "EECA"
        case .centralEuropean: return "Central European"
        case .southAmerican: return "South American"
        case .asian: return "Asian"
        case .seasian: return "Seasian"
        case .caucasian: return "Caucasian"
        case .italMed: return "ItalMed"
        case .samed: return "SAMed"
        }
    }
    case mena, mesa, scandinavian, yugoGreek, african, spanMed, eeca, centralEuropean, southAmerican, asian, seasian, caucasian, italMed, samed
    
    static let southAmericanProvidingEthnicities: Set<Ethnicity> = [.scandinavian, .seasian, .centralEuropean, .caucasian, .african, .asian, .mena, .mesa]
}

let nationalityEthnicityMap: [String: Ethnicity] = [
    "AFG": .mesa,
    "AXL": .scandinavian,
    "ALB": .yugoGreek,
    "ALG": .mena,
    "ASA": .african,
    "AND": .spanMed,
    "ANG": .african,
    "AIA": .african,
    "ATG": .african,
    "ARG": .samed,
    "ARM": .eeca,
    "ARU": .african,
    "AUS": .centralEuropean,
    "AUT": .centralEuropean,
    "AZE": .eeca,
    "BAS": .spanMed,
    "BAH": .african,
    "BHR": .mesa,
    "BAN": .mesa,
    "BRB": .african,
    "BLR": .eeca,
    "BEL": .centralEuropean,
    "BLZ": .southAmerican,
    "BEN": .african,
    "BER": .african,
    "BHU": .asian,
    "BOL": .southAmerican,
    "BIH": .yugoGreek,
    "BOT": .african,
    "BRA": .southAmerican,
    "VGB": .african,
    "BRU": .seasian,
    "BUL": .eeca,
    "BFA": .african,
    "BDI": .african,
    "CAM": .seasian,
    "CMR": .african,
    "CAN": .caucasian,
    "CPV": .african,
    "CAY": .african,
    "CTA": .african,
    "CHA": .african,
    "CHI": .southAmerican,
    "CHN": .asian,
    "COL": .southAmerican,
    "COM": .african,
    "COD": .african,
    "CGO": .african,
    "COK": .african,
    "CRC": .southAmerican,
    "CIV": .african,
    "CRO": .yugoGreek,
    "CUB": .southAmerican,
    "CUW": .african,
    "CYP": .mena,
    "CZE": .eeca,
    "DEN": .scandinavian,
    "DJI": .african,
    "DMA": .african,
    "DOM": .southAmerican,
    "ECU": .southAmerican,
    "EGY": .mena,
    "SLV": .southAmerican,
    "ENG": .caucasian,
    "EQG": .african,
    "ERI": .african,
    "EST": .eeca,
    "SWZ": .african,
    "ETH": .african,
    "FRO": .scandinavian,
    "FIJ": .african,
    "FIN": .scandinavian,
    "FRA": .centralEuropean,
    "TAH": .african,
    "GAB": .african,
    "GAM": .african,
    "GEO": .eeca,
    "GER": .centralEuropean,
    "GHA": .african,
    "GIB": .caucasian,
    "GRE": .yugoGreek,
    "GRL": .caucasian,
    "GRN": .african,
    "GLP": .african,
    "GUM": .african,
    "GUA": .southAmerican,
    "GUI": .african,
    "GNB": .african,
    "GUY": .african,
    "HAI": .african,
    "HON": .southAmerican,
    "HKG": .asian,
    "HUN": .centralEuropean,
    "ISL": .scandinavian,
    "IND": .mesa,
    "IDN": .seasian,
    "IRN": .mesa,
    "IRQ": .mesa,
    "IRL": .caucasian,
    "ISR": .mena,
    "ITA": .italMed,
    "JAM": .african,
    "JPN": .asian,
    "JOR": .mesa,
    "KAZ": .eeca,
    "KEN": .african,
    "KIR": .african,
    "PRK": .asian,
    "KOR": .asian,
    "KVX": .yugoGreek,
    "KUW": .mesa,
    "KGZ": .eeca,
    "LAO": .seasian,
    "LVA": .eeca,
    "LBN": .mena,
    "LES": .african,
    "LBR": .african,
    "LBY": .african,
    "LIE": .centralEuropean,
    "LTU": .eeca,
    "LUX": .centralEuropean,
    "MAC": .asian,
    "MAD": .african,
    "MWI": .african,
    "MAS": .seasian,
    "MDV": .african,
    "MLI": .african,
    "MLT": .italMed,
    "MTQ": .african,
    "MTN": .african,
    "MRI": .african,
    "MEX": .southAmerican,
    "FSM": .african,
    "MDA": .eeca,
    "MON": .italMed,
    "MNG": .asian,
    "MNE": .yugoGreek,
    "MSR": .african,
    "MAR": .mena,
    "MOZ": .african,
    "MYA": .seasian,
    "NAM": .african,
    "NEP": .mesa,
    "NED": .centralEuropean,
    "NCL": .african,
    "NZL": .caucasian,
    "NCA": .southAmerican,
    "NIG": .african,
    "NGA": .african,
    "NIU": .african,
    "NIR": .caucasian,
    "NMI": .african,
    "MKD": .eeca,
    "NOR": .scandinavian,
    "OMA": .mesa,
    "PAK": .mesa,
    "PLW": .african,
    "PLE": .mesa,
    "PAN": .southAmerican,
    "PNG": .african,
    "PAR": .southAmerican,
    "PER": .southAmerican,
    "PHI": .seasian,
    "POL": .centralEuropean,
    "POR": .spanMed,
    "PUR": .southAmerican,
    "QAT": .mesa,
    "REU": .african,
    "ROU": .eeca,
    "RUS": .eeca,
    "RWA": .african,
    "SKN": .african,
    "LCA": .african,
    "SMN": .african,
    "VIN": .african,
    "SAM": .african,
    "SMR": .italMed,
    "STP": .african,
    "KSA": .mesa,
    "SCO": .caucasian,
    "SEN": .african,
    "SRB": .yugoGreek,
    "SEY": .african,
    "SLE": .african,
    "SIN": .seasian,
    "SMA": .african,
    "SVK": .centralEuropean,
    "SVN": .yugoGreek,
    "SOL": .african,
    "SOM": .african,
    "RSA": .african,
    "SSD": .african,
    "ESP": .spanMed,
    "SRI": .african,
    "SDN": .african,
    "SUR": .african,
    "SWE": .scandinavian,
    "SUI": .centralEuropean,
    "SYR": .mesa,
    "TPE": .asian,
    "TJK": .eeca,
    "TAN": .african,
    "THA": .seasian,
    "TLS": .african,
    "TOG": .african,
    "TGA": .african,
    "TRI": .african,
    "TUN": .mena,
    "TUR": .mena,
    "TKM": .eeca,
    "TCA": .african,
    "TUV": .african,
    "UGA": .african,
    "UKR": .eeca,
    "UAE": .mesa,
    "GBR": .caucasian,
    "USA": .caucasian,
    "VIR": .african,
    "URU": .samed,
    "UZB": .eeca,
    "VAN": .african,
    "VAT": .caucasian,
    "VEN": .southAmerican,
    "VIE": .seasian,
    "WAL": .caucasian,
    "YEM": .mesa,
    "ZAM": .african,
    "ZIM": .african,
    "ZAN": .african,
    "LIB": .mena,
    "GUF": .african,
    "WFI": .african,
    "SUD": .mena,
    "MAY": .african,
    "BOE": .african,
    "BLM": .caucasian,
    "SPM": .caucasian
]

