import numpy as np
import pandas as pd
 
# Read complex64 binary data from file
f = np.fromfile(open("/home/bpil/dvbt8k.iq", "rb"), dtype=np.complex64)
 
# Extract I (real) and Q (imaginary) components, convert to float16
i_data = f.real.astype(np.float16)
q_data = f.imag.astype(np.float16)
 
# Create DataFrame with I and Q columns
df = pd.DataFrame({'I': i_data, 'Q': q_data})
 
# Save to CSV
df.to_csv("dvbt2k.csv", index=False)