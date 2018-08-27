From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] treewide: remove current_text_addr
Date: Mon, 27 Aug 2018 09:33:58 +0200
Message-ID: <20180827073358.GV24124@hirez.programming.kicks-ass.net>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4niXgHCOpGFR7j3IAOiZMy+VHLpilhm80al93VoLw74=; b=iTL+tWesLHbPDX
	2IVtKNmWhpdVBuMs53XCDs5rh+hYurm/NdlzdSnAZGzeflxbNHn3XrQ4xr8xt/hZvZU6tB8lBSc5b
	4Yra8MzFnzmEi84XlyENgCdz29r9tIY1r/O0MxKEZfziJwcoIZusKyhxq+KTZcw8ObvniPORJFdzh
	Xu2pvT4lNyxCBIz46pCOoGYk4zve+YSdvWcWk7D7TrV9Z8tMMSxLBTO18S3O55+VNZxlD5fAfDuwW
	SBgM00RVefMk1Oo9MAodPDe2bPX5PoXR6VFI3RLrQgYDGsE/0AQ0bXs4ySjrz0XHc0jmopUcue1My
	iHrcsRJcgzfhv1MFrEeA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qVUB9DNmoBMYfA2lysb8di+NzDA545oCrL4rBL3z5pI=; b=qAQYFyXrkfBtZHb1RWBXddJzi
 ak6iWmHPtN7UAJdK8firITUhKuoRTGkaWeuP0PMYHKt1MRjRDZKAyoofvlKig9tCbmUYps9Uq6+EX
 ZbB2ljXYVam2DTIiN51Rjt19mNL3AIQ+RY/ban5nMO5uRZSbenGi/WiC5lS2a7JUQU7IO47G2cwpB
 LIuxpK8mcZf38eFxbuGL5qyfKZN3Tat6qz73Aipz2UXffUuLNIXd6U/6x+THDhJnYIpe93pBYX4vS
 lypQaS9dJVo0ToybQ6LR2K3oVWLb5YS04r58DfAKpwhj1dAd7Lbqac8fCexmXZ0hTxfaGOhHrNtsS
 NW74AUo4Q==;
Content-Disposition: inline
In-Reply-To: <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
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
Cc: nicolas.pitre@linaro.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, benh@kernel.crashing.org, Will Deacon <will.deacon@arm.com>, paulus@samba.org, mpe@ellerman.id.au, jejb@parisc-linux.org, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, gor@linux.vnet.ibm.com, mattst88@gmail.com, uclinux-h8-devel@lists.sourceforge.jp, Marc Zyngier <marc.zyngier@arm.com>, linuxram@us.ibm.com, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, luto@kernel.org, shannon.nelson@oracle.com, Thomas Gleixner <tglx@linutronix.de>, alex.bennee@linaro.org, rth@twiddle.net, jkosina@suse.cz, LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, rkuo@codeaurora.org, paul.burton@mips.com, aneesh.kumar@linux.vnet.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-f>

On Sun, Aug 26, 2018 at 07:52:59PM -0700, Nick Desaulniers wrote:
> On Sun, Aug 26, 2018 at 1:25 PM Linus Torvalds

> > Instead, maybe we could encourage something like
> >
> >   struct kernel_loc { const char *file; const char *fn; int line; };
> >
> >   #define __GEN_LOC__(n) \
> >         ({ static const struct kernel_loc n = { \
> >                 __FILE__, __FUNCTION__, __LINE__  \
> >            }; &n; })
> >
> >   #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))
> >
> > which is a hell of a lot nicer to use, and actually allows gcc to
> > optimize things (try it: if you pass a _THIS_LOC_ off to an inline
> > function, and that inline function uses the name and line number, gcc
> > will pick them up directly, without the extra structure dereference.
> >
> > Wouldn't it be much nicer to pass these kinds of "location pointer"
> > around, rather than the nasty _THIS_IP_ thing?
> >
> > Certainly lockdep looks like it could easily take that "const struct
> > kernel_loc *" instead of "unsigned long ip". Makes it easy to print
> > out the lockdep info.

> This is extremely reasonable.  I can follow up with the lockdep folks
> to see if they really need _THIS_IP_ to solve their problem, or if
> there's a simpler solution that can solve their needs.  Sometimes
> taking a step back and asking for clarity around the big picture
> allows simpler solutions to shake out.

What problem are we trying to solve? _THIS_IP_ and _RET_IP_ work fine.
We're 'good' at dealing with text addresses, we use them for call stacks
and all sorts. Why does this need changing?
