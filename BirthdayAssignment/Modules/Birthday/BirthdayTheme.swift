//
//  BirthdayTheme.swift
//  BirthdayAssignment
//
//  Created by Telem Tobi on 28/01/2024.
//

import SwiftUI

extension BirthdayViewController {
    
    enum Theme: CaseIterable {
        case yellow, green, blue
        
        var backgroundColor: ColorResource {
            return switch self {
            case .yellow: .bgYellow
            case .green: .bgGreen
            case .blue: .bgBlue
            }
        }
        
        var foregroundColor: ColorResource {
            return switch self {
            case .yellow: .fgYellow
            case .green: .fgGreen
            case .blue: .fgBlue
            }
        }
        
        var backgroundResource: ImageResource {
            return switch self {
            case .yellow: .bgElephant
            case .green: .bgFox
            case .blue: .bgPelican
            }
        }
        
        var picturePlaceholder: ImageResource {
            return switch self {
            case .yellow: .defaultPlaceHolderYellow
            case .green: .defaultPlaceHolderGreen
            case .blue: .defaultPlaceHolderBlue
            }
        }
        
        var cameraIcon: ImageResource {
            return switch self {
            case .yellow: .cameraIconYellow
            case .green: .cameraIconGreen
            case .blue: .cameraIconBlue
            }
        }
    }
}
