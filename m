From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Sun, 24 Feb 2013 10:32:53 -0600
Message-ID: <CAHrUA34oWaQvVwWk7cCcYmh188pv=vNCZnXWvn4sDJN0k-QEaA@mail.gmail.com>
References: <1163031361018389@web26d.yandex.ru> <1361593470.29465.17@driftwood>
 <171311361707235@web14d.yandex.ru>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=R/HF4MQndrIbexPOOG/ykMTjbXau4YKRfL25BMCvOvE=;
        b=RtRz9E4N3bgCKtkSY4v1cUn/uL3rnJ6mX8QWH7TVxD5Mtumw5KkhZlT3fc2LbwMv82
         lpcae0vXRzu8EmtPQpexFSADzLy58MZ6TA23ZiSZw39ibLvwdUcnTB4ytUdMce0+izDq
         LMZHhEPA+utSPNg5vzydW2WA3F2VOAPAiqvaK/7SlesiPB4bhKDSvA2T0mMIq3H3B8BB
         JFRwGqxFkfYIIY6Qbt4GP2A76QpORsVdlpar/uJKuvizvnSUtqDkizFvZJWxdRXXUZ8M
         o3KO29ccEr8RwKvS4/J5QxzuPfMsgxZwDGcUE/CsAzDPXqcw+CxNaZCC9snZa77BZjBf
         GAFQ==
In-Reply-To: <171311361707235@web14d.yandex.ru>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 24 February 2013 06:00,  <cotulla@yandex.ua> wrote:
> During tests I got around 90 Mbytes/sec RAM access in simple memcpy on 256Mhz, while ARM got around 880 Mbytes/sec.
> Do you think it's normal or maybe something configured wrong?

> memcpy is done via simpliest way:
> Memory is L1WB L2C. I & D prefetchings are enabled.
>
> memcpy:
> {
>     loop0 (memcpy+0x10, r2)
>     p0 = cmp.eq (r2, #0)
>     r3 = r0
> }
> if (p0) jumpr r31
> r2 = memb (r1 ++ #1)
> {
>     nop
>     memb (r3 ++ #1) = r2
> }:endloop0
> jumpr r31

Well.... you are using memb to copy one byte at a time, instead of
memd which will copy 8 bytes at a time.   So that change alone should
multiply performance by 8.

You can almost surely be more clever, and move the if statement and
the increment into a packet, so that they execute in parallel.  Its a
vliw, its very parallel, that needs to be exploited.  For example, (if
I remember correctly (?)) you can set and read r2 in the same packet,
the read will get the old value, the set will write the new value.
You can move the jumpr into the next packet, if you don't mind copying
one extra byte.   So there are many tricks like this.

I don't remember the details any longer, but there are cases where the
compiler would inline some fairly efficient memcpy code.   Also .. the
compiler is smart, in general --  you should try writing the loop in C
(and using 64-bit words) and seeing what it generates.

And finally, aren't there some optimized memcpy assembly routines in
the kernel? I know we kept talking about these...

--linas
