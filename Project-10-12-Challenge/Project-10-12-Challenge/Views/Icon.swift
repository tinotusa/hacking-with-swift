//
//  Icon.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import SwiftUI

struct Icon: View {
    let user: User
    let width: CGFloat
    let height: CGFloat
    
    init(user: User, width: CGFloat = 50, height: CGFloat = 50) {
        self.user = user
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray4)
            Text(user.initials)
                .font(.title)
                .fontWeight(.light)
        }
        .frame(width: width, height: height)
        .clipShape(Circle())
        .overlay(Circle().stroke(user.isActive ? Color.green : Color.gray, lineWidth: 1))
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Icon(user: User.testUser)
    }
}
