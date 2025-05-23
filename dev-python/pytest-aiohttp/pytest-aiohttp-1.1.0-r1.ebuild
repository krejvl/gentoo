# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="pytest plugin for aiohttp support"
HOMEPAGE="
	https://github.com/aio-libs/pytest-aiohttp/
	https://pypi.org/project/pytest-aiohttp/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~loong ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~x64-macos"

RDEPEND="
	>=dev-python/aiohttp-3.11.0_beta1[${PYTHON_USEDEP}]
	>=dev-python/pytest-6.1.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-asyncio-0.17.2[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# warning doesn't seem to be emitted for some reason
	# doesn't look very important
	tests/test_obsolete_fixtures.py::test_loop_fixture
)
