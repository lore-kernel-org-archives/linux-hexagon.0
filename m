From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Date: Tue, 12 Feb 2019 14:25:37 +0100
Message-ID: <20190212132537.GL32534@hirez.programming.kicks-ass.net>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
 <20190212132404.GI32494@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LUxyzoF8taUJIUhKYuRfgN2uXkp6dmLRK7xJXtKYG98=; b=GCjbbTnU7GLXo5
	hOxkm18uAvDsL47A4BGx7pSBCyVKKImkRRizuUmr2RBetym1yw3yjYEBkDa9ntacl7zkj8iE+l9p6
	KWxrgGrdxbHOvciAXHSc3P4rcSczOHBM5aH2ze4C2BfHSyuTWmaP08wSz0zNdmrBEyTfg4nNYyrNB
	fA3ExEmt2OM2t1C6W02BbP/+ffu0ZqzLeD5Bd66g3Cu2zkH8qG/0HtzW0WvaVmUpWuzX8+EASNF2r
	C8Qo6d0eEWxwEfV5Px3Wm6vC3AserduITMq2nF8Ix7sPXCzAd/2VabmR81Q11Cuob0mLWCIVqwdbZ
	E1uAGYswCglFs/e+sftQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vWyEFKoZa/UBq+vRmN2N8BqiM0rFEYhHj/ZSk9dgI8M=; b=mLAa+90auwABrVT4GKqhuDkv0
 imWEqXm6ymnRIoIFMkPFvKLGUQD17vu09MjNgQnmtc66LOwYo+6wNZnfrNpIOjI4dPaeg3RzYuiN5
 gD5mt0OlPbGDyycBLue5YkcBAptFK2fJUFk/hbvi+suireXhE6iY36yt7vmtatXidVBPDgn8SPIK1
 Q6Z/aAYKsmuABMjkXlPmj/sJavwY4/lez/g/5R6/GDfLDnvqhgj7yllnhC2OPk8wyMiva5plYQX//
 IICDBG/AHwbnYoo58P6bwwqOeLTzehNeXSb90Ws0H/aiG+ZIEtNNFzkWZGDsU0TD57b0quPmdAKCe
 hIMIgqU+Q==;
Content-Disposition: inline
In-Reply-To: <20190212132404.GI32494@hirez.programming.kicks-ass.net>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

On Tue, Feb 12, 2019 at 02:24:04PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 11, 2019 at 02:31:26PM -0500, Waiman Long wrote:
> > Modify __down_read_trylock() to make it generate slightly better code
> > (smaller and maybe a tiny bit faster).
> > 
> > Before this patch, down_read_trylock:
> > 
> >    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
> >    0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
> >    0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
> >    0x000000000000000b <+11>:    mov    %rdx,%rax
> >    0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
> >    0x0000000000000013 <+19>:    cmp    %rax,%rdx
> >    0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
> >    0x0000000000000018 <+24>:    mov    (%rdi),%rdx
> >    0x000000000000001b <+27>:    test   %rdx,%rdx
> >    0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
> >    0x0000000000000020 <+32>:    xor    %eax,%eax
> >    0x0000000000000022 <+34>:    retq
> >    0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
> >    0x000000000000002c <+44>:    or     $0x3,%rax
> >    0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
> >    0x0000000000000034 <+52>:    mov    $0x1,%eax
> >    0x0000000000000039 <+57>:    retq
> > 
> > After patch, down_read_trylock:
> > 
> >    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
> >    0x0000000000000005 <+5>:     mov    (%rdi),%rax
> >    0x0000000000000008 <+8>:     test   %rax,%rax
> >    0x000000000000000b <+11>:    js     0x2f <down_read_trylock+47>
> >    0x000000000000000d <+13>:    lea    0x1(%rax),%rdx
> >    0x0000000000000011 <+17>:    lock cmpxchg %rdx,(%rdi)
> >    0x0000000000000016 <+22>:    jne    0x8 <down_read_trylock+8>
> >    0x0000000000000018 <+24>:    mov    %gs:0x0,%rax
> >    0x0000000000000021 <+33>:    or     $0x3,%rax
> >    0x0000000000000025 <+37>:    mov    %rax,0x20(%rdi)
> >    0x0000000000000029 <+41>:    mov    $0x1,%eax
> >    0x000000000000002e <+46>:    retq
> >    0x000000000000002f <+47>:    xor    %eax,%eax
> >    0x0000000000000031 <+49>:    retq
> > 
> > By using a rwsem microbenchmark, the down_read_trylock() rate on a
> > x86-64 system before and after the patch were:
> > 
> >                  Before Patch    After Patch
> >    # of Threads     rlock           rlock
> >    ------------     -----           -----
> >         1           27,787          28,259
> >         2            8,359           9,234
> 
> From 1/2:
> 
> 1        29,201  30,143  29,458    28,615  30,172  29,201
> 2         6,807  13,299   1,171     7,725  15,025   1,804

Argh, fat fingered and send before I was done typing.

What I wanted to say was; those rlock numbers don't match up. What
gives?

The before _this_ patch number of 27k787 should be the same as the after
first patch number of 30k172.
