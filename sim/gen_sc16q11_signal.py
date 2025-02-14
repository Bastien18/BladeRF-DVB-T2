import numpy as np
import matplotlib.pyplot as plt

FILENAME = "./samples/sample1.sc16q11"

def save_sc16q11(filename, signal):
    """
    Write a normalized complex signal to a binary file in the bladeRF "SC16 Q11" format.
    
    Args:
        filename (str): Target filename. The file will be overwritten if it already exists.
        signal (np.ndarray): Complex signal with real and imaginary components within [-1.0, 1.0).
    
    Returns:
        int: 1 on success, 0 on failure.
    """
    try:
        with open(filename, 'wb') as f:
            sig_i = np.round(np.real(signal) * 2048.0).astype(np.int16)
            sig_i = np.clip(sig_i, -2048, 2047)

            sig_q = np.round(np.imag(signal) * 2048.0).astype(np.int16)
            sig_q = np.clip(sig_q, -2048, 2047)

            assert len(sig_i) == len(sig_q)
            
            sig_out = np.empty(2 * len(sig_i), dtype=np.int16)
            sig_out[0::2] = sig_i
            sig_out[1::2] = sig_q
            
            count = f.write(sig_out.tobytes())
            
            return 1 if count == sig_out.nbytes else 0
    except Exception as e:
        print(f"Error: {e}")
        return 0

def generate_signal(sample_rate=2e6, num_seconds=10, signal_freq_hz=250e3):
    """
    Generate a complex sinusoidal signal and plot its FFT.
    
    Args:
        sample_rate (float): The sample rate in Hz.
        num_seconds (int): Duration of the signal in seconds.
        signal_freq_hz (float): Frequency of the signal in Hz.
    
    Returns:
        np.ndarray: The generated complex signal.
    """
    num_samples = int(num_seconds * sample_rate)
    signal_freq_rad = signal_freq_hz * 2 * np.pi
    
    t = np.arange(0, num_seconds, 1/sample_rate)
    signal = 0.90 * np.exp(1j * signal_freq_rad * t)
    
    # Plot the FFT of the signal
    f = np.linspace(-0.5 * sample_rate, 0.5 * sample_rate, len(signal))
    fft_signal = np.fft.fftshift(np.fft.fft(signal)) / num_samples
    
    plt.plot(f, 20 * np.log10(np.abs(fft_signal)))
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Power (dB)')
    plt.title('250 kHz tone')
    plt.show()
    
    return signal

if __name__ == '__main__':
    signal = generate_signal()
    print(save_sc16q11(FILENAME, signal))
