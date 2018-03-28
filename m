From: Shea Levy <shea@shealevy.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Wed, 28 Mar 2018 12:04:12 -0400
Message-ID: <877epwtceb.fsf@xps13.shealevy.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2477001509995621341=="
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gTJD67uXAUDCeosAawBBoPphF7aoqOzq/B6GAp4LqBM=; b=StxfomrFDGbPBG2YFP+Z11kAz
	K+ZqBC1UIkOhTxCcQnNnVrzucKI1AH94FTHFc+OUkKDkNqfQwhoMFRqfw1mK67dLNaQHpbgGC+CrP
	6P0p0N3RqcmmdQ00tbDzylfnzyM476FjxwCdijKxUk6hMUlMPrdrcto6QLtBTnBKcXSyvnu84LbIk
	u3P0aQdd036huRIrgtY4rVNmXDjBxXLBHLOT/73GERT676u5dSTbx+sy/lHwKKntbcZ5bKnVYtZkg
	hIEZtQR9bI9cdWCTBJSB3QejIS+m438KZMsotDfbZ9Vcb0IkioEu0/5JML3RSu4fc0RzXqV9WIVgC
	dm+VbZGHQ==;
In-Reply-To: <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
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
To: Rob Landley <rob@landley.net>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linu>

--===============2477001509995621341==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi Rob,

Rob Landley <rob@landley.net> writes:

> On 03/28/2018 10:26 AM, Shea Levy wrote:
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
> ...
>> --- a/arch/arc/mm/init.c
>> +++ b/arch/arc/mm/init.c
>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>  {
>>  	free_initmem_default(-1);
>>  }
>> -
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>> -{
>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> -}
>> -#endif
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 3f972e83909b..19d1c5594e2d 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -47,6 +47,7 @@ config ARM
>>  	select HARDIRQS_SW_RESEND
>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>
> Isn't this why weak symbols were invented?
>

This approach was suggested by Christoph Hellwig upthread, and seems to
have some precedent elsewhere (e.g. strncasecmp), but I agree weak
symbols seem appropriate here. I'm happy to implement either approach!

>
> Confused,
>
> Rob

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq7vPwACgkQXAvWlX2G
/if+nw/+PoGVROmqDrZBJgIrBQ4iqr8JYstaRZvlA9dxV21BXbFQka8L1+cd8ma5
7PvtjL4EfGGPxzNYBJVXzz7LjbkJp4IGDWTRhm5kuh7bFP9l3MmYd1OQhXAzd94b
ZbqvNz9A/fM1I0cg0adEqHJi9cJtiAU/wS8cloZtdRHL9QCQPqIe6tCglj/8tFK1
f0iG7gGakfrJzlxgY+Jd/RYUKaDLQoFlgjcVf7CI+Qro8U0zOTWdl9x1ifEXYMK6
XBo9bPSVAeFEE8Du+JHUpKdoachX5nWjo9qpFpfLMu9n3fFKx8rVChTvaSxd8U36
BF5rJNaZwLweNIovJMrjcYEkqIgVTKyoGqt5mbrypDk+3YTFpMmtW5WjHiSLEwDz
/RPjwiNMEjBwDIGSEDg+5ZHFe3XqnV4x3QBzzvZmHNhs4EosiAqmoKXRr8Y3T1qB
lyNp1R4KcxNr9ZfHrTQhbw3djEwOVsTLfqw7jTFwiklzTOrCiMSL0ZuwsXEIeZuK
3APYuKe7kpJ4A4M96puGy+R65sJOY3ivyo9j/RGryDjhybXGbGHqW8hBYFWFzBv0
ceBFwd71TWrTq8wWhVNgqCgLomfjovL2VfwmRsVXDTGRqcD5jRRc6fnGcR+97Dpa
86p3i5woQCxRbtzT8Kt4BfFGit8lP5SDC06EnGj/0KaULzdxZI0=
=UTNs
-----END PGP SIGNATURE-----
--=-=-=--


--===============2477001509995621341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-snps-arc mailing list
linux-snps-arc@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-snps-arc
--===============2477001509995621341==--

