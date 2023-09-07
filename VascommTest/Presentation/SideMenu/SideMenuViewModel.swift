//
//  SideMenuViewModel.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import Foundation
import Combine

final class SideMenuViewModel {
    var useCase: MenuUseCaseProtocol
    var bags = Set<AnyCancellable>()
    
    @Published var error: Error?
    @Published var isLoading = false
    @Published var token: String?
    
    init(useCase: MenuUseCaseProtocol) {
        self.useCase = useCase
        self.token = useCase.getToken()
    }
    
    func getToken() {
        token = useCase.getToken()
    }
    
    func logout() {
        useCase
            .logout()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] isLogout in
                if isLogout {
                    self?.token = nil
                }
            }
            .store(in: &bags)

    }
}
