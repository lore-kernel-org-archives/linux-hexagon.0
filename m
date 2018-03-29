From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Thu, 29 Mar 2018 11:39:24 -0500
Message-ID: <c91e8781-5f31-70e8-e7ef-1a80bd5d9454@landley.net>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
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
	List-Owner; bh=V8Ic6oWOZxAk9wxnNN6Z2FaA+AjAuvukHAQDydMnE4s=; b=RMTB7vQTVrzN04
	nwEAiwf8hnvRoLJLzGXyWkWy1D4tL+ekwJA1hK/mM5Ppsv5K6YoabKfm5VeDHOsxNoS1f2YwK6Z7P
	qsKPpX4JCLVNkl5HnJe85PRL+CVRNqRp3n46u69ynAF65XuWbWWCccL5URkVkX8imHxRDj5l+BFWM
	sl0XZ0TVrXOZ5Cjj86VVsnK+w2FNjRzvBaEiIfJL3pc7Us/wDPicn5Q2Yc1MpB3N9zgbsfXhhrl17
	jHf5Cxt4/v612T9mSWtaHROCLx4n5iuZlJ6m2ObMCO8KPDQhnJxdg4tPsS3YZPBnogjfF4RiTM+zp
	hzo0EyfymwiKzFvZtHgw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Mq8f+vRkP/mZyB5Eo6imYFEVjikyvk4d+b7tSEe0lXw=;
 b=USRe/m95HfaznOOYKySsVJPMHecIC+WE7kxSyCxwp0RIzHarrSKdl4SPIcv0aZqlLH
 wNEcUGNZvawbCNQwiNqpN7drX4m/ZU38UBIiH71ejgRLt4VohItefhy/w+AFOLJs26jm
 gIwuJXOczl1hOgO/8KOPhzwLBqLwNBSH993Pnt8G5V3RgpmDE2p7aT4t5BcxYB5Tfgmu
 sd7UC2ADU/k/6Hta8ySwLEeMJuZbeD4Bg/W2fhEb9QMKS6UkD2VHeFhUgUsS1DfjDeGM
 FiA/YP0y8aCLgB2fu6pbd8eyt4FdH5Xrrh0b/GQks0iItXOhrWnUp9gVuBmW8jGoIO2C
 jmjg==
In-Reply-To: <20180328221401.GA14084@n2100.armlinux.org.uk>
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



On 03/28/2018 05:14 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
>>
>>
>> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
>>> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>>>> On 03/28/2018 10:26 AM, Shea Levy wrote:
>>>>> Now only those architectures that have custom initrd free requirements
>>>>> need to define free_initrd_mem.
>>>> ...
>>>>> --- a/arch/arc/mm/init.c
>>>>> +++ b/arch/arc/mm/init.c
>>>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>>>>  {
>>>>>  	free_initmem_default(-1);
>>>>>  }
>>>>> -
>>>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>>>> -{
>>>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>>>> -}
>>>>> -#endif
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index 3f972e83909b..19d1c5594e2d 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -47,6 +47,7 @@ config ARM
>>>>>  	select HARDIRQS_SW_RESEND
>>>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>>>>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>>>
>>>> Isn't this why weak symbols were invented?
>>>
>>> Weak symbols means that we end up with both the weakly-referenced code
>>> and the arch code in the kernel image.  That's fine if the weak code
>>> is small.
>>
>> The kernel's been able to build with link time garbage collection since 2016:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
>>
>> Wouldn't that remove the unused one?
> 
> Probably, if anyone bothered to use that, which they don't.
> 
> LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> what I can see, nothing selects it.  Therefore, the symbol is always
> disabled, and so the feature never gets used in mainline kernels.

It looks like there are per-architecture linker scripts that need to be updated?
So if an architecture supports it, it's always done (well, it probes for the
toolchain supporting the flag). And if the architecture doesn't support it, the
linker script needs to be updated to mark sections with "I know nothing seems to
reference this at the ELF level but keep it anyway, we're pulling an assembly
trick".

> Brings up the obvious question - why is it there if it's completely
> unused?  (Maybe to cause confusion, and allowing a justification
> for __weak ?)

Presumably it will become the default on architectures as their linker scripts
are converted. Once they're all converted the config symbol can go away. (Given
the move to requiring gcc 4.7 or whatever it is, there can't be an architecture
depending on a toolchain that _doesn't_ support it after that point. I doubt you
can pair gcc 4.7 with a >12 year old binutils and expect good things...)

Rob
