From: Shea Levy <shea@shealevy.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Sun, 01 Apr 2018 11:05:21 -0400
Message-ID: <87bmf3rmq6.fsf@xps13.shealevy.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <20180330111517.rrx6gs2skkgk336j@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7840985626795173511=="
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0p0ZcKGiSCDZ6aOQwaiphEfea9iIKBST09PeZhdKwO4=; b=Vcpcygs3yPsktdd5r4AI0z3uZ
	wt21mczS9wxXPbqkSyPFwOdPK8IFdP9+EuBF2hNvoMrG4fHRqO6WAH1xspIQ4L9BwFqQwXg2AeMDf
	pQ7X+xV/4jhMBcIbNCW1cd9jYhkbBHBE3zSmz4oo+3r5gN3Llxif/xfrwyeV3Ejxz6GWsjPxiw0OW
	Dd9e9gi7801VmnbCijROG2onDjNzsKNL8PD10RME2GRnTkLWiOuEm6/4VUzhKpKcLcnvXkj905BYl
	ZCZR9Cw3681wCViILVbG2/1e0QFdsuM1Zxt3q6XDxUAy4AdBIxiiTdhIYvv7A/+AO5/aZfTxDgcxP
	ktW9dlRbg==;
In-Reply-To: <20180330111517.rrx6gs2skkgk336j@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kerne

--===============7840985626795173511==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

Ingo Molnar <mingo@kernel.org> writes:

> * Shea Levy <shea@shealevy.com> wrote:
>
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
>>=20
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
> Please put the Kconfig symbol name this patch introduces both into the ti=
tle, so=20
> that people know what to grep for.
>
>> ---
>>  arch/alpha/mm/init.c      |  8 --------
>>  arch/arc/mm/init.c        |  7 -------
>>  arch/arm/Kconfig          |  1 +
>>  arch/arm64/Kconfig        |  1 +
>>  arch/blackfin/Kconfig     |  1 +
>>  arch/c6x/mm/init.c        |  7 -------
>>  arch/cris/Kconfig         |  1 +
>>  arch/frv/mm/init.c        | 11 -----------
>>  arch/h8300/mm/init.c      |  7 -------
>>  arch/hexagon/Kconfig      |  1 +
>>  arch/ia64/Kconfig         |  1 +
>>  arch/m32r/Kconfig         |  1 +
>>  arch/m32r/mm/init.c       | 11 -----------
>>  arch/m68k/mm/init.c       |  7 -------
>>  arch/metag/Kconfig        |  1 +
>>  arch/microblaze/mm/init.c |  7 -------
>>  arch/mips/Kconfig         |  1 +
>>  arch/mn10300/Kconfig      |  1 +
>>  arch/nios2/mm/init.c      |  7 -------
>>  arch/openrisc/mm/init.c   |  7 -------
>>  arch/parisc/mm/init.c     |  7 -------
>>  arch/powerpc/mm/mem.c     |  7 -------
>>  arch/riscv/mm/init.c      |  6 ------
>>  arch/s390/Kconfig         |  1 +
>>  arch/score/Kconfig        |  1 +
>>  arch/sh/mm/init.c         |  7 -------
>>  arch/sparc/Kconfig        |  1 +
>>  arch/tile/Kconfig         |  1 +
>>  arch/um/kernel/mem.c      |  7 -------
>>  arch/unicore32/Kconfig    |  1 +
>>  arch/x86/Kconfig          |  1 +
>>  arch/xtensa/Kconfig       |  1 +
>>  init/initramfs.c          |  7 +++++++
>>  usr/Kconfig               |  4 ++++
>>  34 files changed, 28 insertions(+), 113 deletions(-)
>
> Please also put it into Documentation/features/.
>

I switched this patch series (the latest revision v6 was just posted) to
using weak symbols instead of Kconfig. Does it still warrant documentation?

>
>> diff --git a/usr/Kconfig b/usr/Kconfig
>> index 43658b8a975e..7a94f6df39bf 100644
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>  	default ".lzma" if RD_LZMA
>>  	default ".bz2"  if RD_BZIP2
>>  	default ""
>> +
>> +config HAVE_ARCH_FREE_INITRD_MEM
>> +	bool
>> +	default n
>
> Help text would be nice, to tell arch maintainers what the purpose of thi=
s switch=20
> is.
>
> Also, a nit, I think this should be named "ARCH_HAS_FREE_INITRD_MEM", whi=
ch is the=20
> dominant pattern:
>
> triton:~/tip> git grep 'select.*ARCH' arch/x86/Kconfig* | cut -f2 | cut -=
d_ -f1-2 | sort | uniq -c | sort -n
>     ...
>       2 select ARCH_USES
>       2 select ARCH_WANTS
>       3 select ARCH_MIGHT
>       3 select ARCH_WANT
>       4 select ARCH_SUPPORTS
>       4 select ARCH_USE
>      16 select HAVE_ARCH
>      23 select ARCH_HAS
>
> It also reads nicely in English:
>
>   "arch has free_initrd_mem()"
>
> While the other makes little sense:
>
>   "have arch free_initrd_mem()"
>
> ?
>
> Thanks,
>
> 	Ingo

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlrA9TEACgkQXAvWlX2G
/ieu+w/9EljMoicXq5AAY0iiZCVMRqXrkcnMT+1jcMEtLA8mLL1ibZrYLGALlTF+
+M0+7Nn2Gs9Nfna/5Mj+IW+WiQ93nFKqKWL22tBheoM6at3oZsOtX0oBI4mB9eIT
kzwUcCpCQDXvyuVbsV6XqJkCAlpYBAFE2wquWM6DVovxW91kN8cQpP3qZGtTKMkr
DMAe4LUUbM40/dDsHu43aoFb08mCct1TLf4W/CGMxSapt+8SYow7I6w1QuTJ9NYk
zTDJuV6J2xP5x4h7zPnzKA/wBkYhMrzgiMC0o3EeKWFUSa+3yCWM+dvHFzqqaz5/
jW0FUCI3mVaJgkDcdDp41mqI69WqYfpqp9LXdEjuQXRl/m9/icJL41/91XUHEfOk
k3N6HdGi7eEQ93Qo3Yv4ohr9YlK1Ah7vPK3Zq5c69k4T+sVnk5C1k/wtUkceEfGy
mgXXL9FxfFi7LpMxEpLsr8NpgkV38H1L4wanzwJGgJAeqn+bqUbhactKwl9AO7mR
u2xDrICYqEDR6bPuPHQQaF0UrsAR0uyfUGUEnuFLlTdrfgY3cpod5D+UKYCohDCC
iWuHhKxUY0SQrq99eS9oQD5JSyhqGWF61/nDzMLJ/ApFFBURUiIiW2V4NoRNMB/N
+lyDeFwyn4ApvGm5GvQlfnkaWew/0jVqx9iihclpvw3yNRSbm1M=
=FCRP
-----END PGP SIGNATURE-----
--=-=-=--


--===============7840985626795173511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-snps-arc mailing list
linux-snps-arc@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-snps-arc
--===============7840985626795173511==--

