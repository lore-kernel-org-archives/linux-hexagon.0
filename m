From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Wed, 28 Mar 2018 10:58:51 -0500
Message-ID: <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
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
	List-Owner; bh=MRFiHO5bEEn4fNJUoQ5yUBEvzXzxuZ731P4+YJo6aJA=; b=EX0dOeVA5HIF+c
	9dRGi+BW2jvAcDKfkJg0S+WXN8dT54+fyx3t94QFbSJAn+1lOasMN90/6LH5+1ycF5i+GZsUSuZAN
	BifWhGdBMfUgSvUZU+e5sDPLRYLxjziKwmtOn1YeFST9NQTCXmYdsPbUjXG4xIHkVFhFEHQkSRK6+
	DPhQA6CODXnZB78MMkaI5jc8chdU+8wMm/X9Cc5dtOATGd8Z6p3Lh7s3QJ/S6cCCJgBlhKRpk9Svw
	FXHxkFz8aHwBfvnYTnCdfAaBO3tbqdKAxijtUC6g1jBlTwYzP4dbNIzkITSCA9VZvs4JB7vfyP1V8
	I7HGHPyn6rn0fJRT8q5Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qSDkcmbz+hhYmqe2ncZumACqLvxx9LwbFbBwrEiskLE=;
 b=RL0IGzUYK4VjO7BnzVR5zspETrUV5hikhNkV3/TKuuKQyc2NSeMP36w4nxksvwU4vG
 JvhH12V4osNL1UeOKGC15RdMh84F9BLhlg5KUJA91Moq9/8PdJr3OhjXk3H9HLyySi5P
 menS/9ctrNhaCPpppZtfo21xN8+L1nHITmDfqpAJAL3rVG73vsXN2Bkh049J+9jwaorz
 iQ4V2qdJtNZneAQ65nQU3FH1FQwNG+i3yAVVYJCxOzF9MULIf0FBEw6Nt8gwfsgQEOCG
 ZdagY+hnlhACFDWyppY2FityvSWLvJ6gt/2g4XEFvN/m4kmjlj0FUFMjeSbgJXhoekd0
 m+cQ==
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
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
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linu>

On 03/28/2018 10:26 AM, Shea Levy wrote:
> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
...
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>  {
>  	free_initmem_default(-1);
>  }
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3f972e83909b..19d1c5594e2d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -47,6 +47,7 @@ config ARM
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> +	select HAVE_ARCH_FREE_INITRD_MEM
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU

Isn't this why weak symbols were invented?

Confused,

Rob
