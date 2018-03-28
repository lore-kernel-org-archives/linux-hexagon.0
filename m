From: Oliver <oohall@gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Thu, 29 Mar 2018 09:37:52 +1100
Message-ID: <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
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
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0UGUQ0CUnlLnPur6Q6eQ3fURiqpsQF1dMvqDSxNV91U=; b=glzTJbXg9bz8fZ
	ugaAnaoLPl2yF+N7yZjqG6YQ9ik06kh7SmTs9iMfn6Z5fhkmPbaQ6/wEArW3h1CD92sbqQeBplYp3
	AbDS0eSGp22C0auPjzWLYAwsyuzhSMAX+hFhU122y4WgTCBhAXF8mlr6RHiDfpA3JKW4wIhEiEsID
	piLcyXlTbCbk24JxU/pOaPhi/yixJi+2r5f5OkSX/gKucKtWtAXWh+WDr55g0Ys4fiROZ49PKa8mw
	zc7rl96N/HDGiVeJuj9QssZ0d0sGykSBoCmNTFaufrO8BIoghp5q/fEnZTcYkUUXQZ0A/Qo2pn3Jm
	XOV9AWJtuTyNpTd36p6A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=nnpD6Ps7J34/xAmwZTUnUReer7G77oJS7ENxTSotV08=;
 b=aigf+O1PgjS3dxJyOf8t7Lm0ZgPdYHQlMdePggMWsJ/jdg9MZzRGlgJarLSCYVxP+K
 n7dnrIYm1joyITDwwSPkDum2kYTAn7hLzD9Gu5sjQu3qkYMDpMXmFfkoprRm7lXS63jI
 8YWWjLpf50VAfZZwScEPcEVdRbf8fdPgm6q7RJdbJ7QFGIZac6prr0c7PNkjceTwRzkZ
 Bkr9qgrwbKhd6OPkr+GF6wkX+GJz8hiNvVieAXSGgTU2ptbRNzuxEx6EpTZgC3eei0lc
 JIfTSlfRZ+TotFQFZAsb8HNwA/5ytWXgUI6TjXhob8XGv74TH8pltFflwOAq635rGdu0
 USoA==
In-Reply-To: <20180328221401.GA14084@n2100.armlinux.org.uk>
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
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfou>

On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
>>
>>
>> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
>> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>> >> On 03/28/2018 10:26 AM, Shea Levy wrote:
>> >>> Now only those architectures that have custom initrd free requirements
>> >>> need to define free_initrd_mem.
>> >> ...
>> >>> --- a/arch/arc/mm/init.c
>> >>> +++ b/arch/arc/mm/init.c
>> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>> >>>  {
>> >>>   free_initmem_default(-1);
>> >>>  }
>> >>> -
>> >>> -#ifdef CONFIG_BLK_DEV_INITRD
>> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>> >>> -{
>> >>> - free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> >>> -}
>> >>> -#endif
>> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> >>> index 3f972e83909b..19d1c5594e2d 100644
>> >>> --- a/arch/arm/Kconfig
>> >>> +++ b/arch/arm/Kconfig
>> >>> @@ -47,6 +47,7 @@ config ARM
>> >>>   select HARDIRQS_SW_RESEND
>> >>>   select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>> >>>   select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>> >>> + select HAVE_ARCH_FREE_INITRD_MEM
>> >>>   select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>> >>>   select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>> >>>   select HAVE_ARCH_MMAP_RND_BITS if MMU
>> >>
>> >> Isn't this why weak symbols were invented?
>> >
>> > Weak symbols means that we end up with both the weakly-referenced code
>> > and the arch code in the kernel image.  That's fine if the weak code
>> > is small.
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
>
> Brings up the obvious question - why is it there if it's completely
> unused?  (Maybe to cause confusion, and allowing a justification
> for __weak ?)

IIRC Nick had some patches to do the arch enablement for powerpc, but
I'm not sure what happened to them though. I suspect it just fell down
Nick's ever growing TODO list.
