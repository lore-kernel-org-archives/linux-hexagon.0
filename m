From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: Building a hexagon cross compiler
Date: Tue, 15 Jul 2014 14:05:32 -0500
Message-ID: <CAHrUA3677sZSn=NPcXwp8q6FzA3MKHM0PQ+W2hqufAy4Pwf3zQ@mail.gmail.com>
References: <20577.1405434250@warthog.procyon.org.uk> <CAHrUA374VW4j1tDUzss3L4Xezp0-g21b7zCYgw-2gafheaS+sQ@mail.gmail.com>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=O2+qzHXwYam9JZc9y4Jp2Gl2+8ThtIahdDisl46lRqA=;
        b=PU2gkT/vsa92f4LWk24pUveEHqjIPV1aoV3vJjNfcAYGtHleF2s/ulRKqHX/sHP9dU
         t4uWkg7oXe8eAYjxIorr70nwMtyZ8iRPkeQdWcn0DIHNI8BmIt02vQ86yIVKblOBThuQ
         uo2DZJezcuD6wBttSUVmPy65h6n2m9VsBoDLww9N/Ej5wfy23GHQAEn1JLMeGcHhCMeY
         8qytdumXs58I6aBupyOGD1RjAtKRJnjxOKUNwldJGoYGR1iwdeJGC0ScuInCDM9x2n+5
         CIgD3+37rP/XctlsGaKp2Pn9h2KCNCVZG71rqvlIURFa73uCuGMvhp81WGDo8qhQQOHA
         9vHg==
In-Reply-To: <CAHrUA374VW4j1tDUzss3L4Xezp0-g21b7zCYgw-2gafheaS+sQ@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, richard.weinberger@gmail.com

Resending, with the html markup turned off.

--linas

> On 15 July 2014 09:24, David Howells <dhowells@redhat.com> wrote:
>>
>> Hi Richard,
>>
>> I'd like to build a Hexagon cross-compiler to go with the other Fedora cross
>> compilers that I have.  I don't see support in binutils-2.24 and gcc-4.9.0
>> though.  Do I take it that Hexagon has its own special cross compiler build?
>>

On 15 July 2014 14:03, Linas Vepstas <linasvepstas@gmail.com> wrote:
>
> If I remember correctly, Mentor's Code Sourcercy division was supposed to be maintaining and merging the hexagon gcc patches upstream. glibc too. Last time I used this (many years ago) it all worked great, with almost all of the glibc test suite passing, including the wild tangle of thread-local storage, thread joins, thrown exceptions, stack unwinding, gdb and signals all happening at the same time. There were only a handful of rare, obscure cases that didn't pass.  I know, as I did the work to make this all go.
>
> I hope all this work isn't slowly being lost ...
>
> --linas
