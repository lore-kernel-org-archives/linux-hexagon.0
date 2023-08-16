From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Thu, 17 Aug 2023 00:58:18 +0200
Message-ID: <CAHmME9pxC_e6Ftj1MJ4H2skhhKfNubd=7OwcH9xepCxjkDxpkg@mail.gmail.com>
References: <20230816055010.31534-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <wireguard-bounces@lists.zx2c4.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1692226871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJ+exFyMwxf+Sp/aWFmN/k274aR2STKWbu8odcAPWm8=;
 b=jXokpT8HHm9bHv6hIJ3T3CMHWSwvmBYeqbPj7fjD4Ezxvigmdm/fXPxtKXDXtXiveMyEy2
 K2zo2MO6Jx19/zc76sU6x7FN12g49ex3CRn9eKlZgLZMkYTlRh8PLwi9EYMp443CajZ7FT
 H+k/S7W81nftL8bDVz+/B0+KLWJPGLw=
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.zx2c4.com/mailman/options/wireguard>,
 <mailto:wireguard-request@lists.zx2c4.com?subject=unsubscribe>
List-Archive: <http://lists.zx2c4.com/pipermail/wireguard/>
List-Post: <mailto:wireguard@lists.zx2c4.com>
List-Help: <mailto:wireguard-request@lists.zx2c4.com?subject=help>
List-Subscribe: <https://lists.zx2c4.com/mailman/listinfo/wireguard>,
 <mailto:wireguard-request@lists.zx2c4.com?subject=subscribe>
Errors-To: wireguard-bounces@lists.zx2c4.com
Sender: "WireGuard" <wireguard-bounces@lists.zx2c4.com>
Content-Type: text/plain; charset="windows-1252"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-

On Wed, Aug 16, 2023 at 7:50=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: wireguard@lists.zx2c4.com
> Cc: linux-arch@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> diff -- a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/te=
sting/selftests/wireguard/qemu/kernel.config
> --- a/tools/testing/selftests/wireguard/qemu/kernel.config
> +++ b/tools/testing/selftests/wireguard/qemu/kernel.config
> @@ -41,7 +41,6 @@ CONFIG_KALLSYMS=3Dy
>  CONFIG_BUG=3Dy
>  CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
>  CONFIG_JUMP_LABEL=3Dy
> -CONFIG_EMBEDDED=3Dn
>  CONFIG_BASE_FULL=3Dy
>  CONFIG_FUTEX=3Dy
>  CONFIG_SHMEM=3Dy

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
