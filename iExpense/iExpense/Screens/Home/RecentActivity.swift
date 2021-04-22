//
//  RecentActivity.swift
//  iExpense
//
//  Created by Tino on 20/4/21.
//

import SwiftUI

struct RecentActivity: View {
    @EnvironmentObject var expenseTracker: ExpenseTracker
    
    let radius: CGFloat = 23
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Activity")
                .foregroundColor(Color("greenGray"))
                .font(.subheadline)
            
            ZStack(alignment: .top) {
            
                roundedBackground

                if expenseTracker.expenses.isEmpty {
                    VStack {
                        Spacer()
                        Text("Add some expenses")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Spacer()
                    }
                    
                }
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        Spacer().frame(height: 10)
                        ForEach(expenseTracker.expenses) { expense in
                            ExpenseRow(expense: expense)
//                                .padding(.bottom)
                        }
                        .onDelete(perform: { _ in })
                    }
                    
                }
                
                .clipShape(RoundedRectangle(cornerRadius: radius))
            }
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
}

private extension RecentActivity {
    var roundedBackground: some View {
        Rectangle()
            .fill(Color("lightGray"))
            .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: radius))
            .ignoresSafeArea(edges: .bottom)
    }
}

struct RecentActivity_Previews: PreviewProvider {
    static var previews: some View {
        RecentActivity()
            .environmentObject(ExpenseTracker())
    }
}
