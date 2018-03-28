From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Wed, 28 Mar 2018 14:04:22 -0500
Message-ID: <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dK+c6AttfG0Jp/x/Qim+g3UIrNKp6JeQhFazboWfVyM=; b=IEqr7v2IsPDA+b
	xLvmv6JtnJq7P53ljj8yuWWJJOMZWhErXtDqVbD6vHLtsxwGZCGlfboiBCtsKFw6lYWoD+vbQiUri
	jwmt4kIwc+QuvmKOkApFSNdAddhI4QhXPdgmgGz7UMYbPjhxDNEFi8silfnFksuGRxUVLAqutX3rD
	twgm11SjPjwf4xqs6ZwpZRRoSyU155QDqQAsHRBofAqVcCoDUv1xz+chZsG5sYkPjp9M4KpkbucGQ
	6T7ik/Pr6YINr/noi5M4EIjTZJvItcUv2Vt0Co/tACP2+zWFli95i5muojVUJG2NAsBAKXQmzfhBa
	ffVXDBOnklunQXI20c2g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nsww98XQlMaNSmVYGKNwLCezcXkLKeBGQ9idADJewTA=;
 b=o5dilxzqzV6KnPrd37oA/t5ikhzAoaQEn38cC6FUKUWDlLF7J26VG3J8vvoQjpE9v4
 sX+kJ+yMU/+XJniI7IHI+XVvTI3HOpi/FGIe0gNpgHompj53bCp3NmQxXFpuEFwZvKYG
 MwhP6oyamSta84VY/0bjNlMr9e7cy//1VmLHFbNmQtjZNDcOpOZbOicsuEJ80yjPLVnf
 y77Ir1JQwh+bQMTiH9rsXpc/BejOdjFOO6dp9ByseZzxZbYzuQXb8gby3Tp6fCn8CZOW
 hhKkL4EJuKb2LilYNL9O03He8lOdibOCyd7K5otpCUgITdxfP9zVFBpUuxhAqIybYqBQ
 7pqw==
In-Reply-To: <20180328164813.GA3888@n2100.armlinux.org.uk>
Content-Language: en-US
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kerne



On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>> On 03/28/2018 10:26 AM, Shea Levy wrote:
>>> Now only those architectures that have custom initrd free requirements
>>> need to define free_initrd_mem.
>> ...
>>> --- a/arch/arc/mm/init.c
>>> +++ b/arch/arc/mm/init.c
>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>>  {
>>>  	free_initmem_default(-1);
>>>  }
>>> -
>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>> -{
>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>> -}
>>> -#endif
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 3f972e83909b..19d1c5594e2d 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -47,6 +47,7 @@ config ARM
>>>  	select HARDIRQS_SW_RESEND
>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>
>> Isn't this why weak symbols were invented?
> 
> Weak symbols means that we end up with both the weakly-referenced code
> and the arch code in the kernel image.  That's fine if the weak code
> is small.

The kernel's been able to build with link time garbage collection since 2016:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d

Wouldn't that remove the unused one?

Rob
