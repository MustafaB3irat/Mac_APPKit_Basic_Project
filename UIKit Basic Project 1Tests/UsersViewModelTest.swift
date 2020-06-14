//
//  UIKit_Basic_Project_1Tests.swift
//  UIKit Basic Project 1Tests
//
//  Created by Asal Macbook 1 on 11/06/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import XCTest
@testable import UIKit_Basic_Project_1

class UsersViewModelTest: XCTestCase {
    
    var viewModel: UsersViewModel!
    override func setUp() {
        super.setUp()
        let request = MockRequest()
        viewModel = UsersViewModel(usersRequest: request)
        XCTAssert(viewModel != nil, "ViewModel Present")
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testUsersArray() {
        fetchUsers()
        XCTAssert(self.viewModel.filteredUsers.count == 8, "Users Is Here")
    }
    
    func testUserSearch() {
        fetchUsers()
        viewModel.filterUsers(username: "s")
        XCTAssert(self.viewModel.filteredUsers.count == 1, "Search is working well")
    }
    
    private func fetchUsers() {
        let ex =  expectation(description: "users")
        viewModel.fetchUsers {  users in
            ex.fulfill()
        }
        wait(for: [ex], timeout: 1)
    }
    
}

private class MockRequest: UsersRequest {
    
    func fetchUsers(completion: @escaping (Result<[User], UserError>) -> Void) {
        let user1 = User(id: 1, username: "Mustafa", name: "Mustafa B'irat", email: "mustafaadwi@gmail.com", website: "asdsadad", phone: "2343244324", company: Company(name: "asdsadsdad"), address: Address(geo: Geo(lat: "34", lng: "34"), city: "sss"))
        let user2 = User(id: 1, username: "Mohammed", name: "Mustafa B'irat", email: "mustafaadwi@gmail.com", website: "asdsadad", phone: "2343244324", company: Company(name: "asdsadsdad"), address: Address(geo: Geo(lat: "34", lng: "34"), city: "sss"))
        let user3 = User(id: 1, username: "Sari", name: "Mustafa B'irat", email: "mustafaadwi@gmail.com", website: "asdsadad", phone: "2343244324", company: Company(name: "asdsadsdad"), address: Address(geo: Geo(lat: "34", lng: "34"), city: "sss"))
        completion(.success(Array.init(repeating: user1, count: 5) + Array.init(repeating: user2, count: 2) + Array.init(repeating: user3, count: 1)))
    }
}
