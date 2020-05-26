From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] compiler/gcc: Raise minimum GCC version for kernel builds
 to 4.8
Date: Tue, 26 May 2020 08:40:14 -0700
Message-ID: <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
References: <20200526153004.GA74229@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjnl/JxEGriKorXrTPs6RAu94HRZLs85s5QetpCKq1Q=;
        b=qFcDYd0iBnzGrt/TK7N0lwbAK6KbDETo97IeZd0WVVyBA+aJoUp4jzuPFO8ypMc/Gb
         L7Rqn9kLpHYSHEuuUHDRpPNWXmcnhoSRFQjlBFEUwhxfO22bW9twODIuQad+Y80bvEpv
         lrjug32IiXaSGIopv6PKagvIJpdH/CqiY2+Pnj/Fv1fD1k4IgUiOALE7G113xZAJGbQW
         fFSTKNTEYvpG2/5PMP8CkjAnwhhDiqBMHvW0pzdPaIg7bX/0Pzj7ppU34ipPTNcrjeL9
         OBzYWILVYCRBQaNaU7bUS5GZufm9vccOIjcJsKArMM+nOnz2ee4qt7h50anJgJuBDpPj
         CqIg==
In-Reply-To: <20200526153004.GA74229@roeck-us.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Will Deacon <will@kernel.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Tue, May 26, 2020 at 8:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> > It is very rare to see versions of GCC prior to 4.8 being used to build
> > the mainline kernel. These old compilers are also known to have codegen
> > issues which can lead to silent miscompilation:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > Raise the minimum GCC version to 4.8 for building the kernel and remove
> > some tautological Kconfig dependencies as a consequence.
>
> My hexagon compiler is v4.6.1, and I have been unable to find a more
> recent version. Does anyone happen to have a pointer to a hexagon toolchain
> with gcc 4.8 or later ?

IIUC, hexagon moved to LLVM, though that target still has issues
building the kernel.
https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+hexagon%22
-- 
Thanks,
~Nick Desaulniers
