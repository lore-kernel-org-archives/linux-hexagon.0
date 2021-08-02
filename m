From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
Date: Mon, 2 Aug 2021 11:03:57 -0700
Message-ID: <CAMo8BfLDjw71xiCDo8uk4pQFuOzqAoak0k3R4YJDnRsA2hoCtw@mail.gmail.com>
References: <20210731052233.4703-1-masahiroy@kernel.org> <20210731052233.4703-2-masahiroy@kernel.org>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpOmQ9FDFdEDp1DRxCOS4/jNxSUC+b7VQifrd/M4FUE=;
        b=bllfssUh1l3Cfof1I9S9zG5MovjfwF9CypWcpRvDmWpOEx759rPpO8GjtwWqnstMf2
         1QwJGh+kGvZKoMFQKf6FhnPOMkpo3JEJzP0z2jokepgekez40su6FDqDQO76azQW4aaY
         ndpMqrh8QhqQUbO9PB7UVTzGgkGjnuiB8BDrnOUlo6IfpOOOD5wRbVnNH3nzFEb8Jlvv
         f2sHv6d82OwwrINjEhGy7L8YhBy8Uq7x29x9aN5cqnZAFpZ+YseiNvbNJLRthMaSdJt+
         GNYBQGlDLHbH2bDQodG8T6OzjQiYO36wOgJ2MGUlCkSsxnL4jcZpqW+jXXGFabstpv3T
         roTQ==
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, linux-mips@vger.kernel.org, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Nick Hu <nickhu@andestech.com>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, YiFei Zhu <yifeifz2@illinois.edu>, Greentime Hu <green.hu@gmai>

On Fri, Jul 30, 2021 at 10:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  arch/xtensa/Kconfig           | 4 +---

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
-- 
Thanks.
-- Max
