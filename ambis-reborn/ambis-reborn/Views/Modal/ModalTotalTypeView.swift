//
//  ModalTotalTypeView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 21/02/22.
//

import SwiftUI

struct ModalTotalTypeView: View {
    @Binding var isPresented: Bool
    @ObservedObject var inventoryViewModel: InventoryViewModel
    var typeAvailable = AppGlobalData.generateDataType()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                HStack {
                    Picker("", selection: $inventoryViewModel.totalType) {
                        ForEach(typeAvailable, id: \.self.name) {
                            Text($0.name)
                                .font(.system(.title3, design: .rounded))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .background(Color(.systemBackground))
                }
                .cornerRadius(15)
                
                
            }
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 15)
            .background(Color.clear)
            .cornerRadius(25)
            .offset(y: isPresented ? 0 : UIScreen.main.bounds.height)
        }.background(isPresented ? Color.black.opacity(0.7) : Color.clear).edgesIgnoringSafeArea(.all)
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            isPresented.toggle()
        }
    }
}

struct ModalTotalTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ModalTotalTypeView(isPresented: .constant(true), inventoryViewModel: InventoryViewModel())
    }
}
