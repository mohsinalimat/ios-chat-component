//
//  FirebaseAuthentication.swift
//  ChatApp
//
//  Created by Tomas Cejka on 3/25/20.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseUI
import FirebaseFirestore

// MARK: - Simple solution for firebase authentication
final class FirebaseAuthentication: NSObject {

    private lazy var auth: Auth = Auth.auth()
    var user: User? {
        guard let firUser = auth.currentUser else {
            return nil
        }
        let user = User(id: firUser.uid, name: firUser.displayName ?? firUser.email ?? "", imageUrl: nil)
        return user
    }

    let database: Firestore
    private var loginCompletion: ((Result<User, Error>) -> Void)?

    deinit {
        print("\(self) deinit")
    }

    init(database: Firestore) {
        self.database = database
    }
}

// MARK: - Login view controller
extension FirebaseAuthentication {
    func authenticationViewController(loginCompletion: @escaping (Result<User, Error>) -> Void) -> UIViewController {
        self.loginCompletion = loginCompletion
        guard let authUI = FUIAuth.defaultAuthUI() else {
            fatalError("Unable to create login UI")
        }
        authUI.delegate = self
        authUI.providers = [FUIGoogleAuth(), FUIEmailAuth()]
        return authUI.authViewController()
    }
}

// MARK: - Store user
private extension FirebaseAuthentication {
    func storeUser(user: User, completion: @escaping ((Error?) -> Void)) {
        let reference = database.collection("users").document(user.id)
        do {
            try reference.setData(from: user) { error in
                completion(error)
            }
        } catch {
            fatalError("Unexpected error occured while storing user")
        }
    }
}

// MARK: - FUIAuthDelegate
extension FirebaseAuthentication: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FirebaseAuth.User?, error: Error?) {
        if let firUser = user {
            let user = User(id: firUser.uid, name: firUser.displayName ?? firUser.email ?? "", imageUrl: nil)
            storeUser(user: user) { [weak self] error in
                if let error = error {
                    self?.loginCompletion?(.failure(error))
                } else {
                    self?.loginCompletion?(.success(user))
                }
            }
            loginCompletion?(.success(user))
        } else if let error = error {
            loginCompletion?(.failure(error))
        }
    }
}
