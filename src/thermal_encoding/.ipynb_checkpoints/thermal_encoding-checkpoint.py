import tensorflow as tf

def thermal_bit_count_encoding(input_tensor, res=5, out_channels=8):
    """
    Encodes each input by turning on `bit_val = floor(val / 2^res)` number of bits.

    Args:
        input_tensor: Tensor of shape [..., C]
        res: Resolution used to compute bin size (e.g., res=5 -> bin size=32)
        out_channels: Total number of bits to output per channel

    Returns:
        Tensor of shape [..., C * out_channels], where each channel is encoded with `bit_val` ones.
    """
    input_tensor = tf.cast(input_tensor, tf.float32)
    bin_size = tf.cast(2 ** res, tf.float32)
    bit_val = tf.cast(tf.floor(input_tensor / bin_size), tf.int32)  # shape [..., C]
    
    # Clip to ensure within [0, out_channels]
    bit_val = tf.clip_by_value(bit_val, 0, out_channels)

    # Create thresholds: [1, 2, ..., out_channels]
    thresholds = tf.range(1, out_channels + 1, dtype=tf.int32)  # shape [out_channels]
    thresholds = tf.reshape(thresholds, [1] * (len(input_tensor.shape)) + [out_channels])

    # Expand input for broadcasting
    bit_val_exp = tf.expand_dims(bit_val, axis=-1)  # shape [..., C, 1]

    # Turn on first `bit_val` bits
    thermometer = tf.cast(thresholds <= bit_val_exp, tf.float32)  # shape [..., C, out_channels]

    # Flatten channel and bits
    input_shape = tf.shape(input_tensor)
    output_shape = tf.concat([input_shape[:-1], [input_shape[-1] * out_channels]], axis=0)
    output = tf.reshape(thermometer, output_shape)

    return output


import numpy as np

random_int = np.random.randint(0, 256)
img = tf.constant([[[random_int]]], dtype=tf.int32)

encoded = thermal_bit_count_encoding(img, res=5, out_channels=8)

bit_val = random_int // (2**5)

print(f"Random integer generated: {random_int} -> bit val -> {np.log2(2**bit_val)}")
print(f"Encoded bits: {encoded.numpy().astype(int)}")
