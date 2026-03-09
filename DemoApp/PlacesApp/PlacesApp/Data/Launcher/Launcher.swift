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

    func launchWith(url: URL) {
        guard canLaunchURL(url: url) else { return }

        canOpenURL.open(url, options: [:], completionHandler: nil)
    }
}
