From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 3/3] mm, arch: add generic implementation of pfn_valid() for
 FLATMEM
Date: Thu, 26 Jan 2023 08:22:15 +0100
Message-ID: <03605ec4-3e31-475e-8acf-2c342436aa24@app.fastmail.com>
References: <20230125190757.22555-1-rppt@kernel.org>
 <20230125190757.22555-4-rppt@kernel.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674717756; x=1674724956; bh=E33V4yTgr/
        ebT73Eum3QUd1t2W82YQcLJ50MWaQWWA8=; b=GiLb/skMhyZcQ01dO+WmZTL0hL
        fZ2ikfEbw6M+0GfWoi9BCHFyTrzd/xw84UaBaAMBNbekfpfzAvn0+3OyIl7DpZIk
        AscfaN2jhi+H4+HQPHW6kdeYv0wuJbvXO+Nmf3robmrH9p5Eaz+pTFIh+gw7OUdr
        GHaCtnvyFflXRN840zxE0TueOxb7X1UKgvjA9BbNkN54rpLAR1FBHefwPtJLfO63
        HU5voKjovLZNYSTASSTneRk9lhMeYYIxU5ah7ERIB1I+Tlqz6Sh6cL1quV9LIBsu
        LJGaa2P7uDg6V7dGWcg5+AdhatDXLV001yKTEzZw6AETD2Ctpr5noVgk6LyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674717756; x=1674724956; bh=E33V4yTgr/ebT73Eum3QUd1t2W82
        YQcLJ50MWaQWWA8=; b=i56wP0aRGUynM8c34e7C84YjtNs5ESnKIS4Qk9sa0afa
        hZ6EA3tyzNwBZXGsbGt4dL3J7JuIzcSWHi3zNRP0iTUuzQE6/UwhR5FhRpLn/ouY
        xt6qq+vPBvkzpCHoSxo03igHd1P6lM5xa5cKrF0kUrwg7q2T50CTjxmrDjS0magc
        ZxGVHrCofyRHgqO1ckZj1XRFm2MlqCsUcWY5ZDdbx7SuYVnKPtd0L9F879LdS+aK
        Dn7zgQYu29nT9qh2c89O8Dw8mgobJhwQ28spFTbeCvY5iq0cHOI93ldlBxi2zZYx
        hCfhfAJXQq9sSPCh3KQtBHwxvY8+uaUayqJxJdu1iQ==
In-Reply-To: <20230125190757.22555-4-rppt@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Cain <bcain@quicinc.com>, "David S . Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, guoren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourcefo>

On Wed, Jan 25, 2023, at 20:07, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume this can best go through the mm tree, let me know if I should
pick it up in the asm-generic tree instead.

     Arnd
