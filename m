From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Wed, 28 Mar 2018 09:55:07 -0700
Message-ID: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
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
	List-Owner; bh=XD3YubMSgQLrzG7fzlCHPdlK5JeryE3s2nYAUIAqPB0=; b=j9Hh+/XM71YiiU
	KAlcZ/O4bpxFVYItBk8tqOxbMrFaUhICrVsOJCNsZPlzw8FBRCIBMniys7PXVzZw8nasRhe71m0s+
	gNSyVRnLcrj/kVLJqj7psJ0YBgdIJiJf1k/du8v0fQ+0UFurhVIFniHiVlWKyKEkSmIs67BdugtMx
	EjpDdN+hijBWrFcTORIDGk/IRQCH0o5EjNOZkq+AlGcWN/dljuQnlybyaeO84NKM/7+2VEtRigYRs
	qAcisVxRtqpFodd4BhyMMTRN3K/8JZt1N90OkZCxivV3pM/Us0a2zflaZ/t5kAYJWhN2IN1UjCwwl
	ZAIRzaNytBmm6bqmsykA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:sender:in-reply-to:references:from:date:message-id
 :subject:to:cc;
 bh=igUoMncjJWqGkLK9YYc5OMgjbea66b9N6X1DVXnuShw=;
 b=Lx1Vfi6yJqWrk1pgViO0DgQ285NcZoeX+UGmhSU2NqtiH3UixP0Udx+CBKPlh+YJeJ
 4O8wQLEaCJnilRvLNSPCIJSQMj8ruEnIM8+Zf/oRzJ1Va457UzxvTo4PW68JoLuN6P4P
 GNrTXMmb+tlcqPBXn/8VEcBpN3AI/WNZGCluyF0/Gf1PYLptxfEEhQvQ8TjLcXX5dTvE
 aIeMZUjVhtai7se5GoqzszeC23WbtG8N10RKDO1/GGSUEkQXtuxAaFLQjNIrtiByFSz1
 Mr/5RZb1qQXmSqcsKp7cXqxlgNer/ohpi99IJPEfpAMfdJOHWgGqHKd6qL8osrBnEGgt
 bYaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:sender:in-reply-to:references:from:date:message-id
 :subject:to:cc;
 bh=igUoMncjJWqGkLK9YYc5OMgjbea66b9N6X1DVXnuShw=;
 b=C9F023bTlqZq0HAbWOddgTbqqqsRqW8GD4IYemZscVuxFaWpbKOwZTHUS8yb+YyQg5
 2cjWnzvfiKuOWOWbzWbXuC8UeTPqi0fhSqUmcbILf2MbDc6Zj1hDVodmHq0TPGnSurn+
 /b30MfVfrexApbozsyyihNeUIXACBNGy9INjI=
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
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
To: Shea Levy <shea@shealevy.com>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-sh <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfou>

On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
>
> Signed-off-by: Shea Levy <shea@shealevy.com>

Yay consolidation! :)

> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>         default ".lzma" if RD_LZMA
>         default ".bz2"  if RD_BZIP2
>         default ""
> +
> +config HAVE_ARCH_FREE_INITRD_MEM
> +       bool
> +       default n

If you keep the Kconfig, you can leave off "default n", and I'd
suggest adding a help section just to describe what the per-arch
responsibilities are when select-ing the config. (See
HAVE_ARCH_SECCOMP_FILTER for an example.)

-Kees

-- 
Kees Cook
Pixel Security
