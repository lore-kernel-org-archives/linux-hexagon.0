From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] flush_icache_range: Export symbol to fix build errors
Date: Mon, 18 Aug 2014 08:59:59 +0200
Message-ID: <CAMuHMdWSO6V5Ln=Yp5yEQ0YHyH38yU5uyQytxJbmazZuL-=1DQ@mail.gmail.com>
References: <1408335898-3109-1-git-send-email-bobby.prani@gmail.com>
	<CAMo8Bf++rGnUkeOy3_gCimv9moStOx+fOtGAAeCXT8Hz2RsvBg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1f0jQMZLwmb959weXSi/EKTXWI1l4kYNGjMwEmxLj9g=;
        b=btu+CtVkspaiBxJ8b+CZ0gfWC6o5kZBY5cviGBp72JrngQjrQPPoRRwLTo1SAY9FVO
         +hOwsnyHwVfMKAND4alyyBOKttNa/jL1zd+rYEDXqNm9ZZOK5qUfSj2/fw2yQLb+HuC0
         Ty+Q2vp3opITdI+A7TVwgao0RKpaAsdmxhBDmwp7nUTgdXg/M2R5N94NyqHgm8CVT/cd
         k+/sJ6wr1YhSiVYiZnGg1HFvUwq//8W3eqTPq4NV8dt7idvNykhRe8cSfzyG9xuILNnm
         WEHNcD7dVth5kf/XdSIObijkpeFuNziXJz2xzLkFUIp2VkH5qaVBMAPVaWvkijHiyEMA
         +YRw==
In-Reply-To: <CAMo8Bf++rGnUkeOy3_gCimv9moStOx+fOtGAAeCXT8Hz2RsvBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pranith Kumar <bobby.prani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Noam Camus <noamc-d5a29ZRxExrQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Masami Hiramatsu <masami.hiramatsu.pt-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>, Tony Lu <zlu-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Kirill Tkhai <tkhai-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:BLACKFIN ARCHITEC..." <adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:METAG ARCHITECTURE" <linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:SUPERH" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:TENSILICA XTENSA..." <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>

On Mon, Aug 18, 2014 at 8:35 AM, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Aug 18, 2014 at 8:24 AM, Pranith Kumar <bobby.prani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Fix building errors occuring due to a missing export of flush_icache_range() in
>> architectures missing the export.
>
> Can you be a little more specific here, what build errors?

kisskb.ellerman.id.au/kisskb/buildresult/11677809/

ERROR: "flush_icache_range" [drivers/misc/lkdtm.ko] undefined!

> [...]
>
>> diff --git a/arch/frv/include/asm/cacheflush.h b/arch/frv/include/asm/cacheflush.h
>> index edbac54..07ee4b3 100644
>> --- a/arch/frv/include/asm/cacheflush.h
>> +++ b/arch/frv/include/asm/cacheflush.h
>> @@ -72,6 +72,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
>>  {
>>         frv_cache_wback_inv(start, end);
>>  }
>> +EXPORT_SYMBOL(flush_icache_range);
>
> EXPORT_SYMBOL should not be placed into header file as it defines
> a non-static variable.

Indeed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
