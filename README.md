# Space Program Data / Telemetry Archive

## Overview
This repository contains a collection of **archived space program data**, primarily consisting of telemetry logs, processed signal data, and possibly digitized punch card records. The naming conventions (e.g., "Pione", "Sat", "WINKFIELD") suggest a connection to historical satellite tracking or deep space missions, potentially related to the **Pioneer** program or similar NASA/ESA operations.

## Repository Structure & Content

### 1. Pioneer (?) Mission Data
- **Pione-4138N**, **Pione-QK7992H**: Likely "Pioneer" mission data.
- **Pione-QK7992H-Processed-Alpha**: A larger dataset (66 files) containing processed telemetry or imagery from the above mission source.

### 2. Satellite Tracking Logs (Sat-*)
Folders named with ground station identifiers:
- **Sat-WINKFIELD...**: Winkfield (UK) was a major NASA satellite tracking station.
- **Sat-GFORKS...**: Grand Forks (USA)?
- **Sat-SNTAGO...**: Santiago (Chile) tracking station (`SNTAGO` is a common abbreviation for the STDN network).

### 3. Switch Action / Telemetry Points
- **SwitchActionTP...**: Records of switch toggles or telemetry points (TP) activated during specific mission phases.

### 4. Punchcards
- **punchcard-1**: Digitized or transcribed content from physical punch cards, indicating the vintage of this data (1960s/70s).

## Historical Context
The presence of specific tracking station names (Santiago, Winkfield) strongly aligns with the **NASA STDN (Spaceflight Tracking and Data Network)** used during the height of the Space Race. This data may be preserved raw telemetry from the Pioneer probes or similar spacecraft monitored by this network.

## How to Explore
1. **Pione-QK7992H-Processed-Alpha/**: Examine these files (likely text or binary) to see if they contain readable sensor values.
2. **SwitchActionTP...**: Correlate timestamps or event IDs with known mission timelines if possible.
