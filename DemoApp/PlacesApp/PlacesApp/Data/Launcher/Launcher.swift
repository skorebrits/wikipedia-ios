//
//  Launcher.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import UIKit

struct Launcher {

    private let canOpenURL: URLOpener

    init(urlOpener: URLOpener = UIApplication.shared) {
        self.canOpenURL = urlOpener
    }

    func canLaunchURL(url: URL) -> Bool {
        return canOpenURL.canOpenURL(url)
    }

    func launchWith(url: URL) async {
        guard canLaunchURL(url: url) else { return }

        await _ = canOpenURL.open(url, options: [:])
    }
}
