From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] flush_icache_range: Export symbol to fix build errors
Date: Mon, 18 Aug 2014 10:35:36 +0400
Message-ID: <CAMo8Bf++rGnUkeOy3_gCimv9moStOx+fOtGAAeCXT8Hz2RsvBg@mail.gmail.com>
References: <1408335898-3109-1-git-send-email-bobby.prani@gmail.com>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DUMdgYkHn3SehWc2Z4vWrus/ToFqwhUNfc4WBLjUojc=;
        b=S0bKxMtGCdvbO+1gmETdkqHNBFh9FYLGS2/Gmzq9rIw/DCzarC5bjPJViG1Ezqd++e
         0ZYliAzkcMBbX3BmwCk8PTna40q2joUDsInEAReoRCHZRuh/jY5C7stN0bYVGYap7qcR
         fjfFuUXTP7HErXHffmPXaAl4LEAnLuTaT6FHKr1ufzSDHyR9kAYRzJL46mlC76jVFBXN
         cMmDSY4dVvioo2AcqJU2N+1loagsd94Q/8pE6hlM1IMiRGWclRfaAPh5kOaCG8SS6HBN
         N4WmyusuyjviwF8tdJOZa7vcZzi/Zj94QH64ke4rK7LbMGfZZfWld+y4cKVFILF9WI9S
         Ulpw==
In-Reply-To: <1408335898-3109-1-git-send-email-bobby.prani@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, Noam Camus <noamc@ezchip.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tony Lu <zlu@tilera.com>, Kirill Tkhai <tkhai@yandex.ru>, open list <linux-kernel@vger.kernel.org>, "moderated list:BLACKFIN ARCHITEC..." <adi-buildroot-devel@lists.sourceforge.net>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>

Hi Pranith,

On Mon, Aug 18, 2014 at 8:24 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Fix building errors occuring due to a missing export of flush_icache_range() in
> architectures missing the export.

Can you be a little more specific here, what build errors?

[...]

> diff --git a/arch/frv/include/asm/cacheflush.h b/arch/frv/include/asm/cacheflush.h
> index edbac54..07ee4b3 100644
> --- a/arch/frv/include/asm/cacheflush.h
> +++ b/arch/frv/include/asm/cacheflush.h
> @@ -72,6 +72,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
>  {
>         frv_cache_wback_inv(start, end);
>  }
> +EXPORT_SYMBOL(flush_icache_range);

EXPORT_SYMBOL should not be placed into header file as it defines
a non-static variable.

[...]

> diff --git a/arch/metag/include/asm/cacheflush.h b/arch/metag/include/asm/cacheflush.h
> index 7787ec5..117c212 100644
> --- a/arch/metag/include/asm/cacheflush.h
> +++ b/arch/metag/include/asm/cacheflush.h
> @@ -124,6 +124,7 @@ static inline void flush_icache_range(unsigned long address,
>         metag_code_cache_flush((void *) address, endaddr - address);
>  #endif
>  }
> +EXPORT_SYMBOL(flush_icache_range);

Same here.

-- 
Thanks.
-- Max
