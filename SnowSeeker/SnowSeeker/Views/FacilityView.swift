//
//  FacilityView.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct FacilityView: View {
    let resort: Resort
    @Binding var selectedFacility: Facility?
    
    var body: some View {
        HStack {
            ForEach(resort.facilityTypes) { facility in
                facility.icon
                    .font(.title)
                    .onTapGesture {
                        selectedFacility = facility
                    }
            }
        }
    }
}

struct FacilityView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityView(resort: Resort.example, selectedFacility: .constant(Facility(facilityName: "Family")))
    }
}
