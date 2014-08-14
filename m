From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Date: Thu, 14 Aug 2014 18:21:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
References: <53ECE9DD.80004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: <linux-hexagon.vger.kernel.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Chen Gang <gang.chen.5i5j@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>, "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>, "mattst88@gmail.com" <mattst88@gmail.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "msalter@redhat.com" <msalter@redhat.com>, "a-jacquiot@ti.com" <a-jacquiot@ti.com>
Cc: "linux390@de.ibm.com" <linux390@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>, "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>, linux-m68k@lists.linux-m68k.org

On Thursday 14 August 2014 09:55 AM, Chen Gang wrote:
> Normal architectures:
>
>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>
>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>                   score, unicore32, x86
>
>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
>
> Special architectures:
>
>  - Deside by compiler: microblaze, tile, xtensa.
>
>  - Deside by building host: um
>
>  - Next, need improve Kbuild to probe endian to deside whether need mark
>    __BUILDING_TIME_BIG_ENDIAN__ before real config.
>
> Another improvements:
>
>  - score: use '\t' instead of ' '.
>
>  - s390: sort the select value in alpha order.
>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/alpha/Kconfig      |  1 +
>  arch/arc/Kconfig        |  1 +
>  arch/arm/Kconfig        |  1 +
>  arch/arm64/Kconfig      |  1 +
>  arch/avr32/Kconfig      |  1 +
>  arch/blackfin/Kconfig   |  1 +
>  arch/c6x/Kconfig        |  1 +
>  arch/cris/Kconfig       |  1 +
>  arch/frv/Kconfig        |  1 +
>  arch/hexagon/Kconfig    |  1 +
>  arch/ia64/Kconfig       |  1 +
>  arch/m32r/Kconfig       |  1 +
>  arch/m68k/Kconfig       |  1 +
>  arch/metag/Kconfig      |  1 +
>  arch/microblaze/Kconfig |  2 ++
>  arch/mips/Kconfig       |  1 +
>  arch/mn10300/Kconfig    |  1 +
>  arch/openrisc/Kconfig   |  1 +
>  arch/parisc/Kconfig     |  1 +
>  arch/powerpc/Kconfig    |  1 +
>  arch/s390/Kconfig       |  3 ++-
>  arch/score/Kconfig      | 21 +++++++++++----------
>  arch/sparc/Kconfig      |  1 +
>  arch/tile/Kconfig       |  2 ++
>  arch/um/Kconfig.common  |  2 ++
>  arch/unicore32/Kconfig  |  1 +
>  arch/x86/Kconfig        |  1 +
>  arch/xtensa/Kconfig     |  2 ++
>  init/Kconfig            |  6 ++++++
>  29 files changed, 49 insertions(+), 11 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index b7ff9a3..1cb7426 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -27,6 +27,7 @@ config ALPHA
>  	select MODULES_USE_ELF_RELA
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
> +	select CPU_LITTLE_ENDIAN
>  	help
>  	  The Alpha is a 64-bit general-purpose processor designed and
>  	  marketed by the Digital Equipment Corporation of blessed memory,
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 9596b0a..e939abd 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -35,6 +35,7 @@ config ARC
>  	select OF_EARLY_FLATTREE
>  	select PERF_USE_VMALLOC
>  	select HAVE_DEBUG_STACKOVERFLOW
> +	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN

It is not clear what exactly are you trying to fix. What doesn't work w/o this
patch !

-Vineet

