From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Sun, 26 Aug 2018 13:25:14 -0700
Message-ID: <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
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
	List-Owner; bh=Z69Pn20Ng0iqHptL7g3iS+/x9XnS61LzTemJM6xommw=; b=aHWXOadbv5w6AF
	FfSROyffDm0ZIm/BArs53QiaB1WD8Gc5+muO9j0KUXiqKARF3T/L7c729Wl694169Fh2Ph23/hL+Q
	nlZe6Rzvyr3ZBP57N8sw/fXi1ga7TIRI7LLKWevLw10LdTy40cWFJtbFvpTHxX86ufItJZIT5ygEM
	ByR3nTA/skU8im/stWwzQQfB8i3V1WMYS6TwtXpPl1GM3FU2MuWnZifv+KInjFcFNobRQKeNAWreL
	KeBL6zxYpWKALx+SS0RpzwLijw8U48B/VmlqXlUeR1pkp3Av2SFA5yGxsOPE7ZLge1cMF7xjTRbId
	4d6yGbdH4eiMFR0WfiUg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dv1Zcv6yXV8JnerUXBelQioxfreCKhp9x/roL8HAR1I=;
 b=Qv+RrAJ/N6qen72rY9BU1nLz2fhljA6/X1iKITlTVDj2mLNwFWOWN3ypaj2qdf1CH3
 Jd2L1Ze/zarujO4YtXPYCgl/FYaXNv7z/j1xY/1u5dOKOFTwmh0+cLIXEqFNgQMtEaNY
 NIYEnA15J3iItWZpcDjMSTUFsMxSXM5+ctwGg=
In-Reply-To: <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
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
To: Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, gor@linux.vnet.ibm.com, Matt Turner <mattst88@gmail.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Marc Zyngier <marc.zyngier@arm.com>, Ram Pai <linuxram@us.ibm.com>, linux-um@lists.infradead.org, Nick Piggin <npiggin@gmail.com>, Andrew Lutomirski <luto@kernel.org>, shannon.nelson@oracle.com, Thomas Gleixner <tglx@linutronix.de>, alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>, Jiri Kosina <jkosina@suse.cz>, N

On Sun, Aug 26, 2018 at 12:32 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> Here is a full-blown (user space) test program demonstrating the whole
> technique and how to use it.

So while I agree that some _THIS_IP_ users might be better off being
converted to __builtin_return_address(0) at the caller, I also think
that the whole "notailcall" thing shows why that can easily be more
problematic than just our currnet _THIS_IP_ solution.

Honestly, I'd suggest:

 - just do the current_text_addr() to _THIS_IP_ conversion

 - keep _THIS_IP_ and make it be the generic one, and screw the whole
"some architectures might implement is better" issue. Nobody cares.

 - try to convince people to move away from the "we want the kernel
instruction pointer for the call" model entirely, and consider this a
"legacy" issue.

The whole instruction pointer is a nasty thing. We should discourage
it and not make complex infrastructure for it.

Instead, maybe we could encourage something like

  struct kernel_loc { const char *file; const char *fn; int line; };

  #define __GEN_LOC__(n) \
        ({ static const struct kernel_loc n = { \
                __FILE__, __FUNCTION__, __LINE__  \
           }; &n; })

  #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))

which is a hell of a lot nicer to use, and actually allows gcc to
optimize things (try it: if you pass a _THIS_LOC_ off to an inline
function, and that inline function uses the name and line number, gcc
will pick them up directly, without the extra structure dereference.

Wouldn't it be much nicer to pass these kinds of "location pointer"
around, rather than the nasty _THIS_IP_ thing?

Certainly lockdep looks like it could easily take that "const struct
kernel_loc *" instead of "unsigned long ip". Makes it easy to print
out the lockdep info.

Ok, I didn't try to convert anybody, so maybe people who currently use
_THIS_IP_ or current_text_addr() have some fundamental reason why they
want just that, but let's not male _THIS_IP_ more complex than it
needs to be.

Hmm?

             Linus
