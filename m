From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set
	endian explicitly
Date: Fri, 15 Aug 2014 05:47:15 +0400
Message-ID: <CAMo8BfLuXZ8zyEoKdo8yb6nd+pZUnx0YEL9nqHx98kt76ezfYg@mail.gmail.com>
References: <53ECE9DD.80004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=p8c4rjMSSJdO1Xt7FMqsuCj+8awOdO+1GFFG//IUgYk=;
	b=nbUSgkhiizo2fohmCn/J0WStyLeXGaWbRH8sO16lxa1TEe1eAZ9HkKUGeISo8BnCl+
	Ybr4G5EaPm7dMaQkvkCnx2VX7kqm0UgCDreGcUNfDzY3817HwDpzTd3jBAUgiV3QHAc5
	tidYn43KOw5rIToqRXqKRmhKCt02uy5mDRLOG1eOR/1EyYcR2ctUjBRYl6e5CZr9Mldn
	FVOrASo/1X4ymAvx3WdxUNXgQG32xaBHzd3yQWErDDbGFfm/mLRwtKrDs+Wxq5L6lW6k
	cjbCWK5U3+vS1KgdvXHp6k6tW+KVrvjHqxK2+X8xrhRHv4TK1G7amCunLRCq39rDbrsZ
	EOvw==
In-Reply-To: <53ECE9DD.80004@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, Linux/MIPS Mailing List <linux-mips@linux-mips.org>, linux-s390@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, linux@lists.openrisc.net, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jean Delvare <jdelvare@suse.de>, egtvedt@samfundet.no, Liqin Chen <liqin.linux@gmail.com>, jesper.nilsson@axis.com, linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org, "David S. Miller" <davem@davemloft.net>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Michael Ellerman <mpe@ellerman.id.au>, takata@linux-m32

Hi Chen,

On Thu, Aug 14, 2014 at 8:54 PM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
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

[...]

> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 3a617af..a3e8f7e 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -22,6 +22,8 @@ config XTENSA
>         select HAVE_IRQ_TIME_ACCOUNTING
>         select HAVE_PERF_EVENTS
>         select COMMON_CLK
> +       select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
> +       select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>         help
>           Xtensa processors are 32-bit RISC machines designed by Tensilica
>           primarily for embedded systems.  These processors are both

I've tested this part and it doesn't select neither CPU_BIG_ENDIAN,
nor CPU_LITTLE_ENDIAN. And looking into the Kconfig/Kbuild I cound't
find anything related to __BUILDING_TIME_BIG_ENDIAN__. Am I missing
something?

-- 
Thanks.
-- Max
