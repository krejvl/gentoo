# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Python OpenAPI 3 Specification client and validator"
HOMEPAGE="
	https://pypi.org/project/openapi3/
	https://github.com/Dorthu/openapi3
"
SRC_URI="https://github.com/Dorthu/openapi3/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# the fastapi test is broken for fastapi 0.94+
	tests/fastapi_test.py
)
