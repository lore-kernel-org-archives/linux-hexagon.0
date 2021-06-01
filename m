From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/3] hexagon: Use common DISCARDS macro
Date: Tue, 1 Jun 2021 12:18:35 -0700
Message-ID: <CAKwvOd=T9HTUXETv2EJit0Qa8+p7NhTxcfZ3FYqy1xu--GNkgA@mail.gmail.com>
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-3-nathan@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvgn/sxx7fGdQ0zzgT5kUctxtrwYDVPpVuGOvB0eRkA=;
        b=pqfGVO0rokdZUODQi3AfTBRhuEcIua1lvBvXpame6DPSE4q2YkVue74W6/3vNeKk2o
         uNhHpTK01zPwMuAsDr6x6qY1gUny7sCnZlAvs9Y4FN0Kfz/PIA0mWQAtP47f+llLIYI2
         R66XJneli7t4gptoOzeLjN0SMTFCwDxA5aMfQFBavmjOkzY/1c1QqtIZpTXtx9H0pCmy
         dqQE8MqfnXye6Setz6mXtDFdQ3ALtvBegeDzRX0R35oT73hcf1KVPgIJH7OFrkZ4QQRW
         iFBCR1hawZI/d1/aDsLRKxaOhAD0DbDO1DnReU4ncqhTPKv0PwJST4e3hQ5y+w2nThrc
         lf+A==
In-Reply-To: <20210521011239.1332345-3-nathan@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Chancellor <nathan@kernel.org>
Cc: Brian Cain <bcain@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Thu, May 20, 2021 at 6:13 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> ld.lld warns that the '.modinfo' section is not currently handled:
>
> ld.lld: warning: kernel/built-in.a(workqueue.o):(.modinfo) is being placed in '.modinfo'
> ld.lld: warning: kernel/built-in.a(printk/printk.o):(.modinfo) is being placed in '.modinfo'
> ld.lld: warning: kernel/built-in.a(irq/spurious.o):(.modinfo) is being placed in '.modinfo'
> ld.lld: warning: kernel/built-in.a(rcu/update.o):(.modinfo) is being placed in '.modinfo'
>
> The '.modinfo' section was added in commit 898490c010b5 ("moduleparam:
> Save information about built-in modules in separate file") to the
> DISCARDS macro but Hexagon has never used that macro. The unification of
> DISCARDS happened in commit 023bf6f1b8bf ("linker script: unify usage of
> discard definition") in 2009, prior to Hexagon being added in 2011.
>
> Switch Hexagon over to the DISCARDS macro so that anything that is
> expected to be discarded gets discarded.
>
> Fixes: e95bf452a9e2 ("Hexagon: Add configuration and makefiles for the Hexagon architecture.")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/hexagon/kernel/vmlinux.lds.S | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
> index 20f19539c5fc..57465bff1fe4 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -61,14 +61,9 @@ SECTIONS
>
>         _end = .;
>
> -       /DISCARD/ : {
> -               EXIT_TEXT
> -               EXIT_DATA
> -               EXIT_CALL
> -       }
> -
>         STABS_DEBUG
>         DWARF_DEBUG
>         ELF_DETAILS
>
> +       DISCARDS
>  }
> --
> 2.32.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
