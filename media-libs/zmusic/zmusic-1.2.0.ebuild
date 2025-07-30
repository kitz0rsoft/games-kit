# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="GZDoom's music system as a standalone library"
HOMEPAGE="https://github.com/ZDoom/ZMusic"
SRC_URI="https://github.com/ZDoom/ZMusic/tarball/ac3e232b001129c740b7b65196ae0e1b13b82513 -> ZMusic-1.2.0-ac3e232.tar.gz"

LICENSE="BSD DUMB-0.9.3 GPL-3 LGPL-2.1+ LGPL-3 MIT"
SLOT="0"
KEYWORDS="*"
IUSE="alsa +fluidsynth mpg123 +sndfile"

DEPEND="
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	fluidsynth? ( media-sound/fluidsynth:= )
	mpg123? ( media-sound/mpg123 )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ZDoom-ZMusic-ac3e232"


src_prepare() {
	rm -rf licenses || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DFORCE_INTERNAL_ZLIB=OFF
		-DFORCE_INTERNAL_GME=ON
		-DDYN_FLUIDSYNTH=OFF
		-DDYN_SNDFILE=OFF
		-DDYN_MPG123=OFF
		-DCMAKE_DISABLE_FIND_PACKAGE_ALSA="$(usex !alsa)"
		-DCMAKE_DISABLE_FIND_PACKAGE_FluidSynth="$(usex !fluidsynth)"
		-DCMAKE_DISABLE_FIND_PACKAGE_MPG123="$(usex !mpg123)"
		-DCMAKE_DISABLE_FIND_PACKAGE_SndFile="$(usex !sndfile)"
		-DBUILD_SHARED_LIBS=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}