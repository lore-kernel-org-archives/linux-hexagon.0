From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next:master 9995/11651] fs/buffer.c:2254:5: warning:
 stack frame size (2144) exceeds limit (1024) in 'block_read_full_folio'
Date: Tue, 17 May 2022 05:48:30 +0100
Message-ID: <YoMpHlVdH+HCMhUj@casper.infradead.org>
References: <202205150051.3RzuooAG-lkp@intel.com>
 <Yn/YsTpOh898B30l@casper.infradead.org>
 <YoAlvnyjEbYV4T1L@dev-arch.thelio-3990X>
 <SN6PR02MB4205A0695B4B2543A9B981FCB8CE9@SN6PR02MB4205.namprd02.prod.outlook.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6VdXU36plQ8uaQ+VdzI8WaT/aCW7YyIgVyie8C4UwZQ=; b=Lwo8VzstY2I33pwrgT6Oe7JrVv
        2Smz0NCanGwQH4Q0AquxBcma1Btb2dQHOmtEcj4lEmlS1TYhiX5jknBJYPp2IA3KwdwEI3mzIphe1
        Rr6AgqpIRbou8hwB1Bq+4WuzkEVDjBgucpYEpR8zjDEY9ufmSukNYu2j/I/Q2p6o1gnmcV0zE4aun
        bwDdQUqGlMyOqTAifEyM/qSSHAvojyIfsmHP3Of3pM9SoNl0YFia6z01a2TIYiOrHqmg3TK7LMa6D
        8/F+jpzMCaAl2WY4sLnjY4rgeJF59syaLqIdlJMyQlASBjlj0l5y2/uVbUbrJJL8M5wKxWFK1ZMoU
        tvDoXa6w==;
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4205A0695B4B2543A9B981FCB8CE9@SN6PR02MB4205.namprd02.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@quicinc.com>
Cc: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, Linux Memory Management List <linux-mm@kvack.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Sid Manning <sidneym@quicinc.com>

On Tue, May 17, 2022 at 04:16:45AM +0000, Brian Cain wrote:
> > -----Original Message-----
> > From: Nathan Chancellor <nathan@kernel.org>
> ...
> > As a side note... Brian, is there any reason for 256K pages to exist for
> > Hexagon? This has been an option since Hexagon's introduction but is it
> > actually used? 4K pages is the default and the help text says "use with
> > caution". Perhaps the choice should be turned off altogether for
> > CONFIG_COMPILE_TEST so that we cannot select this configuration and
> > bother developers with these reports.
> 
> It's not the most commonly used page size, yeah.  Ok, we will disable it for CONFIG_COMPILE_TEST.

Maybe the stack size limit could be raised for 256KB page size?
Presumably the minimum stack size is 256KB, so it's not a problem for an
individual function to consume 16KB of stack space?
