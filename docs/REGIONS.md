# BC Court Regions Reference

## Region Codes

| Code | Region | Virtual Rooms |
|------|--------|---------------|
| R1 | Vancouver Island | VR8, VR9 |
| R2 | Vancouver Coastal | - |
| R3 | Fraser | - |
| R4 | Interior | VR3, VR4 |
| R5 | North | VR1, VR2 |

## Virtual Room (VR) Assignments

### VR1 (North - R5)
- Prince George
- Quesnel
- Vanderhoof
- Williams Lake

### VR2 (North - R5)
- Dawson Creek
- Fort Nelson
- Fort St. John
- Prince Rupert
- Smithers
- Terrace

### VR3 (Interior - R4)
- Kelowna

### VR4 (Interior - R4)
- Kamloops

### VR8 (Island - R1)
- Duncan
- Western Communities (Colwood)
- Victoria

### VR9 (Island - R1)
- Campbell River
- Courtenay
- Nanaimo
- Port Hardy
- Powell River
- Port Alberni

## Regional Virtual Bail Crown Contacts

| Region | Email |
|--------|-------|
| R1 (Island) | Region1.VirtualBail@gov.bc.ca |
| R2 (Van Coastal) | BCPSReVOII2@gov.bc.ca |
| R3 (Fraser) | BCPSReVOII3@gov.bc.ca |
| R4 (Interior) | Region4.VirtualBail@gov.bc.ca |
| R5 (North) | Region5.VirtualBail@gov.bc.ca |

## Court-Specific Virtual Bail Contacts (Fraser - R3)

| Court | Email |
|-------|-------|
| 222 Main Street | 222MainCrownBail@gov.bc.ca |
| Abbotsford | Abbotsford.VirtualBail@gov.bc.ca |
| Chilliwack | Chilliwack.VirtualBail@gov.bc.ca |
| New Westminster | NewWestProv.VirtualBail@gov.bc.ca |
| Port Coquitlam | PoCo.VirtualBail@gov.bc.ca |
| Surrey | Surrey.VirtualBail@gov.bc.ca |

## Sheriff Virtual Bail Coordinators

| Area | Email |
|------|-------|
| 222 Main Street | CSB222MainStreet.SheriffVirtualBail@gov.bc.ca |
| Fraser Region | CSBFraser.SheriffVirtualBail@gov.bc.ca |
| Surrey | CSBSurrey.SheriffVirtualBail@gov.bc.ca |
| Vancouver Coastal | CSBVancouverCoastal.SheriffVirtualBail@gov.bc.ca |

## Source Files Reference

When parsing contact PDFs, look for these patterns:

- `R1_*.pdf` → Vancouver Island
- `R2_*.pdf` → Vancouver Coastal
- `R3_*.pdf` or `Fraser*.pdf` → Fraser
- `R4_*.pdf` or `Interior*.pdf` → Interior
- `R5_*.pdf` or `North*.pdf` or `Region 5*.pdf` → North

Crown office emails often follow these patterns:
- `VR#` in label → Virtual Room assignment
- `*Crown*.pdf` → Crown counsel contacts
- `*Bail*.pdf` → Bail-specific contacts
- `*Sheriff*.pdf` → Sheriff/custody contacts
- `*Registry*.pdf` → Court registry contacts
- `*JCM*.pdf` → Judicial Case Manager contacts
