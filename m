From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Sun, 26 Aug 2018 19:52:59 -0700
Message-ID: <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cULJrPtmM1b4W2U0LvVD+GjfSzRL+JDllas16otFVyg=; b=C+rs3AuV0/EDqE
	4ZcobNqI3XIU6jqaS0fjDMes39R3jIQ3glrBH0iyOgYrlU3SPqNd9a8Ef2/zgT0DI1C6FnVX+Bcgx
	GGIDj4WV0ACmwQTEJKeykujBmi0bwQHpygTxDfjgbfFkP4jLHPreN4sF4Lb0G3sUXKvItkpZIP9x3
	ruAIebmBrJauwKpk5RsT6tvrso7FPjaxdr+7KBuqd7FVnLRajri+qDcDv+QgQregbLwh3kt7ckS7G
	VjYBEwvDMQ8cCyiHi+7xrAxmUGQ1MmJGM/ihIxlkcYLccNFYpmRFpD69sxT2jR8loxV/txbzs+D85
	fw5A8+qc4VqF7tu0v0Iw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=keXki3Y0ctxQU8En/ZDvhlqz9htVZjFX/Ff0hNgeYLw=;
 b=KsztWflzrov0wTXTHfYL/MuxSnUmEqyBMJ195NC1G8t2zzIyAlGzs99tkUwT7gUxon
 XMCuExX9KMBXS8lYjRH0IH9Lo2ErBmDhdOtMSXyIv0B1L+M5n+xB66BL2nzm0DveQ1Tb
 0x3it+H2ZX2Vww2c34pzoTh4dZ9HcWvYTxu+hAf+B6b5arA9f/WghudB46otncHZiXZ2
 a274FO2MJtd4PWoNLxtIi6rTepN99zGLxaNXuoUgXezXKcPQV3zux6+ZvmTOhzM9+lzt
 uBH1JF9HTDCdI8kJIl/7zpYrq1IepFE9P17m5lV9NWllssPhoIksx4wL7t3aOrSzMsOy
 s8JQ==
In-Reply-To: <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: nicolas.pitre@linaro.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, benh@kernel.crashing.org, Will Deacon <will.deacon@arm.com>, paulus@samba.org, mpe@ellerman.id.au, jejb@parisc-linux.org, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, gor@linux.vnet.ibm.com, mattst88@gmail.com, uclinux-h8-devel@lists.sourceforge.jp, Marc Zyngier <marc.zyngier@arm.com>, linuxram@us.ibm.com, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, luto@kernel.org, shannon.nelson@oracle.com, Thomas Gleixner <tglx@linutronix.de>, alex.bennee@linaro.org, rth@twiddle.net, jkosina@suse.cz, LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, rkuo@codeaurora.org, paul.burton@mips.com, aneesh.kumar@linux.vnet.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.co>

On Sun, Aug 26, 2018 at 1:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Honestly, I'd suggest:
>
>  - just do the current_text_addr() to _THIS_IP_ conversion
>
>  - keep _THIS_IP_ and make it be the generic one, and screw the whole
> "some architectures might implement is better" issue. Nobody cares.

And mention it to the compiler vendors as this seems like a case where
code gen can be improved.

>
>  - try to convince people to move away from the "we want the kernel
> instruction pointer for the call" model entirely, and consider this a
> "legacy" issue.
>
> The whole instruction pointer is a nasty thing. We should discourage
> it and not make complex infrastructure for it.

Yes, please.  I think we should strive for simplicity here.

>
> Instead, maybe we could encourage something like
>
>   struct kernel_loc { const char *file; const char *fn; int line; };
>
>   #define __GEN_LOC__(n) \
>         ({ static const struct kernel_loc n = { \
>                 __FILE__, __FUNCTION__, __LINE__  \
>            }; &n; })
>
>   #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))
>
> which is a hell of a lot nicer to use, and actually allows gcc to
> optimize things (try it: if you pass a _THIS_LOC_ off to an inline
> function, and that inline function uses the name and line number, gcc
> will pick them up directly, without the extra structure dereference.
>
> Wouldn't it be much nicer to pass these kinds of "location pointer"
> around, rather than the nasty _THIS_IP_ thing?
>
> Certainly lockdep looks like it could easily take that "const struct
> kernel_loc *" instead of "unsigned long ip". Makes it easy to print
> out the lockdep info.
>
> Ok, I didn't try to convert anybody, so maybe people who currently use
> _THIS_IP_ or current_text_addr() have some fundamental reason why they
> want just that, but let's not male _THIS_IP_ more complex than it
> needs to be.
>
> Hmm?
>
>              Linus

This is extremely reasonable.  I can follow up with the lockdep folks
to see if they really need _THIS_IP_ to solve their problem, or if
there's a simpler solution that can solve their needs.  Sometimes
taking a step back and asking for clarity around the big picture
allows simpler solutions to shake out.
-- 
Thanks,
~Nick Desaulniers
