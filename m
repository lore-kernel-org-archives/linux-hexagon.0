From: rkuo <rkuo@codeaurora.org>
Subject: Re: Building a hexagon cross compiler
Date: Mon, 21 Jul 2014 15:43:06 -0500
Message-ID: <20140721204306.GA22381@codeaurora.org>
References: <20577.1405434250@warthog.procyon.org.uk>
 <CAHrUA374VW4j1tDUzss3L4Xezp0-g21b7zCYgw-2gafheaS+sQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHrUA374VW4j1tDUzss3L4Xezp0-g21b7zCYgw-2gafheaS+sQ@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linas Vepstas <linasvepstas@gmail.com>
Cc: David Howells <dhowells@redhat.com>, linux-hexagon@vger.kernel.org, richard.weinberger@gmail.com

On Tue, Jul 15, 2014 at 02:03:02PM -0500, Linas Vepstas wrote:
> If I remember correctly, Mentor's Code Sourcercy division was supposed to
> be maintaining and merging the hexagon gcc patches upstream. glibc too.
> Last time I used this (many years ago) it all worked great, with almost all
> of the glibc test suite passing, including the wild tangle of thread-local
> storage, thread joins, thrown exceptions, stack unwinding, gdb and signals
> all happening at the same time. There were only a handful of rare, obscure
> cases that didn't pass.  I know, as I did the work to make this all go.
> 
> I hope all this work isn't slowly being lost ...
> 
> --linas
> 
> 
> 
> On 15 July 2014 09:24, David Howells <dhowells@redhat.com> wrote:
> 
> > Hi Richard,
> >
> > I'd like to build a Hexagon cross-compiler to go with the other Fedora
> > cross
> > compilers that I have.  I don't see support in binutils-2.24 and gcc-4.9.0
> > though.  Do I take it that Hexagon has its own special cross compiler
> > build?
> >
> > David
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-hexagon" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


Sorry for the late response.  As Linas mentioned, Mentor maintains the that
set of tools.  That latest version that was released can be found here:

https://sourcery.mentor.com/GNUToolchain/release2800

I haven't had a chance to test these tools myself though.

Hope that helps.

-Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
