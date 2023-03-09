//
//  SplashScreenStateManager.swift
//  arvo
//
//  Created by reed kuivila on 3/9/23.
//

import Foundation

final class SplashScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: SplashScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished
        }
    }
}
