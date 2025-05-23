# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="A generic library for injecting 802.11 frames"
HOMEPAGE="https://github.com/kismetwireless/lorcon"

if [[ ${PV} == *9999 ]] ; then
	#main repo
	#EGIT_REPO_URI="https://www.kismetwireless.net/lorcon.git"
	#reliable mirror
	EGIT_REPO_URI="https://github.com/kismetwireless/lorcon.git"
	inherit git-r3
else
	GIT_HASH="4a81d6aaa2c6ac7253ecd182ffe97c6c89411196"
	SRC_URI="https://github.com/kismetwireless/lorcon/archive/${GIT_HASH}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/"${PN}-${GIT_HASH}"

	KEYWORDS="amd64 arm ~arm64 ppc x86 ~amd64-linux ~x86-linux"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	dev-libs/libnl:3=
	net-libs/libpcap
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	python? ( ${DISTUTILS_DEPS} )"

PATCHES=( "${FILESDIR}"/${P}-C99-decls.patch )

src_prepare() {
	default
	use python && distutils-r1_src_prepare
}

src_compile() {
	default

	if use python; then
		append-ldflags "-L${S}/.libs/"
		cd pylorcon2 || die
		distutils-r1_src_compile
	fi
}

src_test() {
	default

	# Fails within sandbox?
	#if use python; then
	#	cd pylorcon2 || die
	#	distutils-r1_src_test
	#fi
}

python_test() {
	eunittest
}

src_install() {
	default

	if use python; then
		cd pylorcon2 || die
		distutils-r1_src_install
	fi

	find "${ED}" -name '*.la' -delete || die
}
