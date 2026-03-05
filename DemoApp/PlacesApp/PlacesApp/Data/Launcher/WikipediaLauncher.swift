//
//  WikipediaLauncher.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import UIKit

struct WikipediaLauncher {

    private let canOpenURL: URLOpener

    var canLaunch: Bool {
        do {
            let wikiPediaURl = try URL.wikipediaOpenURLWith(longitude: 0.0, latitude: 0.0)
            return canOpenURL.canOpenURL(wikiPediaURl)
        } catch {
            return false
        }
    }

    init(urlOpener: URLOpener = UIApplication.shared) {
        self.canOpenURL = urlOpener
    }

    func launchWith(longitude: Double, latitude: Double) {
        guard
            let wikiPediaURl = try? URL.wikipediaOpenURLWith(longitude: longitude, latitude: latitude),
            canOpenURL.canOpenURL(wikiPediaURl)
        else { return }

        canOpenURL.open(wikiPediaURl, options: [:], completionHandler: nil)
    }
}
