module xorshift

struct SplitMix64 {
mut:
	s u64
}

fn new_splitmix64(seed i64) &SplitMix64 {
	mut tmpxs := SplitMix64{}
	tmpxs.set_seed(seed)
	return &tmpxs
}

pub fn (x SplitMix64) to_i63() i64 {
	return i64(x.to_u64() & (1 << 63 - 1))
}

pub fn (x SplitMix64) to_u64() u64 {
	x.s = x.s + u64(0x9E3779B97F4A7C15)
	mut z := x.s
	z = (z ^ (z >> 30)) * u64(0xBF58476D1CE4E5B9)
	z = (z ^ (z >> 27)) * u64(0x94D049BB133111EB)
	return z ^ (z >> 31)
}

pub fn (x mut SplitMix64) set_seed(seed i64) {
	x.s = u64(seed)
}