# Code Book: Human Activity Recognition Using Smartphones Dataset

## Overview
The source dataset represents sensor measurements collected from Samsung Galaxy S II smartphones worn on the waist by 30 subjects performing six daily living activities.

## Identifiers
* `subject`: ID integer identifying the individual test participant (1 to 30).
* `activity`: Name of the physical activity performed:
  1. `WALKING`
  2. `WALKING_UPSTAIRS`
  3. `WALKING_DOWNSTAIRS`
  4. `SITTING`
  5. `STANDING`
  6. `LAYING`

## Key Measurements & Variable Transformations
All measurements are normalized and bounded within `[-1, 1]`. The output variables in `tidy_data.txt` represent the arithmetic mean of each raw feature, grouped per subject and activity.

* **Prefix `TimeDomain_`**: Raw accelerometer/gyroscope signals captured over time at 50 Hz.
* **Prefix `FrequencyDomain_`**: Fast Fourier Transform (FFT) applied to time-domain signals.
* **`Accelerometer` / `Gyroscope`**: Data derived from the triaxial accelerometer or gyroscope sensors.
* **`Magnitude`**: Calculated magnitude of 3D signals using Euclidean norm.
* **`_Mean` / `_StdDev`**: Signals representing the mean or standard deviation of estimated feature signals.