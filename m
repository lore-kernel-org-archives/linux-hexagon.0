From: Rob Landley <rob@landley.net>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Mon, 25 Feb 2013 11:26:46 -0600
Message-ID: <1361813206.27287.1@driftwood>
References: <CAHrUA36YTCfedZGxBa+Vgzvz=DBR=PJhcPHe0aZegQiD79gHXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <CAHrUA36YTCfedZGxBa+Vgzvz=DBR=PJhcPHe0aZegQiD79gHXQ@mail.gmail.com>
	(from linasvepstas@gmail.com on Sun Feb 24 15:03:37 2013)
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="Flowed"
To: linasvepstas@gmail.com
Cc: cotulla@yandex.ua, linux-hexagon@vger.kernel.org

On 02/24/2013 03:03:37 PM, Linas Vepstas wrote:
> > Yes, there is an optimized memcpy version.
> > But my goal was to "compare" ARM performance with QDSP6 to know  
> what to wait from it.
> > So I made a simple C code and tested it on both processors.

You're comparing arm performance with QDSP6 by writing pessimal QDSP6  
code that does single-byte moves and keeps half the execution units  
idle. You're going to get some extremely useful numbers out of that,  
aren't you? (Even their uClibc port had an assembly optimized  
memmove().)

Is your arm code also doing single byte moves, with the requisite  
bit-shifting and masking that doing that on arm entails (since last I  
checked arm hasn't actually _got_ instructions that handle bytes,  
although maybe it went into thumb2 or v7 or v8 when I wasn't  
looking...)?

> > Did you test performance inside Linux on Hexagon?
> 
> Yes ... the main result was that it was TLB-starved.  They guys
> designing it are performance and watts-per-cycle crazy, they're very
> devoted to optimizing this stuff, to getting the most per transistor
> possible. Its a very tiny core with very few transistors.  I mean, its
> probably smaller than the ARM register file (OK, I'm just making this
> last one up, but I'm guessing it just might be true, I wouldn't be
> surprised.).

Specifically, the v2 hardware (in the snapdragon chipset in the Nexus  
One) has 6 register profiles (for the 6 pipeline stages, acting as  
6-way SMP) but performance peaked at "make -j 3" which ran very  
slightly faster than "make -j 4", and then -j 5 and -j 6 were each  
noticeably slower (due to TLB thrashing).

I believe that v3 had already taped out by then (late 2010, but it had  
fewer pipeline stages and thus register profiles anyway), and then v4  
was going to increase the TLB entries. What actually shipped was after  
my time, dunno the details.

Rob