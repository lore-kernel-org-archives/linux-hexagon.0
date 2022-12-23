From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH 00/19] Introduce __xchg, non-atomic xchg
Date: Fri, 23 Dec 2022 15:23:00 +0100
Message-ID: <20221223142300.1820652-1-alexandr.lobakin@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com> <20221222092147.d2bb177c67870884f2e59a9b@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671805399; x=1703341399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELTp1mLG7Y9aCL8aO+3yggqOoksNOYkU+LC/pmwgzyA=;
  b=h6WHojs6ZpmqWpG2ottoZdl2pYgLLN2M3eW5A5tU9xF/OQlsT/3lk21H
   c+27dZk3j5L1dN6yN+xTy/Nw2p/XcwLUfb5INN1T1g/0ViZeKJo5dasVa
   2aM6Qe9tY1i/8kBLtimzGb9etHds0Vj1ICf1c6EWPlU8veg+mh8GlRw1f
   H1RVwid1/AgXqzvKKGomudHa9NdK5cWPCTVhnP/tSl3PViN1cgTQlPXxG
   AQqDeqzUnhnC4/YrPK4vlFEzcvUOFF7jMGVaZIH/9U4/Af3L+SOw42Fzh
   ybnz3reqKRmJRugCywjpmYvBfkXpozGjqKHcppjmrXomjjgBb2U1Jx0jJ
   g==;
In-Reply-To: <20221222092147.d2bb177c67870884f2e59a9b@linux-foundation.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Andrzej Hajda <andrzej.hajda@intel.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 22 Dec 2022 09:21:47 -0800

> On Thu, 22 Dec 2022 12:46:16 +0100 Andrzej Hajda <andrzej.hajda@intel.com> wrote:
> 
> > Hi all,
> > 
> > I hope there will be place for such tiny helper in kernel.
> > Quick cocci analyze shows there is probably few thousands places
> > where it could be useful.
> 
> So to clarify, the intent here is a simple readability cleanup for
> existing open-coded exchange operations.  The intent is *not* to
> identify existing xchg() sites which are unnecessarily atomic and to
> optimize them by using the non-atomic version.
> 
> Have you considered the latter?
> 
> > I am not sure who is good person to review/ack such patches,
> 
> I can take 'em.
> 
> > so I've used my intuition to construct to/cc lists, sorry for mistakes.
> > This is the 2nd approach of the same idea, with comments addressed[0].
> > 
> > The helper is tiny and there are advices we can leave without it, so
> > I want to present few arguments why it would be good to have it:
> > 
> > 1. Code readability/simplification/number of lines:
> > 
> > Real example from drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:
> > -       previous_min_rate = evport->qos.min_rate;
> > -       evport->qos.min_rate = min_rate;
> > +       previous_min_rate = __xchg(evport->qos.min_rate, min_rate);
> > 
> > For sure the code is more compact, and IMHO more readable.
> > 
> > 2. Presence of similar helpers in other somehow related languages/libs:
> > 
> > a) Rust[1]: 'replace' from std::mem module, there is also 'take'
> >     helper (__xchg(&x, 0)), which is the same as private helper in
> >     i915 - fetch_and_zero, see latest patch.
> > b) C++ [2]: 'exchange' from utility header.
> > 
> > If the idea is OK there are still 2 qestions to answer:
> > 
> > 1. Name of the helper, __xchg follows kernel conventions,
> >     but for me Rust names are also OK.
> 
> I like replace(), or, shockingly, exchange().
> 
> But...   Can we simply make swap() return the previous value?
> 
> 	previous_min_rate = swap(&evport->qos.min_rate, min_rate);

Unforunately, swap()'s arguments get passed by names, not as
pointers, so you can't do

	swap(some_ptr, NULL);

 -- pretty common pattern for xchg.

Thanks,
Olek
