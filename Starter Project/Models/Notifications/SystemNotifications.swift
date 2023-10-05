//
//  SystemNotifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation

struct SystemNotifications {
    // Send this notification when the LanguageCoordinator content is ready or updates language.
    static let onContentUpdate: Notification.Name = Notification.Name("onContentUpdate")
    // On Experience State Update
    static let onExperienceStateUpdate: Notification.Name = Notification.Name("onExperienceStateUpdate")
    // When Data is Updated
    static let onUpdatedData: Notification.Name = Notification.Name("onUpdatedData")
    // Send this notification when the DataCoordinator sets or updates the PokemonData
    static let onPokemonV2DataWasUpdated: Notification.Name = Notification.Name("onPokemonV2DataWasUpdated")
}
