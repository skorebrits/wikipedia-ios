//
//  URLOpener.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import UIKit

protocol URLOpener {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any]) async -> Bool
}
