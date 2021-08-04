//
//  CookingStepView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 8/4/21.
//

import Foundation
import SwiftUI

struct CookingStepView: View {
    let cookingStepSample: [String]
    
    var body: some View {
        VStack {
            ImagePlaceholder()
            ScrollView {
                ForEach(0..<cookingStepSample.count) { count in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke()
                            .foregroundColor(Color("BrandColor"))
                        HStack {
                            VStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 25)
                            }
                            VStack(alignment: .leading) {
                                Text("Step \(count + 1)")
                                    .font(.system(size: 19))
                                    .fontWeight(.semibold)
                                Text(cookingStepSample[count])
                                    .font(.system(size: 16))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Cooking Steps")
        .padding(.horizontal)
    }
}
