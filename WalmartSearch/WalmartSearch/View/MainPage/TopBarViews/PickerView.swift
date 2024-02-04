//
//  PickerView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/4/24.
//

import SwiftUI

struct PickerView: View {
    @ObservedObject var vm: ProductViewModel

    var body: some View {
        
        Picker("Sort By", selection: $vm.sortOption) {
            ForEach(SearchService.sortOptions, id: \.value) { option in
                Text(option.title).tag(option.value)
            }
        }
    }
}

#Preview {
    PickerView(vm: ProductViewModel())
}
