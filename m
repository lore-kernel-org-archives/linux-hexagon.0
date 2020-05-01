From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] hexagon: suppress error message for 'make clean'
Date: Fri, 1 May 2020 14:33:21 +0900
Message-ID: <CAK7LNAR+PjvE3yQS7xdKo5Cf_K1xDg+NijistAqWX7Ob=_irWg@mail.gmail.com>
References: <20200424161502.656103-1-masahiroy@kernel.org> <009101d61a6b$71f93a70$55ebaf50$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0415Xv7h011238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588311238;
        bh=oOUTjHbglUckIEy8WVvMgD3ZhjrrhESz7wu9wTM0qt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jPIC9BRAIB9gWJZqCfy5olbgMzB5gtYjxvxZV8vB3/20I/w8YksC++qd7vBvzEYh2
         GsSeFMclrVoYAkD8WZp0qlc+Vt5QAOYHhfjsRAThxSshwDkpgEw+12TwbY0TULiStT
         qh6hnfD+fsDsOgsC8Uj3GgXmkwAVvbDrYWYn8RejYsv1eagVwJaMC0DQ+ThW+57Nqm
         m94prNdcVoeJDpAa9zEcWxJwytj26VVPuBzvJ00iY/v6x2bmW518NNA3g1So15R8yz
         TDZne2D0mkUFepXrZulc9eYmuzAQZuDhoeNNSHAhVaMAjwXsUzDZV8qZbnbgogh62e
         TJxfU16w4E4yQ==
In-Reply-To: <009101d61a6b$71f93a70$55ebaf50$@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@codeaurora.org
Cc: linux-hexagon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Apr 25, 2020 at 4:06 AM Brian Cain <bcain@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> > owner@vger.kernel.org> On Behalf Of Masahiro Yamada
> ...
> > 'make ARCH=hexagon clean' emits an error message as follows:
> >
> >   $ make ARCH=hexagon clean
> >   gcc: error: unrecognized command line option '-G0'
> >
> > You can suppress it by setting the correct CROSS_COMPILE=, but we should
> > not require any compiler for cleaning.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
> Acked-by: Brian Cain <bcain@codeaurora.org>

Applied to linux-kbuild. Thanks.


>
> > ---
> >
> >  arch/hexagon/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile index
> > 4c5858b80f0e..c168c6980d05 100644
> > --- a/arch/hexagon/Makefile
> > +++ b/arch/hexagon/Makefile
> > @@ -30,7 +30,7 @@ TIR_NAME := r19
> >  KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -
> > DTHREADINFO_REG=$(TIR_NAME) -D__linux__  KBUILD_AFLAGS += -
> > DTHREADINFO_REG=$(TIR_NAME)
> >
> > -LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> > +LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name
> > +2>/dev/null)
> >  libs-y += $(LIBGCC)
> >
> >  head-y := arch/hexagon/kernel/head.o
> > --
> > 2.25.1
>
>


-- 
Best Regards
Masahiro Yamada
