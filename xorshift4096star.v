module xorshift

struct XorShift4096Star {
mut:
	s [64]u64
	p int
}

pub fn new_xorshift4096shift(seed i64) &XorShift4096Star {
	tmpxs := XorShift4096Star{}
	tmpxs.set_seed(seed)
	return &tmpxs
}

pub fn (x mut XorShift4096Star) set_seed(seed i64) {
	tmpxs := SplitMix64{}
	tmpxs.set_seed(seed)
	for i := 0; i < 64; i++{
		x.s[i] = tmpxs.to_u64()
	}
	x.p = 0
}

pub fn (x mut XorShift4096Star) to_u64() u64{
	xpnew :=(x.p + 1) & 63
	mut s0 := x.s[x.p]
	mut s1 := x.s[xpnew]
	s1 ^= s1 << 25 // a
	s1 ^= s1 >> 3  // b
	s0 ^= s0 >> 49 // c
	tmp := s0 ^ s1
	x.s[xpnew] = tmp
	x.p = xpnew

	return tmp * u64(8372773778140471301)
}

pub fn (x &XorShift4096Star) to_i63() i64 {
	return i64(x.to_u64() & (1 << 63 - 1))
}