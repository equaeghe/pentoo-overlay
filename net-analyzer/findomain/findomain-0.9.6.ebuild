# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler32-1.0.4
ansi_term-0.11.0
async-trait-0.1.22
atty-0.2.13
autocfg-0.1.6
backtrace-0.3.37
backtrace-sys-0.1.31
base64-0.10.1
base64-0.11.0
bitflags-1.1.0
block-buffer-0.7.3
block-padding-0.1.5
bumpalo-2.6.0
byte-tools-0.3.1
byteorder-1.3.2
bytes-0.4.12
bytes-0.5.3
c2-chacha-0.2.2
cc-1.0.45
cfg-if-0.1.9
clap-2.33.0
cloudabi-0.0.3
cookie-0.12.0
cookie_store-0.7.0
core-foundation-0.6.4
core-foundation-sys-0.6.2
crc32fast-1.2.0
crossbeam-deque-0.7.2
crossbeam-epoch-0.8.0
crossbeam-queue-0.1.2
crossbeam-queue-0.2.0
crossbeam-utils-0.6.6
crossbeam-utils-0.7.0
crypto-mac-0.7.0
digest-0.8.1
dtoa-0.4.4
either-1.5.3
encoding_rs-0.8.20
enum-as-inner-0.3.0
error-chain-0.12.1
failure-0.1.6
failure_derive-0.1.6
fake-simd-0.1.2
fallible-iterator-0.2.0
findomain-0.9.6
flate2-1.0.13
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.29
futures-0.3.1
futures-channel-0.3.1
futures-core-0.3.1
futures-cpupool-0.1.8
futures-executor-0.3.1
futures-io-0.3.1
futures-macro-0.3.1
futures-sink-0.3.1
futures-task-0.3.1
futures-util-0.3.1
generic-array-0.12.3
generic-array-0.13.2
getrandom-0.1.12
h2-0.1.26
heck-0.3.1
hmac-0.7.1
hostname-0.1.5
http-0.1.21
http-body-0.1.0
httparse-1.3.4
hyper-0.12.35
hyper-tls-0.3.2
idna-0.1.5
idna-0.2.0
indexmap-1.2.0
iovec-0.1.4
ipconfig-0.2.1
itoa-0.4.4
js-sys-0.3.30
kernel32-sys-0.2.2
lazy_static-1.4.0
libc-0.2.66
linked-hash-map-0.5.2
lock_api-0.3.3
log-0.4.8
lru-cache-0.1.2
matches-0.1.8
md5-0.7.0
memchr-2.2.1
memoffset-0.5.1
mime-0.3.14
mime_guess-2.0.1
miniz_oxide-0.3.5
mio-0.6.21
mio-uds-0.6.7
miow-0.2.1
native-tls-0.2.3
net2-0.2.33
nom-4.2.3
num_cpus-1.10.1
opaque-debug-0.2.3
openssl-0.10.26
openssl-probe-0.1.2
openssl-src-111.6.0+1.1.1d
openssl-sys-0.9.53
parking_lot-0.10.0
parking_lot-0.9.0
parking_lot_core-0.6.2
parking_lot_core-0.7.0
percent-encoding-1.0.1
percent-encoding-2.1.0
phf-0.8.0
phf_shared-0.8.0
pin-project-lite-0.1.2
pin-utils-0.1.0-alpha.4
pkg-config-0.3.16
postgres-0.17.0
postgres-protocol-0.5.0
postgres-types-0.1.0
ppv-lite86-0.2.5
proc-macro-hack-0.5.11
proc-macro-nested-0.1.3
proc-macro2-1.0.4
publicsuffix-1.5.4
quick-error-1.2.2
quote-1.0.2
rand-0.6.5
rand-0.7.3
rand_chacha-0.1.1
rand_chacha-0.2.1
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rayon-1.3.0
rayon-core-1.7.0
rdrand-0.4.0
redox_syscall-0.1.56
regex-1.3.3
regex-syntax-0.6.13
remove_dir_all-0.5.2
reqwest-0.9.24
resolv-conf-0.6.2
ring-0.16.9
rustc-demangle-0.1.16
rustc_version-0.2.3
rustls-0.16.0
ryu-1.0.0
schannel-0.1.16
scopeguard-1.0.0
sct-0.6.0
security-framework-0.3.1
security-framework-sys-0.3.1
semver-0.9.0
semver-parser-0.7.0
serde-1.0.104
serde_derive-1.0.104
serde_json-1.0.40
serde_urlencoded-0.5.5
sha2-0.8.1
siphasher-0.3.1
slab-0.4.2
smallvec-0.6.10
smallvec-1.1.0
socket2-0.3.11
sourcefile-0.1.4
spin-0.5.2
string-0.2.1
stringprep-0.1.2
strsim-0.8.0
subtle-1.0.0
syn-1.0.5
synstructure-0.12.1
tempfile-3.1.0
textwrap-0.11.0
time-0.1.42
tokio-0.1.22
tokio-0.2.9
tokio-buf-0.1.1
tokio-current-thread-0.1.6
tokio-executor-0.1.9
tokio-io-0.1.12
tokio-postgres-0.5.1
tokio-reactor-0.1.11
tokio-rustls-0.12.2
tokio-sync-0.1.7
tokio-tcp-0.1.3
tokio-threadpool-0.1.17
tokio-timer-0.2.12
tokio-util-0.2.0
trust-dns-proto-0.18.1
trust-dns-resolver-0.18.1
trust-dns-rustls-0.18.1
try-lock-0.2.2
try_from-0.3.2
typenum-1.11.2
unicase-2.5.1
unicode-bidi-0.3.4
unicode-normalization-0.1.8
unicode-segmentation-1.5.0
unicode-width-0.1.6
unicode-xid-0.2.0
untrusted-0.7.0
url-1.7.2
url-2.1.0
uuid-0.7.4
vcpkg-0.2.7
vec_map-0.8.1
version_check-0.1.5
want-0.2.0
wasi-0.7.0
wasm-bindgen-0.2.53
wasm-bindgen-backend-0.2.53
wasm-bindgen-macro-0.2.53
wasm-bindgen-macro-support-0.2.53
wasm-bindgen-shared-0.2.53
wasm-bindgen-webidl-0.2.53
web-sys-0.3.30
webpki-0.21.0
webpki-roots-0.18.0
weedle-0.10.0
widestring-0.4.0
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
winutil-0.1.1
ws2_32-sys-0.2.1
yaml-rust-0.3.5
"

inherit cargo

DESCRIPTION="The fastest and cross-platform subdomain enumerator, don't waste your time"
HOMEPAGE="https://github.com/Edu4rdSHL/findomain"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Edu4rdSHL/findomain"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/Edu4rdSHL/findomain/archive/${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris ${CRATES})"
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

BDEPEND=">=virtual/rust-1.40.0"

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	if [[ ${PV} != *9999 ]]; then
		sed -e "s/^version: \"\(.*\)\"/version: \"${PV}\"/" \
			-i src/cli.yml || die
	fi

	default
}

src_install() {
	dobin target/release/findomain

	doman findomain.1
	dodoc -r docs/* README.md
}
