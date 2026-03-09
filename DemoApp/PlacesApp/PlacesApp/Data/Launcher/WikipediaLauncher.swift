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
        guard let wikiPediaURl = URL.wikipediaOpenURLWith(longitude: 0.0, latitude: 0.0) else {
            return false
        }
        return canOpenURL.canOpenURL(wikiPediaURl)
    }

    init(urlOpener: URLOpener = UIApplication.shared) {
        self.canOpenURL = urlOpener
    }

    func launchWith(longitude: Double, latitude: Double) {
        guard
            let wikipediaURl = URL.wikipediaOpenURLWith(longitude: longitude, latitude: latitude),
            canOpenURL.canOpenURL(wikipediaURl)
        else { return }

        canOpenURL.open(wikipediaURl, options: [:], completionHandler: nil)
    }
}
