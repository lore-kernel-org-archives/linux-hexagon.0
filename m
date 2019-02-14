From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
Date: Thu, 14 Feb 2019 18:02:39 +0000
Message-ID: <20190214180239.GI2475@fuggles.cambridge.arm.com>
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
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
	List-Owner; bh=ODjKEwaKLAAsKFITqpMsH1FbYc9DUJtLjtfbwzjOZ+o=; b=h7sDSZvJE1bExS
	ddWEzZU/qYxryAUVVuQ8erqxHdc6I7m6bEwEVIjfyfpSH5hLq5icke9n4RXWg81YSOoWv6ZeDf0VM
	eWRAXxHX0JfOu9Zy8gOn1Fbv8dtcPu5m+oIDyrYiFm4WhAslwVHlow6Z75rTRPhVe07l2N8crfCFU
	2pxuPYv6Oaga5BIjZh8I7RWXlsqQ5RNikYFTtfu4q4pNq5UJv7G3TNh+86ExeRpdgBNtD622639f1
	83m/oF6KaZxjdbsCyNFgd2jxi8rAUs4bcLbMvh53BsAk3p3Rv4USHXkTlyH8U0BGm1ZVad6vvpHwi
	B9nMewt4gG64wFTEGObA==;
Content-Disposition: inline
In-Reply-To: <20190214103333.GH32494@hirez.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 14, 2019 at 11:33:33AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 03:32:12PM -0500, Waiman Long wrote:
> > Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> > it generate slightly better code.
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
> >    0x0000000000000000 <+0>:	callq  0x5 <down_read_trylock+5>
> >    0x0000000000000005 <+5>:	xor    %eax,%eax
> >    0x0000000000000007 <+7>:	lea    0x1(%rax),%rdx
> >    0x000000000000000b <+11>:	lock cmpxchg %rdx,(%rdi)
> >    0x0000000000000010 <+16>:	jne    0x29 <down_read_trylock+41>
> >    0x0000000000000012 <+18>:	mov    %gs:0x0,%rax
> >    0x000000000000001b <+27>:	or     $0x3,%rax
> >    0x000000000000001f <+31>:	mov    %rax,0x20(%rdi)
> >    0x0000000000000023 <+35>:	mov    $0x1,%eax
> >    0x0000000000000028 <+40>:	retq
> >    0x0000000000000029 <+41>:	test   %rax,%rax
> >    0x000000000000002c <+44>:	jns    0x7 <down_read_trylock+7>
> >    0x000000000000002e <+46>:	xor    %eax,%eax
> >    0x0000000000000030 <+48>:	retq
> > 
> > By using a rwsem microbenchmark, the down_read_trylock() rate (with a
> > load of 10 to lengthen the lock critical section) on a x86-64 system
> > before and after the patch were:
> > 
> >                  Before Patch    After Patch
> >    # of Threads     rlock           rlock
> >    ------------     -----           -----
> >         1           14,496          14,716
> >         2            8,644           8,453
> > 	4            6,799           6,983
> > 	8            5,664           7,190
> > 
> > On a ARM64 system, the performance results were:
> > 
> >                  Before Patch    After Patch
> >    # of Threads     rlock           rlock
> >    ------------     -----           -----
> >         1           23,676          24,488
> >         2            7,697           9,502
> >         4            4,945           3,440
> >         8            2,641           1,603
> 
> Urgh, yes LL/SC is the obvious exception that can actually do better
> here :/
> 
> Will, what say you?

What machine were these numbers generated on and is it using LL/SC or LSE
atomics for arm64? If you stick the microbenchmark somewhere, I can go play
with a broader variety of h/w.

Will
