module xorshift

struct XorShift64Star {
mut: 
	s u64
}

pub fn new_source(seed i64) &XorShift64Star {
	tmpxs := XorShift64Star{}
	tmpxs.set_seed(seed)
	return &tmpxs
}

pub fn (x mut XorShift64Star) set_seed(seed i64) {
	x.s = u64(seed)
}

pub fn (x mut XorShift64Star) to_u64() u64 {
	mut r := x.s * u64(2685821657736338717)
	x.s ^= x.s >> 12
	x.s ^= x.s << 25
	x.s ^= x.s >> 27

	return r
}

pub fn (x mut XorShift64Star) to_i63() i64 {
	return i64(x.to_u64() & (1<<63-1))
}


