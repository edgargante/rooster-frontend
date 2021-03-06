//
//  SignupViewModel.swift
//  olimpiadas
//
//  Created by Edgar Gante on 05/05/22.
//

import Combine
import Foundation
import Navajo_Swift

class SignupViewModel: ObservableObject {
    // input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var code = ""
    @Published var correo: String = ""
    
    // output
    @Published var usernameMessage = ""
    @Published var passwordMessage = ""
    @Published var isValid = false
    @Published var codeMessage = ""
    @Published var mailMessage = ""

    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidMailPublisher: AnyPublisher<Bool, Never> {
        $correo
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.contains("@")
            }
            .eraseToAnyPublisher()
    }
    
    private var isCodeEmptyPublisher: AnyPublisher<Bool, Never> {
        $code
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { code in
                return code != ""
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { password, passwordAgain in
                return password == passwordAgain
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return Navajo.strength(ofPassword: input)
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
        passwordStrengthPublisher
            .map { strength in
                print(Navajo.localizedString(forStrength: strength))
                switch strength {
                case .reasonable, .strong, .veryStrong:
                    return true
                default:
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    enum PasswordCheck {
        case valid
        case empty
        case noMatch
        case notStrongEnough
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, arePasswordsEqualPublisher, isPasswordStrongEnoughPublisher)
            .map { passwordIsEmpty, passwordsAreEqual, passwordIsStrongEnough in
                if (passwordIsEmpty) {
                    return .empty
                }
                else if (!passwordsAreEqual) {
                    return .noMatch
                }
                else if (!passwordIsStrongEnough) {
                    return .notStrongEnough
                }
                else {
                    return .valid
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest4(
                isUsernameValidPublisher,
                isPasswordValidPublisher,
                isValidMailPublisher,
                isCodeEmptyPublisher
            )
            .map {
                userNameIsValid,
                passwordIsValid,
                isMailValid,
                isCodeValid in
                return userNameIsValid &&
                    (passwordIsValid == .valid) &&
                    isMailValid &&
                    isCodeValid
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isUsernameValidPublisher
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "Usuario debe tener por lo menos 3 caracteres"
            }
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch passwordCheck {
                case .empty:
                    return "Contrase??a no debe estar vac??a"
                case .noMatch:
                    return "Contrase??a no coincide"
                case .notStrongEnough:
                    return "Contrase??a no es segura"
                default:
                    return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        isValidMailPublisher
            .map { valid in
                valid ? "" : "Debes ingresar un mail v??lido"
            }
            .assign(to: \.mailMessage, on: self)
            .store(in: &cancellableSet)

        isCodeEmptyPublisher
            .map { valid in
                valid ? "" : "C??digo no puede ser vacio"
            }
            .assign(to: \.codeMessage, on: self)
            .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    
}
