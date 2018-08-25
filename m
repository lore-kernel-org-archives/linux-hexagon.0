From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Sat, 25 Aug 2018 14:02:43 -0700
Message-ID: <CA+55aFxL-u3uvGGv0GOoHhEwV8fy=BCN1yScxKQiVMPoHtg=Wg@mail.gmail.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
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
	List-Owner; bh=6s6zV8Z8lCU8t2VFHj735e8yQQC2BZ7JBnMW0q8Z6VY=; b=pzZ3OiyJ9lQ739
	9vQnCl0JbIW/gqxvxhWQQGoxfrJ0t1Zy07rkrAxV8LLd7dq+4K2T+ucfIgCpXKuaHldC0pI6aYLH9
	Iymm4oHvneXGvnQ7R8rITuGDEIHqy7tGuqwFE0rYCybrUgJcz6KWuPYu8xG6eMu3PiFZ/79rG2ka+
	XDqbOqhIE5ne2kDiuvBB4mA67ms920JSe0baAs9MdRXCkfS593112YXqyIfZTGq2oYP9wDKmm4khT
	EX1A4RBs6DQbCBpqBsRtLdAdjOwzvnu/O+KRkYEGMHXSTPZ3FZPn63VLO3VIRycZHYcNPhzVJoehx
	u5JoE46EhZRqfAvubpBA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZJE4B6eA+W3iZhwqnRGz2FAQ/QDMOA2EZwNKQJzar6g=;
 b=evDel4DiMe2DRvSNssNFeZiN0LSsFD0TCJaQq0lyprQ3Ac3ljg3/uzk/PrSWhb6wSm
 jgCPEBxdp9nSAehEGexGM9u+FAB8Yf+/kEWcm9n8816uHzIIcqz8E8fDtlSeB4JmxMng
 9O7FKBtuY87vfVQCmDcI0Up0jlgIM8A3SwDDs=
In-Reply-To: <20180821202900.208417-1-ndesaulniers@google.com>
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
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, gor@linux.vnet.ibm.com, Matt Turner <mattst88@gmail.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Marc Zyngier <marc.zyngier@arm.com>, Ram Pai <linuxram@us.ibm.com>, linux-um@lists.infradead.org, Nick Piggin <npiggin@gmail.com>, Andrew Lutomirski <luto@kernel.org>, shannon.nelson@oracle.com, Thomas Gleixner <tglx@linutronix.de>, alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>, Jiri Kosina <jkosina@suse.cz>, L

On Tue, Aug 21, 2018 at 1:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I suspect that current_text_addr predated GNU C extensions for statement
> expressions and/or taking the address of a label, then the macro was
> reimplemented for every new archs include/asm/processor.h, even though
> there were very few call sites, and none required an assembly
> implementation vs the C implementation.

I actually have this very dim memory that we had some compiler issues
where a label in the code resulted in gcc generating worse code
elsewhere in that same function.

But current_text_addr() predates both the git and the BK history, so
it's all shrouded in antiquity, and even if my dim recollection is
true, it may not be true any more. There aren't so many call sites
that it is likely to matter anyway.

             Linus
