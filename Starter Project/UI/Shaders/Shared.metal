//
//  Shared.metal
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/11/23.
//

#include "Shared.h"

// MARK: Functionality
// Please note that theta is in degrees and ranges from 0 -> 360
float4 colorWheel(float theta) {
    float normalizedTheta;
    if (theta < 120) {
        normalizedTheta = theta;
        return float4((120-normalizedTheta)/120, normalizedTheta/120, 0.0, 1.0);
    } else if (theta < 240) {
        normalizedTheta = theta - 120;
        return float4(0.0,(120-normalizedTheta)/120, normalizedTheta/120 ,1.0);
    } else {
        normalizedTheta = theta - 240;
        return float4(normalizedTheta/120, 0.0, (120-normalizedTheta)/120, 1.0);
    }
}

// Please note that theta is in degrees and ranges from 0 -> 360
float4 inverseColorWheel(float theta) {
    float normalizedTheta;
    if (theta < 120) {
        normalizedTheta = theta;
        return float4(normalizedTheta/120, 0.0, (120-normalizedTheta)/120, 1.0);
    } else if (theta < 240) {
        normalizedTheta = theta - 120;
        return float4((120-normalizedTheta)/120, normalizedTheta/120, 0.0, 1.0);
        
    } else {
        normalizedTheta = theta - 240;
        return float4(0.0,(120-normalizedTheta)/120, normalizedTheta/120 ,1.0);
    }
}

// Please note that theta is in degrees and ranges from 0 -> 360
float4 lineThicknessColorWheel(float theta) {
    float normalizedTheta;
    if (theta < 120) {
        normalizedTheta = theta;
        return float4((120-normalizedTheta)/120, normalizedTheta/120, 0.0, 1.0);
    } else if (theta < 240) {
        normalizedTheta = theta - 120;
        return float4(0.0,(120-normalizedTheta)/120, normalizedTheta/120 ,1.0);
    } else {
        normalizedTheta = theta - 240;
        return float4(normalizedTheta/120, 0.0, (120-normalizedTheta)/120, 1.0);
    }
}
