From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 4/5] hexagon: move core-y in arch/hexagon/Makefile to arch/hexagon/Kbuild
Date: Sat, 22 May 2021 10:16:53 +0900
Message-ID: <CAK7LNAQweN_=f0hvMo4CK7ZM=rGnhf_dQF3XRTAyPsA3Ca7p4g@mail.gmail.com>
References: <20210512075729.60291-1-masahiroy@kernel.org> <20210512075729.60291-4-masahiroy@kernel.org>
 <YKeLoDy3QddLd6jb@lillesand.fjasle.eu>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 14M1HUhd025311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621646251;
        bh=GD6Yp0ZT6wOegnCWg09McQE8unMC0H+KwAvBi2hFOvs=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=hXZbzXvNepiCfC0Fk2/z7yo4z9Bz2G5cYYux6m7HCl9GiI3beXEQQ3xA05Ldle5ak
         KVKTJhTjidfDCPIUpXw8MOmXQ/W/LDrUy41eNuH/y4kyPdVzNKgK2SFV+tVHoInFlm
         I4Z4B2RG0DxziIlBrqWBgLVb2+F6A3zd8luuO7mgYiXNCG2HhzIvVfEVKPv89Li9sB
         sG79YKObxKjGF0XLOzySusHUeH6DmdgGBqHrMS8IKF07UFL2avDVZ8H8qrKkRvvlpb
         s0q80rW/vjauyjvMuL7R9hfNRuKDQ3Y+XEa3Jg6DkQB+3QmpeweWwtjdZDqqrEeBOm
         YIpQZx30hgUxw==
In-Reply-To: <YKeLoDy3QddLd6jb@lillesand.fjasle.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, May 21, 2021 at 7:30 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> Hi Masahiro,
>
> On Wed 12 May 2021 16:57:28 GMT, Masahiro Yamada wrote:
> > Use obj-y to clean up Makefile.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/hexagon/Kbuild   | 1 +
> >  arch/hexagon/Makefile | 4 ----
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/hexagon/Kbuild b/arch/hexagon/Kbuild
> > index a4e40e534e6a..d930c2f954d5 100644
> > --- a/arch/hexagon/Kbuild
> > +++ b/arch/hexagon/Kbuild
> > @@ -1 +1,2 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +obj += kernel/ mm/ lib/
>
> This should probably be 'obj-y' instead of 'obj'?
>

Oops, thanks for catching that!
I will fix it when I apply it.

-- 
Best Regards
Masahiro Yamada
