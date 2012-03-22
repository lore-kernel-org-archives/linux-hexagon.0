From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: Hexagon binutils and gcc
Date: Wed, 21 Mar 2012 23:34:40 -0500
Message-ID: <CAHrUA369ZoSDg3rJ9mbpCucR5zuwGNzKjS4CsxrSRQJyr3Puog@mail.gmail.com>
References: <27970.1332238362@redhat.com> <20120322001451.GA11553@codeaurora.org>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ofempSKUkkAtBIQTWRK+pkUgou+5HjBz6uykjHOyRsg=;
        b=zhSzApA/bLOCsQ2eqHOmmdA1CY7MVVWtEpyfh3XH3dAZiEqGXCqLGK6ZtL+6qEvYJW
         DVn0l6s07OPyEB1LMiSdg0tV6XUyTr2KM0Z4i/HCf6tgSAGIPW0pINzg6WiPdBQq6UwC
         APe8T+8h4g6+5+wokN0xzAZDiK6tvJF67gB9lmbBWw2EvIK70ngJyNojBTIQVjNfqwr1
         3eKjOCU+YP1wJgelQmxXlxjrXlpR+WcTxh2a8umeB0OgVDhMRGmc2z/dak9cGlFgoYVc
         95FfENOXosSl0bYas6BMJiMhuyV9jc/+Ws/OzIfKJuB/YyWphu9TgIaTdi8flwo3wz/x
         fzpg==
In-Reply-To: <20120322001451.GA11553@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: David Howells <dhowells@redhat.com>, linux-hexagon@vger.kernel.org

On 21 March 2012 19:14, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Tue, Mar 20, 2012 at 10:12:42AM +0000, David Howells wrote:
>> I'd like to add hexagon to my clutch of binutils and gcc cross-compi=
ler RPMs,
>> but it doesn't seem to be supported upstream yet. =C2=A0Is it likely=
 to be upstream
>> in the near future, or are there patches available I could use (I'm =
using
>> gcc-4.7 and binutils-2.22.52.0.1)?
>
> Hi David,
>
> We have full source and binaries available somewhere for earlier vers=
ions of
> gcc/binutils, but they don't exist in patch form. =C2=A0We're working=
 on upstreaming,
> but I'm thinking it might not count as "near future" for your plans. =
=C2=A0I will try
> to see if I can get a better answer for you...

A quick google search shows:

https://www.codeaurora.org/patches/quic/hexagon/4.0/

which contains the full sources for gcc-4.4 (with hexagon in it) and
binutils-2.20

This can compile the kernel for hexagon v2, v3 and v4 just fine.

There are many other directories there, and I promise you that you
will become confused if you look at them (they are for older versions
of gcc & binutils, but due to the numbering, this might not be
obvious. The 2,3,4 do *not* refer to hexagon v2,3,4...).  The one
exception to the confusion may be

https://www.codeaurora.org/patches/quic/hexagon/dev/

which, I'm proud to point out, has glibc patches that should apply
cleanly to the latest brand-spanking new glibc sources (as well as
many older sources as well), compile cleanly, and pass all but a
handful of the glibc test suite :-) OK, that was off-topic, but its
what I hacked on for a year...

-- Linas
