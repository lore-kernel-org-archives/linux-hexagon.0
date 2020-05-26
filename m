From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] compiler/gcc: Raise minimum GCC version for kernel builds
 to 4.8
Date: Tue, 26 May 2020 09:08:33 -0700
Message-ID: <CAKwvOd==CjrmNcDSEWa3hs4WWPecJorY5txG4T4FsFODhaa2sA@mail.gmail.com>
References: <20200526153004.GA74229@roeck-us.net> <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
 <8c5f8a2c-0ca2-b2f2-4278-d02198d4dd8d@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTyuk3oWFBmxwvB6ngXRDL+X9/MYc3CApnCwn/T5TSU=;
        b=FHWbf7Wvjx5PdFz1RG7GNaycGzbTIS84kShvUC8ttI3+RmlxdUuXD1p5owVRaFhTB6
         3tY/uF5IwyOh8mW2SAjJgmIIyM2+lCY6pDZeVJS/723twN1Gz7uEeBGd3V2K9LJC/tmw
         CQeGteduJXQDsPw46eMazXB9C6kbV0Et9ePdVy+qS0kZLQ2QrLOyA3BxQbojCmFnxxXJ
         +huUHYV1OZwVexvCRpVdPHtxlaEKDqdLtntbci/1NuUVYwQBD1eZ+l+MeoL/td7mGY8h
         Hj0ranoD0nm4/MxLjwGWGljYNsivM5nRfjxsmSMLQDG+EFmhjkGEg3QUi1X9h0hpDisq
         8UDQ==
In-Reply-To: <8c5f8a2c-0ca2-b2f2-4278-d02198d4dd8d@roeck-us.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Will Deacon <will@kernel.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Tue, May 26, 2020 at 9:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Nick,
>
> On 5/26/20 8:40 AM, Nick Desaulniers wrote:
> > On Tue, May 26, 2020 at 8:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> >>> It is very rare to see versions of GCC prior to 4.8 being used to build
> >>> the mainline kernel. These old compilers are also known to have codegen
> >>> issues which can lead to silent miscompilation:
> >>>
> >>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >>>
> >>> Raise the minimum GCC version to 4.8 for building the kernel and remove
> >>> some tautological Kconfig dependencies as a consequence.
> >>
> >> My hexagon compiler is v4.6.1, and I have been unable to find a more
> >> recent version. Does anyone happen to have a pointer to a hexagon toolchain
> >> with gcc 4.8 or later ?
> >
> > IIUC, hexagon moved to LLVM, though that target still has issues
> > building the kernel.
> > https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+hexagon%22
> >
>
> That won't help me for my build tests. It is bad enough having to maintain
> one compiler. I don't want to add another one to the mix, and I'll happily
> leave llvm build tests for ClangBuiltLinux. Guess I'll have to stop hexagon

:( We could use the additional test coverage.

> test builds starting with 5.8.
>
> Guenter



-- 
Thanks,
~Nick Desaulniers
