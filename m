From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH 0/20] mmu: arch/mm: Port OOM changes to arch page fault handlers.
Date: Tue, 20 Mar 2012 14:30:49 +0100
Message-ID: <CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
References: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=J7fcuDjZVrcDQdx4DP+Z6d4xJi3bJiuzvuUvio0D4j4=;
        b=HloaaXFkFYwvksBKW9dNDXvU9T1gRZL1zaDrUzD7dBcP0b6r38y9mjj01EsKYbXo40
         KXPKvbyIDJzzywSVGdyG/yXVltFcNMxBQP/BosamRzFaDAk4ILlZHkhwhdUwdEL6ZJ3G
         JpCthkf4+0AAdG27Q95UYD3dCnOoe42t+Z8LxFYDC9eSc8NasT85F+K9KNW/F95bIgqO
         nUU1zxdo7O36XIZ+nFcMwr6BaKsY1XknacxtEmqb/nzqCQLCGl9lCjH8j58BuGjdbWi2
         vfxTuMy2H89ghnXkvevsGDEOZOO1ASz3Qqs5toCGdwZdt5WYybGXlAvVxdxJOnBt6rGb
         xiIA==
In-Reply-To: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kautuk Consul <consul.kautuk@gmail.com>
Cc: linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux@lists.openrisc.net, linux-am33-list@redhat.com, microblaze-uclinux@itee.uq.edu.au, linux-m68k@lists.linux-m68k.org, linux-m32r-ja@ml.linux-m32r.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-cris-kernel@axis.com, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Tue, Mar 20, 2012 at 2:18 PM, Kautuk Consul <consul.kautuk@gmail.com> wrote:
> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
> (mm: retry page fault when blocking on disk transfer) and
> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
> (x86,mm: make pagefault killable)
>
> The above commits introduced changes into the x86 pagefault handler
> for making the page fault handler retryable as well as killable.
>
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
>
> I was facing hang and livelock problems on my ARM and MIPS boards when
> I invoked OOM by running the stress_32k.c test-case attached to this email.
>
> Since both the ARM and MIPS porting chainges were accepted, me and my
> co-worker decided to take the initiative to port these changes to all other
> MMU based architectures.
>
> Please review and do write back if there is any way I need to
> improve/rewrite any
> of these patches.
>

What about arch/um/?
Does UML not need this change?

-- 
Thanks,
//richard
