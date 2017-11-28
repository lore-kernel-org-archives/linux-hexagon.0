From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] kbuild: Set KBUILD_CFLAGS before incl. arch Makefile
Date: Tue, 28 Nov 2017 20:27:43 +0100
Message-ID: <CAMuHMdVcs6zYtP=TN6BwH-CPDnJ3PhZ789c0Zd-89BgO+VNHZA@mail.gmail.com>
References: <CAK7LNAS1NaqPRhK6FOXN=YTMhLagpSrR2=tXn-uWZbpzr=NeoQ@mail.gmail.com>
 <20171115204231.34914-1-ndesaulniers@google.com> <CAK7LNAQNEHRapzFem3nr7=EWJPYvZby9K7vem-R99ijYNoguEg@mail.gmail.com>
 <CAK7LNASGYZfQFkM3yMRQaHLUwW5Lhp8CxHGX0bJ9sVja0f=n+A@mail.gmail.com> <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Y+UoMGwgmM7GL1NN2LOgYEPE7uLsEdBykzTmE5b8jOk=;
        b=hkcPJaeJCMkikSDHU1K6DlMfWJcNXcXV93cTdiHJUQYGqi9h0Xgm/9XFR7fc6GNipP
         hkWqoJXU65nWtLYmJaxf63nWFcyCt2nINxBAsQuHHvfpj81IN/q9LGP++N8MiEsKvhbu
         +vxSzgJsaPrzVXo6Alu9Q9dillULZWFHTxEAmKl/jl9A4YjcxRp/1QM3G1t33JIYkRv6
         akcf61ktdEm5kUoBNAVv8DKO6bAnyhLLkVxyD+7ZnvjsUce2x4TGzz2fDAblBSGMSUHk
         LCgySzkKk2tJVxm0Nu/JmctWmqn4kGFhF0pKBwwfvKJIFO14Iy0gLRW4ISjap7pQWkSO
         9bKg==
In-Reply-To: <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Greg Hackmann <ghackmann@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Openrisc <openrisc@lists.librecores.org>, Michal Marek <mmarek@suse.com>, Matthias Kaehlcke <mka@chromium.org>, =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>, Chris Fries <cfries@google.com>, Mark Charlebois <charlebm@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Nick,

On Tue, Nov 28, 2017 at 7:18 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Thanks for merging Chris' patch, and sorry for taking so long to respond.
>
> On Wed, Nov 22, 2017 at 8:24 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Linus suggests to move compiler flag testing to Kconfig.
>
> Do you have an LKML link for context?
>
> On Wed, Nov 15, 2017 at 6:32 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> BTW, I notice another issue.
>>
>> If we move clang settings before including arch Makefile,
>> "ifneq ($(CROSS_COMPILE),)" comes early.
>>
>> Some arch Makefiles (arch/mips/Makefile, arch/blackfin/Makefile, etc.)
>> set CROSS_COMPILE there if CROSS_COMPILE is not given.
>>
>> Then, we have a conflict between two requirements among arch.
>>
>> [1] arm64, powerpc use ld-option in their Makefile.
>>     So, clang flags must be set before inc. arch Makefile.
>> [2] mips, blackfin, etc. may set CROSS_COMPILE in their Makefile.
>>     So, we want to reference CROSS_COMPILE only after inc. arch Makefile
>>
>> I have no idea how to solve it.
>>
>> At this moment, I guess clang is intended to support
>> only limited architectures.
>>
>> It might be OK to be compromised here.
>
> I definitely find it curious that certain arch's define CROSS_COMPILE
> themselves.  The benefit is one less argument to supply at compile
> time, but it assumes that the toolchain always has a certain prefix.
> This makes sense to me when cross compiling, but seems odd when
> compiling natively on that arch as the host and target.  Maybe those
> arch's use that convention, or simply are always cross compiled for?
>
> Taking a survey of all arch's currently in the kernel via `cd arch; ag
> CROSS_COMPILE` and quickly eyeballing the result:
>
> m68k if not set

And inside "ifneq ($(SUBARCH),$(ARCH))", so the prefix is not used for
native compilation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
